<단일행 함수를 사용하세요>

1) 이름이 두 글자인 학생의 이름을 검색하세요
SELECT sno, sname, LENGTH(sname) "이름 길이"
FROM student
WHERE LENGTH(sname)=2;

2) '공'씨 성을 가진 학생의 이름을 검색하세요
SELECT sno, sname, SUBSTR(sname, 1, 1) "성"
FROM student
WHERE SUBSTR(sname, 1, 1)='공';

3) 교수의 지위를 한글자로 검색하세요(ex. 조교수 -> 조)
SELECT pno 교번, pname 교수명, SUBSTR(orders, 1, 1) "지위"
FROM professor;

4) 일반 과목을 기초 과목으로 변경해서 모든 과목을 검색하세요
   (ex. 일반화학 -> 기초화학)
SELECT cno, cname,
         REPLACE(cname, '일반', '기초') Replace
FROM course;

--tutor(결과는 같으나, 쿼리 정확도가 내 풀이 비해 더 높음)
SELECT cno, cname, REPLACE(cname, '일반', '기초')
FROM course
WHERE cname LIKE '일반%';

5) 만일 입력 실수로 student테이블의 sname컬럼에 데이터가 입력될 때
   문자열 마지막에 공백이 추가되었다면 검색할 때 이를 제외하고
   검색하는 SELECT 문을 작성하세요

SELECT sno, sname, TRIM(sname)
FROM student;

--tutor
--문자열 sname에서 오른쪽(trailing)부터 공백을 제거
SELECT TRIM(trailing FROM sname) 
FROM student;