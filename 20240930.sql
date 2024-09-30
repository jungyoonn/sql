-- 원래는 이런 형태이다
SELECT SAMPLE.STUDENT.DEPTNO 
FROM SAMPLE.STUDENT;

-- INNER JOIN (교집합)
SELECT s.NAME , s.DEPTNO , d.DNAME 
FROM STUDENT s, DEPARTMENT d
WHERE s.DEPTNO = d.DEPTNO;

-- 학생 16명
-- 학과 7개
-- 카티션 프로덕트 (두 테이블이 만들 수 있는 모든 조합) = 16 * 7 = 112개
SELECT s.NAME , s.DEPTNO , d.DEPTNO 
FROM STUDENT s, DEPARTMENT d;

-- WHERE 절로 조건을 설정해 준다
SELECT s.NAME , s.DEPTNO , d.DNAME 
FROM STUDENT s, DEPARTMENT d
WHERE s.DEPTNO = d.DEPTNO;

-- 겹치지 않는 컬럼은 테이블 별명을 생략해도 상관없지만 컬럼이 겹치는 경우에는
-- 별명을 붙여 주어야 한다 (조인 결과에는 별명이 붙지 않고 칼럼 이름만 나옴)
-- 테이블 별명을 사용할 경우 원래의 테이블 이름과 혼용할 수 없다

-- 전인하 학생의 학번, 이름, 학과 이름, 학과 위치를 조회
SELECT s.STUDNO , s.NAME , d.DNAME , d.LOC 
FROM STUDENT s , DEPARTMENT d 
WHERE s.DEPTNO = d.DEPTNO 
AND s.NAME = '전인하'

-- 몸무게가 80kg 이상인 학생의 학번, 이름, 체중, 학과 이름, 학과 위치를 조회
SELECT s.STUDNO , s.NAME , s.WEIGHT , d.DNAME , d.LOC 
FROM STUDENT s , DEPARTMENT d 
WHERE s.DEPTNO = d.DEPTNO 
AND s.WEIGHT >= 80

-- 1호관 소속 학생의 학번, 이름, 학과 이름 조회
SELECT s.STUDNO , s.NAME , d.DNAME , d.LOC 
FROM STUDENT s , DEPARTMENT d 
WHERE d.LOC = '1호관'
AND s.DEPTNO = d.DEPTNO ;


-- ANSI 99 (SQL 표준)
SELECT STUDNO , NAME, DNAME
FROM DEPARTMENT d
NATURAL JOIN STUDENT s 
WHERE LOC = '1호관';

-- 자연조인을 사용하여 학번, 이름, 학과 번호, 학과 이름 조회
-- 겹치는 칼럼을 동등 조인, 테이블 별명을 셀렉트에 사용할 시 오류 발생
SELECT STUDNO , NAME , DNAME , LOC 
FROM STUDENT s 
NATURAL JOIN DEPARTMENT d ;

SELECT *
FROM STUDENT s , DEPARTMENT d 
WHERE s.DEPTNO = d.DEPTNO ; -- 위와 조금 다르게 출력됨

-- JOIN ~ USING : 동등 연산을 할 칼럼이 괄호에 들어감 
-- JOIN ~ ON : 
SELECT *
FROM STUDENT s 
JOIN DEPARTMENT d USING(DEPTNO);

SELECT *
FROM STUDENT s 
JOIN DEPARTMENT d ON s.DEPTNO = d.DEPTNO ;

-- NATURAL JOIN을 사용, 교수 번호, 교수 이름, 학과 번호, 학과 이름 조회
SELECT p.PROFNO , p.NAME , DEPTNO , d.DNAME 
FROM PROFESSOR p 
NATURAL JOIN DEPARTMENT d ;

-- 교수별 급여 등급을 조회, 대상 테이블 : PROFESSOR, SALGRADE
SELECT p.NAME , p.PROFNO , p.SAL , s.GRADE 
FROM PROFESSOR p ,SALGRADE s 
WHERE SAL BETWEEN s.LOSAL AND s.HISAL;

-- 학번, 이름, 교수 번호, 담당 교수 이름 조회
SELECT s.STUDNO , s.NAME , p.PROFNO , p.NAME 
FROM STUDENT s , PROFESSOR p 
WHERE p.PROFNO = s.PROFNO ;
