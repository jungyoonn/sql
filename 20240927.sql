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
