서브 쿼리를 이용한 DML 문장과 다이렉트 로드
; 다량의 DML 작업을 수행하는 경우 서브 쿼리문을
 이용하는 경우가 많다.
 특히 INSERT 작업에 대량 데이터를 입력할 때
 서브 쿼리를 이용하는 것은 매우 유용하고 빠른 작업
 방법이다.
 특히 메모리를 통하지 않고 직접 데이터를 디스크에
 입력하는 다이렉트 로드를 같이 사용하면 작업 효과는
 배가된다.
 
SELECT 작업이나 DML 작업은 모두 메모리에서 이루어진다
오라클은 SGA라는 메모리 영역 내에 
데이터베이스 버퍼 캐시(Database Buffer Cache)라는 영역을
이들의 작업 공간으로 이용한다.
이를 통해 작업을 모았다가 한번에 처리함으로써
디스크 접근 회수와 양을 줄여 성능을 향상시킨다.

그러나 일괄적인 대량의 DML 작업이 메모리에서 일어나면 
이를 디스크에 반영하고 다시 메모리를 정리하는 등의 
비효율이 발생한다.
이것은 바로 디스크에 기록하는 것보다 성능이 더 느려진다.
이를 피하기 위해 대량 DML 작업에서는 메모리를 통하지 않고
디스크에 직접 작업을 수행하는 것을 다이렉트 로드(Direct Load)
이 작업은 /*+ APPEND */를 DML문에 삽입하면 된다.

오라클은 안전한 시스템 운영을 위해 장애 발생시 복구할 수 있도록
DB에 변경을 가하는 모든 작업의 내역을 리두 로그(Redo log)...
NOLOGGING - 리두 로그를 안 남기겠다(속도 향상)
 
 서브 쿼리를 이용한 DML 문
 INSERT INTO [/*+ APPEND */] 테이블 [NOLOGGING] 
 [(컬럼, 컬럼, ...)]
 SELECT 문장;
 1) 서브쿼리(SELECT 문)에 검색된 행을 입력값으로 사용한다
 2) 한번에 많은 행을 입력할 수 있다
 3) 컬럼 리스트와 SELECT 문의 컬럼이 1:1로 대응되어야 한다
 4) SELECT 문에 사용한 서브 쿼리문과는 달리 괄호를 쓰지 않는다
 5) /*+ APPEND */ : 다이렉트 로드함으로 대량의 입력 작업을
                    더 빠르게 작업한다.
 6) [NOLOGGING] : 로그 정보를 남기지 않음으로 입력작업이 
                  빨라진다. 그러나 장애가 발생시 복구불가능
                  
UPDATE 테이블
SET 컬럼명 = (SELECT 문장),
    컬럼명 = (SELECT 문장), ...
[WHERE 조건];

UPDATE 테이블
SET (컬럼, 컬럼, ...) = (SELECT 문장)
[WHERE 조건];
1) UPDATE 문의 SET 절에는 단일 행 서브쿼리문이나
  다중 열 서브 쿼리문을 이용할 수 있다.
  다중 열인 경우도 반드시 결과 행은 하나여야 한다.
2) 이때 검색되는 Data는 반드시 수정되는 컬럼명과 1:1 대응돼야
  한다.
3) SET 절에는 단일행 서브쿼리만 허용되지만 WHERE 절의 서브
  쿼리는 연산자에 따라 달라진다.
  
  
1) emp2 테이블에 사번과 연봉을 입력한다

SELECT * FROM emp2;

DESC emp2;


2) 데이터 타입이 일치하지 않으면 에러 발생
데이터 입력이 가능한 경우
1) 데이터 타입이 같고
  저장 컬럼의 크기가 입력 데이터 크기보다 클 경우
2) 데이터 타입이 달라도 자동 형변환이 가능하고
  저장 컬럼의 크기가 입력 데이터 크기보다 클 경우
   '10' => 10
   숫자형 => 문자형 컬럼
   
INSERT INTO emp2(eno, asal)
SELECT eno, hdate
FROM emp;

INSERT INTO emp2(eno,asal)
SELECT eno, ename
FROM emp;


3) 아래 경우는 자동형변환 되어 들어간다
'30' -> 30 으로 형변환이 이루어진다
INSERT INTO emp2(eno, asal)
SELECT eno, dno 
FROM emp;

SELECT *
FROM emp;


4) 각 사원의 정보와 근무지를 emp3 테이블에 저장하라

DESC emp3;

