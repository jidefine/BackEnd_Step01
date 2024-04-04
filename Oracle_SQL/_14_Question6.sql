--1) 송강 교수가 강의하는 과목을 검색한다
SELECT professor.pno, pname, cname
FROM professor, course
WHERE pname='송강' AND professor.pno=course.pno;

--2) 화학 관련 과목을 강의하는 교수의 명단을 검색한다
SELECT professor.pno, pname, cname
FROM professor, course
WHERE cname LIKE '%화학%' AND professor.pno=course.pno;

--3) 학점이 2학점인 과목과 이를 강의하는 교수를 검색한다
SELECT professor.pno, pname, cname, st_num
FROM professor, course
WHERE st_num=2 AND professor.pno=course.pno;

--4) 화학과 교수가 강의하는 과목을 검색한다
SELECT professor.pno, pname, section, cname
FROM professor, course
WHERE professor.pno=course.pno AND section='화학';

--5) 화학과 1학년 학생의 기말고사 성적을 검색한다
SELECT student.sno, sname, major, syear, cname, score.result
 FROM student, score, course
 WHERE student.sno=score.sno AND course.cno=score.cno AND major='화학' AND syear=1;

--6) 일반화학 과목의 기말고사 점수를 검색한다
SELECT student.sno, sname, cname, score.result
 FROM student, score, course
 WHERE student.sno=score.sno AND course.cno=score.cno AND cname='일반화학';

--7) 화학과 1학년 학생의 일반화학 기말고사 점수를 검색한다
SELECT student.sno, sname, major, syear, cname, score.result
 FROM student, score, course
 WHERE student.sno=score.sno AND course.cno=score.cno AND major='화학' AND syear=1 AND cname='일반화학';

--8) 화학과 1학년 학생이 수강하는 과목을 검색한다
SELECT DISTINCT major, syear, cname
 FROM student, score, course
 WHERE student.sno=score.sno AND course.cno=score.cno AND major='화학' AND syear=1;

--9) 유기화학 과목의 평가점수가 F인 학생의 명단을 검색한다
SELECT student.sno, sname, major, syear, cname, result, scgrade.grade
 FROM student, score, course, scgrade
 WHERE student.sno=score.sno AND course.cno=score.cno AND cname='유기화학' AND result BETWEEN loscore AND hiscore AND grade='F';