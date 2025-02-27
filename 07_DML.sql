/*
    
    D : DATA, 
    L : LANGUAGE 
    
    DQL(QUERY, 데이터 조회) - > SELECT : 조회
    DML(MANIPULIATION) : INSERT(추가/삽입), UPDATE(수정), DELETE(삭제)
    DDL(DEFINITION, 데이터 정의)  : CREATE(생성) , ALTER(변경), DROP(삭제)
    DCL(CONTROL, 데이터 제어) : GRANT, REVOKE 
    TCL(TRANSACTION, 트랜젝션 제어) : COMMIT, ROLLBACK
    
*/
--------------------------------------------------------------------------------
/*
    DML : (데이터 조작 언어)
    : 테이블에 데이터를 추가하거나(INSURT), 
                        수정하거나(UPDATE),
                            삭제하기 위해 (DELETE) 사용하는 언어 
*/
/*
    데이터 추가 : INSERT
    => 테이블에 새로운 행을 추가하는 것 
    INSERT INTO 테이블명 VALUES(값,값,값, ....)
    -> 테이블의 모든 컬럼에 대한 값을 제시하여 저장(추가)
    컬럼 순서에 맞게 나열해야 함 (해당 컬럼의 데이터 타입에 맞게!)
*/
SELECT * FROM EMPLOYEE;

INSERT INTO employee 
    VALUES (300, '양민욱', '930806-1000000', 'minwook@or.kr', '01012345678',
    'D4', 'J4', 3000000, 0.3, NULL, sysdate, null, 'N'
    );

/*
    2) INSERT INTO 테이블명(컬럼명, 컬럼명, 컬럼명) VALUES (값,값,값)
    -> 컬럼으 직접 제시하여 해당 컬럼에 대한 값만을 추가 
        제시되지 않은 컬럼에 대한 값은 기본적으로 NULL이 저장되고 
        기본값에 대한 옵션(DEFAULT)이 있는 경우 해당 기본값으로 저장됨.
        => NOT NULL 제약조건이 있는 컬럼의 경우 직접 컬럼을 제시하여 값을 추가하거나,
        DEFAULT 옵션을 설정해야 함! (그렇지 않으면 오류 발생!)
*/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, EMAIL, JOB_CODE)
    VALUES(301,'양준혁','000501-3000000', 'junhyeok2@or.kr', 'J7');

SELECT * FROM EMPLOYEE;

/*
    INSERT INTO 테이블명(서브쿼리);
    => VALUES 부분 대신 서브쿼리로 조회된 결과값을 통채로 INSERT하는 방법
*/

CREATE TABLE EMP01(
    
    EMP_ID NUMBER, 
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP01;

-- 사번, 사원명, 부서명 조회 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
   LEFT JOIN department ON (DEPT_CODE = DEPT_ID);

-- 위의 쿼리 결과를 EMP01 테이블에 추가 
INSERT INTO EMP01 (
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
   LEFT JOIN department ON (DEPT_CODE = DEPT_ID)
);
--------------------------------------------------------------------------------
/*
    * INSERT ALL 
    : 두개 이상의 테이블에 각각 데이터를 추가할 때 사용 
      이때 사용되는 서브쿼리가 동일한 경우 
*/

-- 사번, 사원명, 부서코드, 입사일 정보를 가지는 테이블

DROP TABLE EMP_DEPT;
CREATE TABLE EMP_DEPT
AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
        from employee
        where 1 = 0);
        
SELECT * FROM EMP_DEPT;   

-- 사번, 이름, 사수사번 정보를 가지는 테이블 
CREATE TABLE EMP_MANAGER 
AS (SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0
);

    
    
-- 부서코드가 'D1'인 사원의 사번, 사원명, 사원명, 부서코드, 사수사번, 입사일 정보 조회
SELECT EMP_ID , EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE 
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D1';


INSERT ALL 
    INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
    INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    (SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
    FROM employee
    WHERE DEPT_CODE = 'D1'
);

/*
    INSERT ALL 
    INTO 테이블명 VALUES (컬럼명,컬럼명,컬럼명,.....)
    
    INTO 테이블명 VALUES (컬럼명,컬럼명,컬럼명,.....)
    서브쿼리 :   
*/
SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;

