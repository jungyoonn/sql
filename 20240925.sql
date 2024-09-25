-- 학생의 행 개수만큼 출력됨
SELECT 1+1
FROM STUDENT;

-- 하나만 나오게 (=은 비교 연산, 참이면 결과가 출력됨 / 거짓일 경우 출력되지 않음)
SELECT 1+1
FROM DUAL
WHERE 'SQL'='SQL   '; -- 공백이 들어가면 자체적으로 Trim을 함 (참)

CREATE TABLE EX_TYPE (
C CHAR(7), 
V VARCHAR2(7),
N NUMBER ,-- 자릿수 제한 표시 생략 가능
N2 NUMBER(5,2) -- 총 5자리 표시 가능한데 소수점은 2자리까지
);

SELECT *
FROM EX_TYPE;

DROP TABLE EX_TYPE;

INSERT INTO EX_TYPE VALUES('SQL', 'SQL', 100, 100.111111);

-- 데이터만 싹 지움
DELETE FROM EX_TYPE;

-- char와 varchar2의 길이가 달라서 false
-- 리터럴끼리 비교하면 Trim 처리가 일어나서 참이지만 타입끼리 비교하면 참이 아니게 된다
SELECT *
FROM EX_TYPE
WHERE c = v;

-- 따라서 참이려면
SELECT *
FROM EX_TYPE
WHERE c = v||'    ';

SELECT 3.14 + 1
FROM DUAL;

-- ROWID 조회
SELECT STUDENT.*, ROWID
FROM STUDENT;

-- 현재 시간 정보 조회
SELECT SYSDATE FROM DUAL;

SELECT *
FROM DEPARTMENT; -- 트리 구조로 되어 있음

-- 의사 열(Pseudo Column) ROWNUM
-- 비교 연산 =의 경우 =1만 예외적으로 사용 가능 (=2부터는 불가)
SELECT ROWNUM, STUDENT.*, ROWID
FROM STUDENT
WHERE ROWNUM <= 5;

-- {1, 100, 2, 3, 20} 정렬
INSERT INTO EX_TYPE VALUES('1', 'SQL', 1, 1.1111);
INSERT INTO EX_TYPE VALUES('100', 'SQL', 100, 100.11);
INSERT INTO EX_TYPE VALUES('2', 'SQL', 2, 2.11);
INSERT INTO EX_TYPE VALUES('3', 'SQL', 3, 3.11);
INSERT INTO EX_TYPE VALUES('20', 'SQL', 20, 20.11);

-- N을 기준으로 정렬하면 제대로 정렬이 되지만 C를 기준으로 할 경우 문자로 인식해서
-- 비교하기 때문에 보기에 제대로 정렬되지 않는다
SELECT *
FROM EX_TYPE
ORDER BY C;

-- 이를 해결하려면
SELECT *
FROM EX_TYPE
ORDER BY TO_NUMBER(C); 

SELECT STUDNO, NAME, DEPTNO
FROM STUDENT
WHERE GRADE = '1';

-- 학번, 이름, 학년, 학과 번호, 몸무게 조회 / 단 70kg 이상
SELECT STUDNO , NAME, GRADE , DEPTNO , WEIGHT 
FROM STUDENT
WHERE WEIGHT >= '70';

-- 이름, 학년, 몸무게, 학과 번호 / 70kg 이상이면서 1학년인 학생
SELECT NAME, GRADE , WEIGHT , DEPTNO 
FROM STUDENT
WHERE WEIGHT >= 70 AND GRADE = 1;

-- 이름, 학년, 몸무게, 학과 번호 / 70kg 이상이거나 1학년인 학생
SELECT NAME, GRADE , WEIGHT , DEPTNO 
FROM STUDENT
WHERE WEIGHT >= 70 OR GRADE = 1;

-- BETWEEN 연산자는 상한값과 하한값도 포함된다
-- 학번, 이름, 몸무게 / 체중이 50kg 이상 70kg 이하인 학생
SELECT STUDNO , NAME , WEIGHT 
FROM STUDENT
WHERE WEIGHT BETWEEN 50 AND 70;

-- 이름, 생일 / 81년에서 83년 사이에 태어난 학생
SELECT NAME, BIRTHDATE 
FROM STUDENT
WHERE BIRTHDATE BETWEEN '81/01/01' AND '83/12/31';

-- 이름, 학년, 학과 번호 / 102번 학과와 201번 학과인 학생
SELECT NAME, GRADE , DEPTNO 
FROM STUDENT
WHERE DEPTNO IN(102, 201);

-- 이름, 생일 / 81년에서 83년 사이에 태어난 학생
SELECT NAME, TO_CHAR(BIRTHDATE, 'YY') YY, s.*
FROM STUDENT s
WHERE TO_CHAR(BIRTHDATE, 'YY') IN(81, 82, 83);

-- 이름, 학년, 학과 번호 / 김씨인 학생
SELECT NAME, GRADE , DEPTNO 
FROM STUDENT
WHERE NAME LIKE '김'; -- '%김%'도 가능, 글자 수를 한정하려면 김__

-- NULL과 다른 대상과의 연산 결과는 모두 NULL이다
SELECT 2/NULL FROM DUAL;

-- 교수 테이블에서 이름, 직급, 수당 조회
SELECT NAME, "POSITION" , COMM 
FROM PROFESSOR;

-- 교수 테이블에서 이름, 직급, 수당 조회 / 수당이 있는 사람만
SELECT NAME, "POSITION" , COMM 
FROM PROFESSOR
WHERE COMM IS NOT NULL;

-- 교수 이름, 급여, 수당, 급여 + 수당 조회
-- NVL(a, b) null 값인 a를 전부 b로 표기
-- NVL2(a, b, c) a가 null이 아니면 b를 처리, null이 아니면 c를 처리
SELECT NAME, SAL , COMM,  SAL+COMM AS "월급", NVL(COMM, 0)+SAL, NVL2(COMM, SAL+COMM, SAL)
FROM PROFESSOR;

