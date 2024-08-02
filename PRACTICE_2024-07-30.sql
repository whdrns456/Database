-- * QUIZ1 * --------
/*
	CREATE USER C##TEST IDENTIFIED BY 1234; 실행
	User C##TEST이(가) 생성되었습니다.
	계정 생성만 하고 접속 시 에러 (user C##TEST lacks CREATE SESSION privillege; logon denied 에러)
*/

-- 원인 ?
CREATE USER C##TEST IDENTIFIED BY 1234;
-- 해결방안 ?
-- 비밀번호만 생성을 했다 제대로 된 계정을 생성을 하기 위해서는 관리자 계정으로 
-- 권한을 주어야한다 GRANT CONNECT, RESOURCE TO "TO 계정명"
-- 최소한의 권한 CONNECT, RESOURCE 

-- CREATE SESSION 권한을 부여해줘야 함

-- 테이블 스페이스 관련 설정도 해주어야한다 
-- ALTER USER "C##KH" DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;


-- * QUIZ2 * --------
CREATE TABLE TB_JOB (
	JOBCODE NUMBER PRIMARY KEY,
    -- 행들을 구별하길 위한 식별자 역할을 함 
	JOBNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE TB_EMP (
	EMPNO NUMBER PRIMARY KEY,
	EMPNAME VARCHAR2(10) NOT NULL,
	JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);
/*
	위의 두 테이블을 조인하여 EMPNO, EMPNAME, JOBNO, JOBNAME 컬럼을 조회하고자 한다.
	이때 실행한 SQL문이 아래와 같다고 했을 때,
*/

SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
	JOIN TB_JOB USING(JOBNO);
-- 다음과 같은 오류가 발생했다.
-- ORA-00904: "TB_JOB"."JOBNO": invalid identifier

-- 원인 ?
-- USING은 같은 이름의 컬럼을 통해서 조인을 하고자 할 때 사용하는 구문이다  
-- 조인하고자 하는 두 테이블의 연결고리 하는 역할을 하는 컬럼명이 다르므로 
-- using을 사용할 수 없다 ON으로 변경을 해줘야 한다.

-- 해결방안 ?
-- ON을 통해서( JOBCODE = JOBNO)으로 조인을 시도해준다.
-- 기본키 참조키 

 



