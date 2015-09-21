 
 mvn install:install-file -Dfile=ojdbc6.jar -DartifactId=ojdbc6 -DgroupId=com.oracle -Dversion=11.2.0 -Dpackaging=jar

select * from DEPT;
 select * from EMP;
 select * from BONUS;
 select * from SALGRADE;

 --Inner Join1
 select *
   from dept inner join emp
     on dept.deptno = emp.deptno;
    
 --Inner Join 1.5
 select dept.deptno, dept.dname, emp.ename, emp.hiredate
   from dept inner join emp
     on dept.deptno = emp.deptno
  order by dept.deptno desc;

 --join1과 join2의 결과는 동일하다.
 --join2.5의 방식이 많이 쓰임.
 
 --Inner Join2
 select *
   from dept, emp
  where dept.deptno = emp.deptno;
 
 --iner Join2.5
 select d.deptno, d.dname, e.ename, e.hiredate
   from dept d, emp e
  where d.deptno = e.deptno
  order by d.deptno desc;
  
 --Left Outer Join / 오른쪽이 다 나오게 함.
 select d.deptno, d.dname, e.ename, e.hiredate
   from dept d left outer join emp e
     on d.deptno = e.deptno
  order by d.deptno desc;
  
 -- 1. emp에 직원을 추가하시오.
 --	   empno = 8000
 --    ename = 홍길동
 --    job = developer
 --    ...
 --    deptno = 80
 --    dname = 총무부
 --    dloc = 서울
 
 insert into dept values (80,'총무부','서울');
 insert into emp values (8000,'홍길동','developer',null,'1985-01-01',5000,null,80);
 
 -- 2. dept정보를 수정하시오.
 --    deptno = 20
 --    dname = 개발부
 --	   loc = 부산
 
 update dept set dname = '개발부', loc ='부산' where deptno = 20
 
 -- 3. 직원정보를 삭제하시오.
 --	   empno >= 7300 and empno <= 7600
 
 delete from emp where empno >= 7300 and empno <= 7600;
 
 -- 4. 부서별 직원정보를 출력하시오. (단 모든 부서를 출력)
 
 select *
   from dept d left outer join emp e
     on d.deptno = e.deptno
  order by d.deptno desc;
  
 -- 5. 부서별 직원리스트
 -- 부서직원 평균을 구하시오.
 -- 총무부 avr max min
 -- 개발부  
 
 delete from emp where empno = 1000
 
  commit
  rollback
  
 insert into emp
 (
 	empno,
 	ename,
 	job,
 	mgr,
 	hiredate,
 	sal,
 	deptno
 )
 values
 (
 	1000,
 	'김길동',
 	'developer',
 	1234,
 	'2015/09/10',
 	300.2,
 	10
 )
 
 delete from emp where empno=9300
 
 insert into emp
 (
 	empno,
 	ename,
 	job
 
 )
 values
 (
 	1000,
 	'테스터',
 	'test'
 )
 
 insert into dept values (0, null, '무인도')
 delete from dept where deptno = 0
 
 select * from city
 select * from country
 select * from COUNTRYLANGUAGE
 
-- city ----------------------
drop table city
 
create table city (
	id 			numeric(11) not null,
	name 		char(40) 	default '',
	countrycode char(3)	 	default '',
	district 	char(30) 	default '',
	population 	numeric(11) default 0,
	constraint pk_city primary key (id),
	constraint fk_country foreign key (countrycode) references country(code)
);

-- country ------------------------
drop table country

create table country (
	code			char(3) 		default '',
	name			char(52) 		default '',
	continent		char(20) 		default 'asia',
	region 			char(26) 		default '',
	surfacearea 	numeric(10,2) 	default '0.00',
	indepyear 		numeric(6) 		default null,
	population 		numeric(11) 	default '0',
	lifeexpectancy 	numeric(3,1) 	default null,
	gnp 			numeric(10,2) 	default null,
	gnpold 			numeric(10,2) 	default null,
	localname 		char(50) 		default '',
	governmentform 	char(45) 		default '',
	headofstate 	char(60) 		default null,
	capital 		numeric(11) 	default null,
	code2 			char(2) 		default '',
	constraint ck_continent check (continent in ('asia','europe','north america','africa','oceania','antarctica','south america')),
	constraint pk_country primary key (code)
);


-- countryLanguage ------------------------
drop table countrylanguage

create table countrylanguage (
	countrycode char(3) 	 default '',
	language 	char(30) 	 default '',
	isofficial	char(1) 	 default 'f',
	percentage 	numeric(4,1) default '0.0',
	constraint ck_isofficial check (isofficial in ('t','f')),
	constraint pk_countrylanguage primary key (countrycode, language)
);


create table filelist (
	fname			varchar(50) primary key,
	flength			numeric(10),
	flast_modified	date,
	image			blob
);

select fname, from filelist

select * from dept

delete from dept where deptno = 80

update dept
   set dname = 'xxxx',
   	   loc	 = 'yyyy'
 where deptno = 90;

 
 
 /*
  * Member Table 생성
  */
 
 select * from member;
 drop table member;
 create table member (
 	id			int not null,
 	email		varchar(64) not null,
 	password	varchar(64) not null,
 	name		varchar(12) not null,
 	regdate		timestamp not null,
 	constraint member_pk primary key (id, email), -- primary키는 table당 1개만 --
 	constraint mamber_id_uq unique (id),
 	constraint mamber_email_uq unique (email)
 );
 
 /*
  * 채번, 발번
  */
 
 drop sequence member_id_seq;
 create sequence member_id_seq
 start with 1000;
 
 select member_id_seq.nextval from dual;
 select member_id_seq.currval from dual; -- 현재 value --
 
 insert into member
 (id, email, password, name, regdate)
 values
 (member_id_seq.nextval, 'kim@naver.com1', '12''34', '김길동', '2015/08/11');
 
 select last_insert id();

 
 /*
  * id generator
  */
 
 select * from member2;
 select * from ID_GENERATOR;
 
 drop table id_generator;
 create table id_generator (
 	name	varchar(20) not null primary key,
 	nextval numeric(10) not null,
 	incval	numeric(5) 	not null
 );
 
 insert into id_generator
 (name, nextval, incval)
 values
 ('memberId', 10000, 100);
 
 drop table member2;
 create table member2 (
 	id			int not null,
 	email		varchar(64) not null,
 	password	varchar(64) not null,
 	name		varchar(12) not null,
 	regdate		timestamp not null,
 	constraint member2_pk primary key (id, email), -- primary키는 table당 1개만 --
 	constraint mamber2_id_uq unique (id),
 	constraint mamber2_email_uq unique (email)
 );
 
 /*
  * update 고려사항
  */
 
 select * from member;
 
 update member
	   set email 	= null,
	   	   password = null,
	  	   name		= null,
	  	   regdate 	= null
	 where id		= #{id}
 
 update member
	   set password = 'abcd'
	 where id		= 10101
	 
 update member
	 where id		= 10100;
	 
 /*
  * Pagination
  */
 select outer.*
 from (select rownum rn, inner.*
    	 from (select e.*
    	     	 from emp e
    	   	 	order by e.ename
   		 	  ) inner 
 	  ) outer
 where outer.rn >= 5
   and outer.rn <= 10
   
  select outer.rn,
  		 outer.id,
  		 outer.email,
  		 outer.password,
  		 outer.name,
  		 outer.regdate
    from (select rownum rn, inner.*
    	    from (select m.*
    	     	    from member m
    	   	 	   order by m.id desc
   		 	     ) inner 
 	     ) outer
   where outer.rn >= 21
     and outer.rn <= 30
   		
 
 