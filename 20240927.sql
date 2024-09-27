DROP TABLE STUD_HEAVY;
DROP TABLE STUD_101 ;
DROP TABLE EX_TYPE ;

-- 전인하 학생의 생년월일 중 연, 월을 출력(YY-MM)
SELECT BIRTHDATE , TO_CHAR(BIRTHDATE, 'YY-MM') 
FROM STUDENT
WHERE NAME = '전인하';

-- 102번 학과 학생의 이름, 학년, 생년월일을 출력
SELECT NAME, GRADE, BIRTHDATE , TO_CHAR(BIRTHDATE, 'DAY MONTH DD YYYY') 생년월일 
FROM STUDENT
WHERE DEPTNO = 102;

-- 보직수당을 받는 교수들을 대상으로 수당과 급여를 더한 값에 12를 곱하여 ANUAL
-- 라는 이름으로 연봉 계산을 하고 세 자리마다 쉼표로 표시
SELECT NAME, SAL, COMM, TO_CHAR((SAL+COMM)*12, '9,999') ANUAL
FROM PROFESSOR
WHERE COMM IS NOT NULL;

SELECT 
	TO_NUMBER('1234'),
--	TO_NUMBER('ABCD'), 
	TO_NUMBER('1,234', '9,999') + 1111 -- 그냥은 인식을 못하므로 포맷을 해 주어야 함
FROM DUAL;

-- NVL 함수 : NULL 또는 0을 다른 값으로 변환하기 위한 함수
-- NVL2 : 첫 번째 인수 값이 NULL이 아니면 두 번째 인수를 출력, NULL이면 세 번째 인수를 출력

-- 학과 번호가
-- 101 컴퓨터공학과
-- 102 멀티미디어공학과
-- 201 전자공학과
-- 나머지는 기계공학과
SELECT STUDNO , 
	NAME , 
	DEPTNO , 
	DECODE(DEPTNO, 
		101, '컴퓨터공학과', 
		102, '멀티미디어학과',
		201, '전자공학과',
		'기계공학과') DNAME
FROM STUDENT;

-- 교수의 소속 학과에 따라 보너스 지급, 101번 학과일 경우 급여의 10%, 102번 학과는 20%, 201학과는 30%
SELECT 
	PROFNO , 
	NAME, 
	SAL,
	DEPTNO,
	CASE
		WHEN DEPTNO = 101 THEN SAL * 0.1
		WHEN DEPTNO = 102 THEN SAL * 0.2
		WHEN DEPTNO = 201 THEN SAL * 0.3
		ELSE 0 -- 데이터 타입을 맞춰 주어야 한다
	END BONUS,
	CASE DEPTNO -- 가독성 좋게 바꾼 것
		WHEN 101 THEN SAL * 0.1
		WHEN 102 THEN SAL * 0.2
		WHEN 201 THEN SAL * 0.3
		ELSE 0
	END BONUS2
FROM PROFESSOR;

-- COUNT *은 NULL을 포함한 모든 행을 카운트
-- DISTINCT : 중복 제외
SELECT COUNT(*)
FROM STUDENT;

-- 교수의 인원 수를 조회
SELECT COUNT(*)
FROM PROFESSOR;

-- 보직 수당을 받는 교수의 수를 조회
SELECT COUNT(COMM), MAX(SAL), MIN(SAL) -- 행이 하나만 출력되므로 그 갯수 이상의 결과를 출력하는 컬럼은 작성 x
FROM PROFESSOR;

-- WHERE절을 통해서도 조건 처리를 할 수가 있다
SELECT COUNT(*)
FROM PROFESSOR
WHERE COMM IS NOT NULL;

-- 101번 학과 학생들의 몸무게 평균과 합계, 최대 키와 최소 키
SELECT COUNT(*) 총인원, AVG(WEIGHT) 평균, SUM(WEIGHT) 합계, MAX(HEIGHT) 최대키, MIN(HEIGHT) 최소키 
FROM STUDENT
WHERE DEPTNO = 101;

-- GROUP BY
SELECT GRADE, DEPTNO, COUNT(*) -- GROUP BY에 명시된 컬럼만 SELECT에 쓸 수 있다
FROM STUDENT
GROUP BY GRADE, DEPTNO 
ORDER BY 1, 2;

-- 학과 번호별 교수의 인원 수를 조회, 보직수당을 받는 교수의 수 조회
-- COUNT(*)은 NULL 값을 포함하지만 COUNT(COMM)은 포함하지 않는다
SELECT DEPTNO , COUNT(*), COUNT(COMM) 
FROM PROFESSOR
GROUP BY DEPTNO;

-- 학과 별 교수의 최대 급여, 최소 급여 조회
SELECT DEPTNO, MAX(SAL) 최대급여, MIN(SAL) 최소급여
FROM PROFESSOR
GROUP BY DEPTNO ;

-- 학과와 학년을 기준으로 그룹핑, 학과와 학년별 인원 수, 평균 몸무게를 출력(소수점 이하 첫 번째 자리에서 반올림)
SELECT DEPTNO , GRADE , COUNT(*) 총인원, ROUND((AVG(WEIGHT))) 몸무게평균
FROM STUDENT
GROUP BY DEPTNO , GRADE 
ORDER BY DEPTNO ;

-- 학생의 생년월일을 기준으로 탄생 계절별 인원 수 구하기
SELECT 
--	TO_CHAR(BIRTHDATE , 'MM') 달
--	, COUNT(TO_CHAR(BIRTHDATE , 'MM')) 카운트
--	, TO_CHAR(BIRTHDATE, 'Q') -- Q는 분기
	TO_CHAR(ADD_MONTHS(BIRTHDATE, -2), 'Q') 계절
	,CASE TO_CHAR(ADD_MONTHS(BIRTHDATE, -2), 'Q')
		WHEN '1' THEN '봄'
		WHEN '2' THEN '여름'
		WHEN '3' THEN '가을'
		WHEN '4' THEN '겨울'
	END
	, COUNT(*)
FROM STUDENT
GROUP BY TO_CHAR(ADD_MONTHS(BIRTHDATE, -2), 'Q')
ORDER BY TO_CHAR(ADD_MONTHS(BIRTHDATE, -2), 'Q')

SELECT A, COUNT(*) FROM (
	SELECT TO_CHAR(ADD_MONTHS(BIRTHDATE, -2), 'Q') A
	FROM STUDENT
)
GROUP BY A
ORDER BY A;


-- ROLLUP, CUBE

-- ROLLUP : GROUP BY의 조건에 따라 행을 그룹화하고 합계를 구함 (한 축만 계산, 부분합)
-- CUBE : GROUP BY의 조건과 ROLLUP 결과에 따라 조합을 만듦 (양축 계산, 부분합)
SELECT DEPTNO , COUNT(*)
FROM PROFESSOR
GROUP BY ROLLUP(DEPTNO);

SELECT DEPTNO , POSITION, COUNT(*) 인원수
FROM PROFESSOR
GROUP BY CUBE(DEPTNO, POSITION)
ORDER BY 2;
