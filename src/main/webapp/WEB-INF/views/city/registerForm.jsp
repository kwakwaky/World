<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>registerForm.jsp</title>
<%@ include file="/WEB-INF/views/common.jspf" %>

<style type="text/css">
	.form-center {
		padding: 20px;
		margin: auto;
		border: 1px solid #BDBDBD;
		border-radius: 10px;
		width: 400px;
	}
 	.box { 
 		width: 75px; 
 		height: 113px; 
  		background-size: 100% 100%;
  		float: left;
	}
	
	#wrap {
		font-family: 맑은 고딕;
	}
</style>




</head>
<body>
<div id="wrap" align="center">

<!-- id="command" action="/World/city/register" method="post" 이게 자동으로 들어감 -->
<form:form commandName="city" action="register" method="post" cssClass="form-center"> <!-- 에러처리를 위해 스프링form태그를 사용한다. -->
	
	<strong style="font-size: large; margin: 20px;">
	<spring:message code="city.register.title" arguments="[World]"/>
	</strong>
	
	<!-- Global Error -->
	<div class="text-danger text-center"><form:errors/></div>
	
	<!-- city.name -->
	<div class="form-group">
		<spring:message code="city.name" var="name"/>
		<form:errors path="name" class="text-danger"/>
		<form:input path="name" cssClass="form-control" placeholder="${name}"/>
	</div>
	
	<!-- city.countryCode -->
	<div class="form-group">
		<label for="countryCode"><spring:message code="city.countryCode"/></label>
		<form:errors path="countryCode" class="text-danger"/>
<%-- 		<form:input path="countryCode" cssClass="form-control" placeholder="${countryCode}"/> --%>
		<form:select path="countryCode" cssClass="form-control">
			<form:option value="">-- 선택하세요 --</form:option>
			<form:options items="${countryCode}" itemValue="code" itemLabel="name"/>
		</form:select>
	</div>
	
	<!-- city.district -->
	<div class="form-group">
		<label for="district"><spring:message code="city.district"/></label>
		<form:errors path="district" class="text-danger"/>
<%-- 		<form:input path="district" cssClass="form-control" placeholder="${district}"/> --%>
		<form:select path="district" cssClass="form-control">
			<form:option value="">-- 선택하세요 --</form:option>
			<form:options items="${districts}"/>
		</form:select>
	</div>
	
	<!-- city.population -->
	<div class="form-group" style="">
		<label for="population"><spring:message code="city.population"/></label>
		<form:errors path="population" class="text-danger"/>
		<form:input path="population" cssClass="form-control"/>
	</div> 						<!-- population 자리에 에러가 있으면 프로퍼티에 있는 해당 에러의 값을 출력 -->
	
	<input class="btn btn-default" type="submit" value="도시 추가">
	
</form:form>

<c:forEach var="i" begin="837" end="884">
	<div class="box"><img src="/World/image/${i}.jpg"></div>
</c:forEach>




<script type="text/javascript">
	var form = jQuery('.form-center').draggable();
	form.draggable();
	form.mousedown(function() {
		console.log("form.mousedown()...");
		$(this).css('box-shadow', '20px 20px 10px red');
	});
	
	form.mouseup(function() {
		console.log("form.mouseup()...");
		$(this).css('box-shadow', '');
	});
	
	$('#countryCode').change(function() {
		var countryCode = $(this).val();
//		alert("change event called... value = " + $(this).val());
		console.log("change event called..."  + $(this).val());
		
		// jQuery의 전역함수. Ajax (Asyncronous javascript and xml)
		$.get('district/' + countryCode , function(data, status) { 
//			alert("data = " + data + "\n" + "status" + status);
			console.log("data = " + data + "\n" + "status" + status);
			$('#district').html(data); // html에 연결시켜줌
		});
	});
	
	
	$('.box').draggable();
	
	
	
</script>


</div>
</body>
</html>