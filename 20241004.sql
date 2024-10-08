-- 주소록 테이블 생성
-- id varchar(100), name varchar(100)
CREATE TABLE ADDR(
	ID VARCHAR2(100),
	NAME VARCHAR2(100)
);

-- 주소록에 컬럼 추가 birth date
ALTER TABLE ADDR ADD (BIRTH DATE);

SELECT * FROM ADDR;

-- 주소록에 comments 컬럼 추가 varchar(200) 기본값 'no comment'
ALTER TABLE ADDR ADD (COMMENTS VARCHAR2(200) DEFAULT 'NO COMMENT');

INSERT INTO ADDR (ID) VALUES ('id1');

-- 주소록 테이블에서 comment 컬럼 삭제
ALTER TABLE ADDR DROP COLUMN COMMENTS;

-- 주소록 ID 컬럼의 크기를 1 BYTE로 변경
-- 변경할 크기가 원래의 크기와 같거나 클 때만 변경 가능하다
ALTER TABLE ADDR MODIFY ID VARCHAR(1);

-- ADDR 테이블 이름을 ADDR2로 변경
RENAME ADDR TO ADDR2;

SELECT * FROM ADDR2;

-- DROP은 테이블과 데이터를 아예 삭제 / 빠름, DDL
-- TRUNCATE는 데이터랑 할당된 공간만 삭제, 롤백 불가능 / 빠름, DDL
-- DELETE는 기존 데이터만 삭제, 롤백 가능, 할당된 공간 유지 / 느림, DML

-- ADDR2의 NAME 컬럼에 '이름'이라는 COMMENT 추가
COMMENT ON COLUMN ADDR2.NAME IS '이름';

-- 제약 조건 DEFERRABLE : 지연
-- 강좌 테이블 생성 (SUBJECT)
-- SUBNO 번호 / SUBNAME 이름 / TERM 학기(1 혹은 2) / TYPE 필수 여부
CREATE TABLE SUBJECT (
	SUBNO NUMBER CONSTRAINT SUBJECT_PK PRIMARY KEY, -- 제약 조건 이름 붙이기
	SUBNAME VARCHAR(200) CONSTRAINT SUBNAME_NN NOT NULL,
	TERM CHAR(1) CONSTRAINT TERM_CK CHECK (TERM IN ('1' ,'2')),
	TYPE CHAR(1)
);

ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_PK PRIMARY KEY(STUDNO);

-- 시험에 나옴 PPT 534 표 참고
CREATE TABLE SUGANG (
	STUDNO NUMBER(5) CONSTRAINT SUGANG_STUDNO_FK REFERENCES STUDENT(STUDNO),
	SUBNO NUMBER(5) CONSTRAINT SUGANG_SUBNO_FK REFERENCES SUBJECT(SUBNO),
	-- REFERENCES 뒤에 테이블 이름만 써도 가능, 데이터 타입 정의 안 해도 가능
	-- CONSTRAINT SUGANG_SUBNO_FK FOREIGN KEY(SUBNO) REFERENCES SUBJECT
	REGDATE DATE,
	RESULT NUMBER(3), CONSTRAINT SUGANG_PK PRIMARY KEY(STUDNO, SUBNO)
);

-- USER_CONSTRAINTS 데이터 사전에서 무결성 제약 조건 조회
-- C : CHECK 또는 NOT NULL
-- P : PRIMARY KEY
-- U : UNIQUE KEY
-- R : FOREIGN KEY
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN('SUBJECT', 'SUGANG');

-- 학과 테이블에 제약 조건 넣기
-- PK : DEPTNO, NOT NULL : DNAME, FK : COLLEGE <> DEPTNO
ALTER TABLE DEPARTMENT MODIFY (DEPTNO CONSTRAINT DEPARTMENT_PK PRIMARY KEY);
ALTER TABLE DEPARTMENT MODIFY (DNAME NOT NULL);
ALTER TABLE DEPARTMENT MODIFY (COLLEGE REFERENCES DEPARTMENT(DEPTNO));

-- 교수 테이블에 제약 조건 넣기
-- PK : NAME NOT NULL, UNIQUE : ID
ALTER TABLE PROFESSOR ADD CONSTRAINT PROFESSOR_PK PRIMARY KEY(PROFNO);
ALTER TABLE PROFESSOR MODIFY (NAME NOT NULL);
ALTER TABLE PROFESSOR ADD CONSTRAINT PROF_USERID_UK UNIQUE(USERID);
ALTER TABLE PROFESSOR ADD FOREIGN KEY(DEPTNO) REFERENCES DEPARTMENT;

-- 학생 테이블에 제약 조건 넣기
-- NAME NOT NULL, UNIQUE : ID, 주민번호 UNIQUE, DEPTNO FK, PROFNO FK
ALTER TABLE STUDENT MODIFY (NAME NOT NULL);
ALTER TABLE STUDENT MODIFY (CONSTRAINT STUD_USERID_UK UNIQUE(USERID)); -- COLUMN LEVEL
ALTER TABLE STUDENT ADD CONSTRAINT STUD_IDNUM_UK UNIQUE(IDNUM); -- TABLE LEVEL
ALTER TABLE STUDENT MODIFY (DEPTNO REFERENCES DEPARTMENT(DEPTNO));
ALTER TABLE STUDENT MODIFY (PROFNO REFERENCES PROFESSOR(PROFNO));

SELECT * FROM PROFESSOR;

INSERT INTO PROFESSOR VALUES (9969, '김영희', 'younggg', '부교수', 500, '1982-06-30', 20, 101);