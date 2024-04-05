[JOIN ON 절로 해결]

1) 각 과목의 과목명과 담당 교수의 교수명을 검색하라
SELECT cno, cname, p.pno, pname 
FROM course c
Join professor p on c.pno=p.pno;

2) 화학과 학생의 기말고사 성적을 모두 검색하라
SELECT st.sno, sname, major, co.cname, result
FROM student st
JOIN score sc on st.sno=sc.sno
JOIN course co on sc.cno=co.cno
WHERE major='화학'
ORDER BY sname;

3) 유기화학과목 수강생의 기말고사 시험점수를 검색하라
SELECT st.sno, sname, major, co.cname, result
FROM student st
JOIN score sc on st.sno=sc.sno
JOIN course co on sc.cno=co.cno
WHERE co.cname='유기화학'
ORDER BY co.cname;

4) 화학과 학생이 수강하는 과목을 담당하는 교수의 명단을 검색하라
SELECT DISTINCT p.pno, pname, major, co.cname
FROM student st
JOIN score sc on st.sno=sc.sno
JOIN course co on sc.cno=co.cno
JOIN professor p on p.pno=co.pno
WHERE major='화학'
ORDER BY pname;

5) 모든 교수의 명단과 담당 과목을 검색한다
SELECT DISTINCT p.pno, pname, co.cname
FROM course co
RIGHT JOIN professor p on p.pno=co.pno
ORDER BY pname;


6) 모든 교수의 명단과 담당 과목을 검색한다(단 모든 과목도 같이 검색한다)
SELECT DISTINCT p.pno, pname, co.cname
FROM course co
FULL JOIN professor p on p.pno=co.pno
ORDER BY pname;