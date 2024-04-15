<서브 쿼리를 사용하세요>


1) 관우보다 평점이 우수한 학생의 학번과 이름을 검색하세요
SELECT sno, sname, avr
FROM student
WHERE avr > (SELECT avr
                  FROM student
                  WHERE sname='관우')
ORDER BY avr DESC;

2) 관우와 동일한 학년 학생 중에 평점이 사마감과 동일한 학생을 검색하세요
SELECT sno, sname, avr
FROM student
WHERE syear= (SELECT syear
                  FROM student
                  WHERE sname='관우')
AND avr= (SELECT avr
                  FROM student
                  WHERE sname='사마감')
ORDER BY avr DESC;

3) 관우보다 일반 화학과목의 학점이 더 낮은 학생의 명단을 학점과 검색하세요
SELECT sno, sname, cname, result
FROM student
NATURAL JOIN score
JOIN course Using(cno)
WHERE result <(SELECT result
                FROM student
                NATURAL JOIN score
                JOIN course Using(cno) 
                WHERE sname='관우' AND cname='일반화학')
AND cname='일반화학'
ORDER BY result DESC;


4) 인원수가 가장 많은 학과를 검색하세요
SELECT major, COUNT(sno)
FROM student
GROUP BY major;

SELECT major, COUNT(sno)
FROM student
GROUP BY major
HAVING COUNT(sno)=(SELECT (MAX(COUNT(sno)))
                    FROM student
                    GROUP BY major);

--서브쿼리에서 그룹함수는 1개 항목만 SELECT할 것!

5) 학생 중 기말고사 성적이 가장 낮은 학생의 정보를 검색하세요
SELECT sno, sname, MIN(result)
 FROM student
NATURAL JOIN score
GROUP BY sno, sname
HAVING MIN(result)=(SELECT MIN(MIN(result))
                    FROM student
                    NATURAL JOIN score
                    GROUP BY sno, sname);
--각 학생별 최저 점수 중에서도 가장 최저 점수