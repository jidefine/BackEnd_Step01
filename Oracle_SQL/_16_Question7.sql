--1) 학생중에 동명이인을 검색한다
SELECT s.sno "학번", t.sname "이름", t.major "전공"
FROM student s, student t
WHERE s.sno!=t.sno AND s.sname=t.sname
ORDER BY s.sname;

--2) 전체 교수 명단과 교수가 담당하는 과목의 이름을 학과 순으로 검색한다
SELECT p.pno, p.pname, p.section, c.cname
FROM professor p, course c
WHERE p.pno=c.pno(+)
ORDER BY p.section;

--3) 이번 학기 등록된 모드 과목과 담당 교수의 학점 순으로 검색한다
SELECT c.cno, c.cname, c.st_num, p.pname
FROM course c, professor p
WHERE p.pno(+)=c.pno
ORDER BY c.st_num;