1) 화학과를 제외하고 학생들의 평점 평균을 검색하세요
SELECT major, sname, avr
 FROM student
WHERE major!='화학'
ORDER by major, avr DESC;

SELECT major, ROUND(AVG(avr), 2)
 FROM student
 GROUP BY major
 HAVING major!='화학'
 ORDER by ROUND(AVG(avr), 2) DESC;

2) 화학과를 제외한 각 학과별 평균 평점 중에 평점이 2.0 이상인 정보를 검색하세요
SELECT major, ROUND(AVG(avr), 2)
 FROM student
 GROUP BY major
 HAVING major!='화학' AND ROUND(AVG(avr), 2)>=2.0
 ORDER by ROUND(AVG(avr), 2) DESC;

3) 기말고사 평균이 60점 이상인 학생의 정보를 검색하세요(학번과 기말고사 평균)
SELECT sno, ROUND(AVG(result), 2)
 FROM student
NATURAL JOIN score
GROUP BY sno
HAVING ROUND(AVG(result), 2)>=60;

4) 강의 학점수가 3학점 이상인 교수의 정보를 검색하세요(교수번호, 이름과 담당 학점수)
SELECT pno, pname, ROUND(AVG(st_num), 2)
 FROM professor
NATURAL JOIN course
GROUP BY pno, pname
HAVING ROUND(AVG(st_num), 2)>=3;