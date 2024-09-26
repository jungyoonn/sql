-- 연산자의 우선 순위
SELECT NAME, GRADE, DEPTNO 
FROM STUDENT
WHERE DEPTNO = 102
AND (GRADE = '4'
OR GRADE = '1'); -- 괄호를 하지 않으면 연산 결과가 완전히 달라진다

SELECT NAME, GRADE, DEPTNO 
FROM STUDENT
WHERE DEPTNO = 102
AND GRADE IN(1,4); -- 위와 같은 결과가 출력된다

CREATE TABLE STUD_HEAVY AS 
SELECT *
FROM STUDENT
WHERE WEIGHT >= 70 AND GRADE = '1';

CREATE TABLE STUD_101 AS
SELECT *
FROM STUDENT
WHERE DEPTNO = 101 AND GRADE = '1';

SELECT *
FROM STUD_HEAVY;

SELECT *
FROM STUD_101;

-- UNION 연산이 불가한 경우 : 연산을 실행하는 두 질의의 컬럼 수가 다를 경우
-- 해결 방법 : NULL을 채운다
-- 컬럼 이름은 앞의 질의의 컬럼을 따라가므로 별칭을 따로 붙이는 것이 좋다
SELECT STUDNO, NAME, NULL AS "학년"
FROM STUD_HEAVY
UNION
SELECT STUDNO, NAME, GRADE
FROM STUD_101;

-- UNION, UNION ALL을 활용하여 학번, 이름 조회 (대상 테이블 : STUD_HEAVY, STUD_101)
SELECT STUDNO, NAME
FROM STUD_HEAVY
UNION -- 중복을 제외한 합집합
SELECT STUDNO, NAME
FROM STUD_101;

SELECT STUDNO, NAME
FROM STUD_HEAVY
UNION ALL -- 중복을 전부 포함하는 합집합
SELECT STUDNO, NAME
FROM STUD_101;

-- 서브쿼리의 형태
SELECT DISTINCT STUDNO, NAME
FROM (
	SELECT STUDNO, NAME
	FROM STUD_HEAVY
	UNION ALL
	SELECT STUDNO, NAME
	FROM STUD_101
);

-- 학생 테이블에서 이름 순으로 정렬 / 이름, 학년, 전화번호 조회
SELECT NAME, GRADE , TEL 
FROM STUDENT
ORDER BY NAME DESC;

-- 학생 테이블에서 학년을 내림차순으로 정렬 / 이름, 학년, 전화번호 조회
SELECT NAME, GRADE , TEL 
FROM STUDENT
ORDER BY GRADE DESC;

-- 학생 테이블에서 학년을 내림차순으로 정렬 / 이름, 학년, 전화번호 조회
-- 단, 같은 학년일 경우 이름순으로 정렬
SELECT NAME, GRADE , TEL 
FROM STUDENT
ORDER BY GRADE DESC, NAME ASC;