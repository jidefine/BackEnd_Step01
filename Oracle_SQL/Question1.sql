--5) 모든 학생의 정보를 검색해라
SELECT *
FROM STUDENT;

--7) 모든 과목의 정보를 검색해라
SELECT *
FROM COURSE;

--8) 기말고사 시험점수를 검색해라
SELECT avr
FROM STUDENT;

--9) 학생들의 학과와 학년을 검색해라
SELECT major, syear
FROM STUDENT;

--10) 각 과목의 이름과 학점을 검색해라
SELECT cname, st_num
FROM COURSE;

--11) 모든 교수의 직위를 검색해라
SELECT orders
FROM professor;

-------------------------------------------------------

--1) 각 학생의 평점을 검색하라(별명을 사용)
SELECT avr AS "평점"
FROM student;

--2) 각 과목의 학점수를 검색하라(별명을 사용)
SELECT st_num AS "학점수"
FROM COURSE;

--3) 각 교수의 지위를 검색하라(별명을 사용)
SELECT orders
FROM professor;

--4) 급여를 10%인상했을 때 연간 지급되는 급여를 검색하라(별명을 사용)
SELECT eno, ename, (sal*1.1) AS "현재 급여 + 10% 인상"
FROM emp;

--5) 현재 학생의 평균 평점은 4.0만점이다. 이를 4.5만점으로 환산해서 검색하라(별명을 사용)
SELECT avr+0.5 AS "평균 평점"
FROM student;

-------------------------------------------------------

--1) '__학과인 __학생의 현재 평점은 __입니다' 형태로 학생의 정보를 출력하라
SELECT major||'학과인 '||sname||'학생의 현재 평점은 '||avr||'입니다' AS "학생 정보"
FROM student;

--2) '__과목은 __학점 과목입니다.' 형태로 과목의 정보를 출력하라
SELECT cname||'과목은 '||st_num||'학점 과목입니다.' "과목 정보"
FROM COURSE;

--3) '__교수는 __학과 소속입니다.' 형태로 교수의 정보를 출력하라
SELECT pname||'교수는 '||section||'학과 소속입니다.' "교수 정보"
FROM professor;

--4) 학교에는 어떤 학과가 있는지 검색한다(학생 테이블 기반으로 검색한다)
SELECT DISTINCT major
FROM student;

--5) 학교에는 어떤 학과가 있는지 검색한다(교수 테이블 기반으로 검색한다)
SELECT DISTINCT section
FROM professor;

--6) 교수의 지위는 어떤 것들이 있는지 검색한다
SELECT DISTINCT orders
FROM professor;