--INSERT 문내에 /**/를 넣어주면 주석이 아니라 힌트로 해석한다
INSERT /*+APPEND*/INTO emp3 NOLOGGINFD(eno, ename, dno, dname)
SELECT eno, ename, dno, dname
FROM 
  
--ORA-12838: cannot read/modify an object after modifying it in parallel
--다이렉트 로드로 입력한 데이터를 반드시 COMMIT을 거쳐야
--조회할 수 있다.
--데이터의 안전성 보장을 위해서

SELECT * FROM emp3;

SELECT 작업이나 DML 작업은 모두 메모리에서 이루어진다.
오라클은 SGA라는 메모리 영역 내에 데이터베이스 버퍼 캐시
(Database Buffer Cache)라는 영역을 이들 작업 공간으로 
이용한다. 이를 통해 디스크 접근 회수와 양을 줄여 성능을
향상시킨다.
그러나 일괄적인 대량의 DML 작업이 메모리에서 일어나면
이를 디스크에 반영하고 다시 메모리를 정리하는 등의
비효율이 발생한다. 이를 피하기 위해 대량 DML 작업에서는
메모리를 통하지 않고 디스크에 직접 작업을 수행하는 것을 
다이렉트 로드(Direct Load)라 한다. DML 작업을 다이렉트
로드하기 위해서는 /*+ APPEND */를 문장에 삽입한다.
/**/는 평소에는 주석으로 사용되지만 + 기호를 붙여줌으로써
주석이 아닌 오라클에 옵션을 전달하는 용도로 사용되고 있다.

그리고 오라클은 안전한 시스템 운영을 위해 장애 발생 시 복구
할 수 있도록 DB에 변경을 가하는 모든 작업의 내용을 리두 로그
(Redo Log)영역에 로그 정보로 보관한다. 그러나 대량의 DML
작업은 작업의 효율을 위해 이를 수행하지 않을 수 있다.
작업 성능을 위해 로그 정보를 남기지 않기 위해 NOLOGGING 옵션을
사용한다.
그러나 이렇게 복구가 불가능하도록 작업한 이후에는 장애에 대비한
백업을 잊지 않아야 한다. 대량의 작업에서 다이렉트 로드와 
노로깅방식을 사용하면 작업 성능은 비약적으로 향상되지만 작업의
안전도는 떨어지게 된다.

다이렉트 로드를 이용해서 대량의 데이터를 테이블에 입력한 경우
입력되는 물리적인 위치가 일반 입력과 달라 트랜잭션을 마무리
하지 않고 검색하게 되면 'ORA-12838: 병렬로 수정한 후 객체를
읽거나 수정할 수 없습니다'라는 에러를 만나게 된다.
이것은 입력 데이터의 손상을 방지하기 위한 기능이다
반드시 COMMIT 을 한 이후 검색하면 정상적으로 검색이 된다.
5) 


*서브 쿼리를 이용한 UPDATE 문을 수행한다.


6) 윤고은의 급여와 보너스를 
각각 김연아의 급여와
손하늘의 보너스와 동일하게 수정한다

SELECT sal, comm, eno, ename
FROM emp
WHERE ename IN ('윤고은', '김연아', '손하늘');

--3300
SELECT sal
FROM emp
WHERE ename='윤고은'
--980
SELECT sal
FROM emp
WHERE ename='김연아'
-- 
SELECT sal
FROM emp
WHERE ename='손하늘'

SELECT sal, comm
FROM emp
WHERE ename='온고은'

UPDATE emp SET
sal = (SELECT)
 
7) 제갈민과 동일한 부서의 사원들의 급여를
제갈민의 급여와 동일하게 수정한다

SELECT dno
FROM emp
WHERE dno="20" AND 




8) 이초록의 급여, 보너스를 김연아와 동일하게 수정한다

SELECT sal, comm, eno, ename
FROM emp
WHERE ename IN ('이초록', ' 김연아');

UPDATE emp SET
(sal, comm) = SELECT sal, comm
FROM emp
WHERE



 
9)위의 Query 보다 아래 Query 가 성능이 낮다
SELECT sal, comm, eno, ename
FROM emp
WHERE ename IN ('이초록', ' 김연아');

UPDATE emp SET
sal=(SELECT sal
FROM emp
WHERE ename='김연아')
WHERE ename='이초록';
 
 
--10) 제갈민을 제외한 같은 부서원을 삭제하세요
SELECT dno
FROM emp 
WHERE ename="제갈민"

DELETE 
FROM emp 
W