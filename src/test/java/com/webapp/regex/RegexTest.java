package com.webapp.regex;

import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexTest {
	
	/*
	 * 문자열 검색, 대체, 추출 ==> 정규표현식 (Regular Expression)
	 * 
	 * . ==> new line문자를 제외한 모든 문자 (1 문자에 대해)
	 * ^ ==> Line Start
	 * $ ==> Line End					ex) ^.$ ==> 1개의 아무 문자만 허용
	 * * ==> 앞문자가 0개 이상 반복			ex) ^A*$ ==> A라는 문자가 0개 이상 반복되면 true
	 * + ==> 앞문자가 1개 이상 반복			ex) ^A+$ ==> A라는 문자개 1개 이상 반복되면 true
	 * [] ==> 올 수 있는 1개의 문자들을 나열	ex) ^[AYZ]$ ==> A : true, Y : true, AA : false, AYZ : false
	 * 		  one char 부분집합			ex) ^[A-Z]$ ==> A ~ Z 중 1개의 문자일 때만 true
	 * 									ex) ^[A-Z0-9]$ ==> A : true, 0 : true, A0 : false
	 * {n} ==> 앞문자가 n개 반복			ex) ^[A-Z0-9]{1,3}$ ==> A3 : true, A0B :true, A01B : false
	 * {n,} ==> 앞문자가 n개 이상 반복
	 * {n,m} ==> 앞문자가 n 이상 m 이하		ex) ^[가-힣]{3,5}$ ==> 한글 3자리 부터 5자리 까지 허용, '가-힣' 임을 주목
	 * 									ex) ^[ㄱ-힣]{3,5}$ ==> 자음만 있는 거도 허용
	 *
	 * [A-Za-z]{3} ==> 한 라인에서 영문자가 3자리 이상 반복되는 그룹이 하나라도 있으면 true
	 * 
	 *
	 *
	 */

	
	public static void main(String[] args) {
		
		// 02-333-4444
		// 011-333-4444
		// 010-3333-4444
		
		Scanner scan = new Scanner(System.in);
		
//		String regex = "^.$";
		String regex = "";
		while(true) {
			System.out.print("입력 : ");
			String line = scan.nextLine();
			
			System.out.println("line = [" + line + "]");
			Pattern pattern = Pattern.compile(regex);
			Matcher m = pattern.matcher(line);
			
			System.out.println("match = " + m.find());
//			System.out.println("match = " + Pattern.matches(regex, line));
			
		}

		
		
		
	}

}