/*
    
    UPDATE : 테이블에 저장되어있는 기존의 데이터의 값을 변경하는 구문 
    
    UPDATE 테이블명 
    
        SET 컬럼 = 값, 
            컬럼 = 값, ...
    [WHERE 조건식] --> WHERE절을 생략했을 경우 테이블의 모든 행의 SET절에 제시한 컬럼의 
    데이터가 변경
    
    * 업데이트 시 제약조건을 잘 확인해야함!    
*/
-- DEPT_TABLE 테이블에 DEPARTMENT 테이블 복제
CREATE TABLE DEPT_TABLE
AS (SELECT * FROM DEPARTMENT);

SELECT * FROM DEPT_TABLE;

-- 부서코드(DEPT_ID)가 'D1'인 부서의 부서명을 '인사팀'으로 변경  

UPDATE DEPT_TABLE 
    SET DEPT_TITLE = '인사팀'
WHERE DEPT_ID = 'D1';    

-- 부서코드가 'D9'인 부서의 부서명을 '전략기획팀'으로 변경 
UPDATE DEPT_TABLE 
    SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9';    

SELECT * FROM DEPT_TABLE;

-- 사원(EMPLOYEE) 테이블을 EMP_TABLE 테이블로 복제(사번, 이름, 부서코드, 급여, 보너스 정보만)

CREATE TABLE EMP_TABLE
AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS FROM EMPLOYEE);

SELECT * FROM EMP_TABLE;

UPDATE EMP_TABLE 
SET SALARY = 1000000
WHERE EMP_NAME = '양준혁';

SELECT * FROM EMP_TABLE WHERE EMP_NAME = '양준혁';


-- 대북혼 사원의 급여를 500만원, 보너스 0.2로 변경 

UPDATE EMP_TABLE 
SET SALARY = 5000000, 
    BONUS = 0.2 
WHERE EMP_NAME = '대북혼';

UPDATE EMP_TABLE 
SET SALARY = (SALARY * 1.1);

SELECT * FROM EMP_TABLE;
--------------------------------------------------------------------------------

/*
    UPDATE문에서 서브쿼리 사용하기 
    
    UPDATE 테이블명 
        SET 컬럼명 = (서브쿼리)
    WHERE 조건식         
*/

-- 방명수 사원의 급여와 보너스를 유재식 사원의 급여와 보너스 값과 동일하게 변경
UPDATE EMP_TABLE 
SET SALARY = (SELECT SALARY 
            FROM EMP_TABLE 
            WHERE EMP_NAME = '유재식'
            ),
          BONUS =  (
            SELECT BONUS FROM EMP_TABLE
            WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';

SELECT * FROM EMP_TABLE WHERE EMP_NAME IN ('방명수','유재식');

SELECT *
FROM EMP_TABLE 
WHERE (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME = '유재식');


UPDATE EMP_TABLE 
SET(SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '전형돈';

SELECT * FROM EMP_TABLE;

-- ASIA 지역에서 근무중인 사원들의 보너스 값을 0.3으로 변경 

SELECT *
FROM LOCATION
WHERE LOCAL_NAME LIKE 'ASIA%';

-- * ASIA지역의 부서 정보 조회 
SELECT *
FROM DEPARTMENT 
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE 
WHERE LOCAL_NAME LIKE 'ASIA%';

-- ASIA지역의 부서에 속한 사원 정보 조회 
(SELECT EMP_ID FROM EMP_TABLE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE);

-- * 해당 사원들의 보너스 값을 0.3으로 변경 
UPDATE EMP_TABLE 
    SET BONUS = 0.3
WHERE EMP_ID IN  (SELECT EMP_ID FROM EMP_TABLE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME LIKE 'ASIA%'
);

SELECT * FROM EMP_TABLE;
 

/*
    * DELETE 테이블에 기존 저장된 데이터 삭제할 때 사용하는 구문 
    
    DELETE FROM 테이블명 
    [WHERE 조건식]; --> WHERE절 생략 시 모든 데이터(행)를 삭제 
*/
-- EMPLOYEE 테이블의 모든 데이터를 삭제!
DELETE FROM EMPLOYEE;
SELECT * FROM employee;
ROLLBACK;

-- 양준혁 사원의 데이터를 삭제 

DELETE FROM employee
WHERE EMP_NAME = '양준혁';


SELECT * FROM employee;
DELETE FROM employee
WHERE EMP_ID = 300;

COMMIT;

-- 부서 테이블에서 부서코드가 D1인 부서 삭제 
DELETE FROM department
WHERE DEPT_ID = 'D1';
--> D1 값을 EMPLOYEE 테이블 사용 중이기 때문에 삭제 불가(외래키 설정되어 있음!)









