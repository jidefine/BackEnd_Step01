
1) 3학년 학생의 학과별 평점 평균과 분산 및 편차를 검색하세요
SELECT syear, major, 
        ROUND(AVG(avr), 2) "평균", 
        ROUND(VARIANCE(avr), 2) "분산", 
        ROUND(STDDEV(avr), 2) "편차"
FROM student
WHERE syear='3'
GROUP BY syear, major;


2) 화학과 학년별 평균 평점을 검색하세요
SELECT major, syear, AVG(avr) "평균"
FROM student
WHERE major='화학'
GROUP BY major, syear;

3) 각 학생별 기말고사 평균을 검색하세요
1안
SELECT sc.sname, ROUND(AVG(result), 2)
 FROM student sc
 JOIN score USING(sno)
GROUP BY sc.sname;

2안
SELECT sname, ROUND(AVG(result), 2)
 FROM student
NATURAL JOIN score
GROUP BY sname;

4) 각 학과별 학생 수를 검색하세요
SELECT major, COUNT(sno)
FROM student
GROUP BY major;

5) 화학과와 생물학과 학생 4.5 환산 평점의 평균을 각각 검색하세요
SELECT major, ROUND(AVG(avr+0.5), 2) "환산평점평균"
FROM student
WHERE major IN ('화학', '생물')
GROUP BY major;

6) 부임일이 10년 이상 된 직급별(정교수, 조교수, 부교수) 교수의 수를 
   검색하세요
SELECT orders, COUNT(pno)
FROM professor
WHERE TRUNC((sysdate-hiredate)/365) >= 10
GROUP BY orders;

7) 과목명에 화학이 포함된 과목의 학점수 총합을 검색하세요(?)
SELECT SUM(st_num)
FROM course
WHERE cname LIKE'%화학%'
GROUP BY st_num;

8) 화학과 학생들의 기말고사 성적을 성적순으로 검색하세요
SELECT major, sno, sname, result
FROM student
JOIN score USING(sno)
JOIN course USING(cno)
WHERE major='화학'
ORDER BY result DESC;

9) 학과별 기말고사 평균을 성적순으로 검색하세요
SELECT major, ROUND(AVG(result), 2)
 FROM student
 JOIN score USING(sno)
GROUP BY major
ORDER BY ROUND(AVG(result), 2) DESC;