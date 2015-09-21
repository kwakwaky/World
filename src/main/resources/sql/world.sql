
select count(*) from city;
select * from city;
select * from country;
select * from countrylanguage;

 ' 문제 : KOR 의 City 정보를 출력하시오
	
	country
 '

select name from city where countrycode = 'kor';

select city.name, city.population, country.indepyear  from city, country where city.countrycode=country.code and city.countrycode='kor';

select * from city where countrycode = 'dza'

--
-- char(10)			255max
-- varchar(10)		255max
-- longvarchar	- oracle ==> long, mysql ==> text, mediumtext 
-- clob			- oracle ==> clob, mysql ==> longtext

-- numeric(10,2)
-- decimal(10,2)

-- Timestamp (날짜 시간) - oracle ==> date, musql =darrttion
-- Date (함수)
-- Time (시작)

select * from dept
select * from emp
select * from bonus
select * from salgrade

delete from dept
delete from emp

drop table dept;

create table dept (
	deptno numeric(2) not null,
	dname varchar(14),
	loc varchar(13),
	constraint pk_dept primary key (deptno)
) engine=InnoDB default charset=utf8;

drop table emp;

create table emp (
	empno numeric(4),
	ename varchar(10),
	job varchar(9),
	mgr numeric(4),
	hiredate timestamp,
	sal numeric(7,2),
	comm numeric(7,2),
	deptno numeric(2),
	constraint pk_emp primary key (empno),
	constraint fk_deptno foreign key (deptno) references dept (deptno)
) engine=InnoDB default charset=utf8;

drop table bonus;

create table bonus (
	ename varchar(10),
	job varchar(9),
	sal numeric,
	comm numeric
) engine=InnoDB default charset=utf8;

drop table salgrade;

create table salgrade (
	grade numeric,
	losal numeric,
	hisal numeric 
) engine=InnoDB default charset=utf8;

-- totalItem
select count(*) from city;	 

-- limit start, count ==> start 0, 1, 2 ...

-- ? start ==> fristItem - 1
-- ? count ==> lastItem - firstItem + 1

-- 1 page : 1 ~ 10 	==> 0 ~ 9
-- 2 page : 11 ~ 20 ==> 10 ~ 19
select *
  from city
 limit 0, 10;
 -- a번째부터, b만큼 가져옴

create table filelist (
	fname			varchar(50) primary key,
	flength			numeric(10),
	flast_modified	datetime,
	image			longblob
);

select * from filelist

drop table filelist


 /*
  * Member Table 생성
  * 
  * email		xxx@yyy.com		(regex)
  * password	영문 and 숫자 and 6자리 이상 and not 3자리 이상 반복
  * 			암호(encryption) ==> MD5, SHA-256 (단방향, 복호화가 안되는 알고리즘)
  */
 
 select * from member;

 drop table member;
 create table member (
 	id			int not null auto_increment,
 	email		varchar(64) not null,
 	password	varchar(64) not null,
 	name		varchar(12) not null,
 	regdate		timestamp not null,
 	constraint member_pk primary key (id, email),
 	constraint mamber_id_uq unique (id),
 	constraint mamber_email_uq unique (email)
 );
 
 alter table member auto_increment = 1000;
 
  -- email이 중복되더라도 id가 중복이 안되기 때문에 반복입력 가능 --
 insert into member 
 (email, password, name)
 value
 ('hong@naver.com', '1234', '홍길동');
 
 insert into member 
 (email, password, name, regdate)
 value
 ('kim@naver.com', '12''34', '김길동', '2015/08/11');
 
  select * from member;
 update member set name = '박길동' where id = 1001;

 
 /*
  * id generator
  */
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
 
 drop table member2
 select * from member2;
 create table member2 (
 	id			int not null,
 	email		varchar(64) not null,
 	password	varchar(64) not null,
 	name		varchar(12) not null,
 	regdate		timestamp not null,
 	constraint member2_pk primary key (id, email),
 	constraint mamber2_id_uq unique (id),
 	constraint mamber2_email_uq unique (email)
 );
 
 rollback;
 
 /*
  * pagination
  */
 
 select * from city
  where countrycode = 'kor'
  order by name
  limit 10, 10;
  
  /*
   * District 분석
   */

  select *
  	from city
   where countrycode = 'kor';
   
  select distinct district
  	from city
   where countrycode = 'kor';
   
   select code, name
	  from country;