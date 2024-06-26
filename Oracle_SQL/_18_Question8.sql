--1) 송강 교수가 강의하는 과목을 검색한다
SELECT pno, pname, cname
FROM professor
NATURAL JOIN course
WHERE pname='송강';

SELECT pno, pname, cname
FROM professor
JOIN course USING(pno)
WHERE pname='송강';

--2) 화학 관련 과목을 강의하는 교수의 명단을 검색한다
SELECT pno, pname, cname
FROM professor
NATURAL JOIN course
WHERE cname LIKE '%화학%';

SELECT pno, pname, cname
FROM professor
JOIN course USING(pno)
WHERE cname LIKE '%화학%';

--3) 학점이 2학점인 과목과 이를 강의하는 교수를 검색한다
SELECT pno, pname, cname, st_num
FROM professor
NATURAL JOIN course
WHERE st_num=2;

SELECT pno, pname, cname, st_num
FROM professor
JOIN course USING(pno)
WHERE st_num=2;

--4) 화학과 교수가 강의하는 과목을 검색한다
SELECT pno, pname, section, cname
FROM professor
NATURAL JOIN course
WHERE section='화학';

SELECT pno, pname, section, cname
FROM professor
JOIN course USING(pno)
WHERE section='화학';

--5) 화학과 1학년 학생의 기말고사 성적을 검색한다
SELECT sno, sname, major, syear, cname, result
 FROM student
 JOIN score USING(sno)
 JOIN course USING(cno)
 WHERE major='화학' AND syear=1;

-- tutor answer2
SELECT major, syear, sno, sname, cno, result
FROM student
NATURAL JOIN score
WHERE major='화학' AND syear=1;

--6) 일반화학 과목의 기말고사 점수를 검색한다
SELECT sno, sname, cname, result
 FROM student
 JOIN score USING(sno)
 JOIN course USING(cno)
 WHERE cname='일반화학';

 -- tutor answer2
SELECT sno, result
FROM score
NATURAL JOIN course
WHERE cname='일반화학';

--7) 화학과 1학년 학생의 일반화학 기말고사 점수를 검색한다
SELECT sno 학번, sname 이름, major 학과, syear 학년, cname 과목명, result
FROM student
 JOIN score USING(sno)
 JOIN course USING(cno)
 WHERE major='화학' AND syear=1 AND cname='일반화학';

 -- tutor answer2
 SELECT major, syear, sno, sname, cname, result
FROM student
NATURAL JOIN score
NATURAL JOIN course
WHERE major='화학' AND syear=1 AND cname='일반화학';

--8) 화학과 1학년 학생이 수강하는 과목을 검색한다
SELECT DISTINCT major 학과, syear 학년, cname 과목
 FROM student
 JOIN score USING(sno)
 JOIN course USING(cno)
 WHERE major='화학' AND syear=1;

 -- tutor answer2
 SELECT DISTINCT cname
FROM student
NATURAL JOIN score
NATURAL JOIN course
WHERE major='화학' AND syear=1;