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

-- 함수
-- 학생의 이름, 아이디 조회 / 아이디의 첫 글자는 대문자로, 모든 아이디를 대문자로, 모든 아이디를 소문자로
SELECT NAME , USERID, INITCAP(USERID), UPPER(USERID), LOWER(USERID) 
FROM STUDENT;

-- 부서의 이름을 조회하고 이름의 길이와 바이트 수를 조회
SELECT DNAME , LENGTH(DNAME), LENGTHB(DNAME) 
FROM DEPARTMENT;

-- 1학년 학생들의 생년월일, 테어난 달을 조회 (주빈번호를 통해서)
SELECT STUDNO , IDNUM, SUBSTR(IDNUM, 1, 6), SUBSTR(IDNUM, 3, 2) 
FROM STUDENT
WHERE GRADE = '1';

-- 부서 테이블에서 부서 이름 조회, 부서 이름 내의 '과' 글자의 위치를 탐색
SELECT DNAME , INSTR(DNAME, '과', 3, 1) -- 없으면 0을 출력, 3번째 글자에서부터 1번째 '과'의 위치
FROM DEPARTMENT;

-- 전화번호를 뒷자리 4글자를 *로 바꾸기
SELECT TEL, REPLACE(TEL, SUBSTR(TEL, -4), '****')
FROM STUDENT;

SELECT TEL, SUBSTR(TEL, 1, INSTR(TEL, '-')) || '****' AS TEL
FROM STUDENT; 

-- 교수의 직급 왼쪽에 + 기호를 추가하여 10글자, 아이디의 오른쪽에 *을 추가하여 12글자로 조회
SELECT POSITION, LPAD(POSITION, 10, '+') , USERID, RPAD(USERID, 12, '*') 
FROM PROFESSOR;

SELECT 'xyxxyyyyyxy', LTRIM('xyxxyyyyyxy', 'x'), RTRIM('xyxxyyyyyxy', 'y')
FROM DUAL;

-- 부서 테이블에서 부서 이름의 마지막 글자인 '과' 글자를 제거
SELECT DNAME, RTRIM(DNAME, '과') 
FROM DEPARTMENT;