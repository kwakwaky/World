package com.webapp.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.webapp.command.CityCommand;
import com.webapp.command.Code;
import com.webapp.mapper.CityMapper;
import com.webapp.mapper.CountryMapper;
import com.webapp.model.City;
import com.webapp.validator.CityCommandValidator;

@Controller
@RequestMapping("/city")
public class CityController {
	
	static Log log = LogFactory.getLog(CityController.class);
	
	@Autowired // 스캔하면서 이걸보고 인젝션 시켜줌
	CountryMapper countryMapper;
	@Autowired
	CityMapper cityMapper;
	
	@Autowired
	CityCommandValidator validator;
	
	String getCities() {
		return "";
	}
	
	@RequestMapping("/district/{countrycode:[A-Z]{3}}") // 현대적인 방식
	String getDistricts(@PathVariable String countrycode, Model model) {
		log.info("getDistricts() ... countryCode = " + countrycode);
		
		List<String> districts = cityMapper.selectDistricts(countrycode);
		
		model.addAttribute("districts", districts);
	
		return "city/districts";
	}
	
	@RequestMapping // 쿼리스트링을 이용
	String listByParameter(String countrycode, Model model) {
		model.addAttribute("countrycode", countrycode);
		
		List<Code> list = countryMapper.selectCodes();
		for (Code c : list) {
			log.info("code = " + c.getCode() + " " + "name = " + c.getName());
		}
		
		return "city/list";
	}
	
	@RequestMapping("/list")  // view를 return안하면 url를 view로 return한다.
	void listByParameter(HttpServletRequest request, Model model) {
		String countrycode = request.getParameter("countrycode");
		log.info("requestURI = " + request.getRequestURI());
		model.addAttribute("countrycode", countrycode);
	}
	
	@ModelAttribute("countryCode")
	List<Code> getCountryCode() {
		
		List<Code> model = countryMapper.selectCodes();
		log.info("getCountryCode()... size = " + model.size());
		return model;
	}
	
	@ModelAttribute("districts") // 해당 메서드를 호출해서 request영역객체에 담긴다.
	List<String> getDistricts(String countryCode) { // 파라미터에 countryCode가 있으면 바인딩된다.
		
		List<String> model = cityMapper.selectDistricts(countryCode);
		log.info("getDistricts()... size = " + model.size());
		return model;
	}
	
	
	@RequestMapping(value="/register", method=RequestMethod.GET)
	String registerForm(@ModelAttribute("city") CityCommand command) { 
		log.info("registerForm()...");
		return "city/registerForm";		
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	String register(@ModelAttribute("city") CityCommand command, Errors errors, Model model) { // Errors객체가 command객체에 합쳐짐
		log.info("/register() POST...");
		
		/*
		 * CityCommand Validation
		 */
		validator.validate(command, errors);
		
//		FieldError e = errors.getFieldError("name");
//		String[] codes = e.getCodes();
//		for (String s : codes) {
//			log.info("[" + s + "]");
//		}
		
		if (errors.hasErrors()) {
			
			errors.reject("city.register", new Object[] {command.getName()}, "City Global error");	// Global error
			return "city/registerForm";
		}
		
		/*
		 * DB Register ==> Service를 사용해서 처리 (dao를 통해 영속화 처리)
		 */
		
		City city = command.getCity();
		log.info("#### id = " + city.getId());
		cityMapper.insert(city);
		model.addAttribute("city", city); // 오버라이드 됨
		
		
		
		return "city/registerSuccess";
	}
															  // 에러스 객체는 반드시 command객체 뒤에 있어야함
	@RequestMapping("/modify")								  // 바인딩할때 에러나도 command에 default값 넣어줌
	String modify(@ModelAttribute("city") CityCommand command, Errors errors) {
		
		if (errors.hasFieldErrors()) {
			List<FieldError> fieldErrors =  errors.getFieldErrors();
			for (FieldError fe : fieldErrors) {
				log.info("field = " +fe.getField());
				log.info("objectName = " + fe.getObjectName());
				log.info("code = " + Arrays.toString(fe.getCodes()));
				log.info("rejectedValue = " + fe.getRejectedValue());
			}
		}
		return "city/modify";
	}
	

}
