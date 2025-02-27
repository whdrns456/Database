/*
    * PL/SQL 
    
    오라클 자체에 내장 되어 있는 절차적 언어 
    SQL 문장 내에서 변수 정의 조건, 반복등을 지원하여 SQL 단점을 보완
    다수의 SQL문을 한번에 실행가능 
    
    * 구조 *
    [선언부] 생략 가능 : DECLARE로 시작. 변수나 상수를 초기화하는 부분 
    실행부     : BEGIN으로 시작. SQL문 또는 제어문[조건문, 반복문]등의 로직을 작성하는 부분 
    [예외처리부] 생략가능 EXCEPTOIN으로 시작 예외 발생 시 해결하기 위한 부분 
*/
--
SET SERVEROUTPUT ON;
-- HELLO ORACLE 출력 
-- 화면에 출력하고자 할 때 DBMS_OUTPUT.PUT_LINE(출력할 내용)
BEGIN 

DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');

END;
--------------------------------------------------------------------------------

/*
    * 선언부 :  (DECLARE)
    : 변수 또는 상수를 선언하는 부분 (선언과 동시에 초기화도 가능)

    - 데이터 타입 선언 종류
    + 일반 타입 
    + 레퍼런스 타입 
    + ROW 타입
*/

/*
    * 일반 타입 변수 
    
       변수명 [CONSTANT] 자료형 [:=값]
       -- 상수 선언 시 CONSTANT를 붙여 줌
       -- 초기화할 때는 ":=" 기호를 사용 
    
*/
DECLARE 
    EID NUMBER;         -- EID라는 이름의 NUMBER 타입 변수 선언
    ENAME VARCHAR2(20); -- ENAME이라는 이름의 VARCHAR2(20) 타입 변수 선언
    PI CONSTANT NUMBER := 3.14; -- PI라는 이름의 NUMBER 타입의 상수 선언 및 3.14값으로 초기화 
BEGIN 
-- 변수에 값을 대입 
    EID := 100;                     -- EID라는 변수에 100이라는 값을 대입 
    ENAME := '임수진';                -- ENAME이라는 변수에 내이름 값으로 대입 
    
    -- 각 변수, 상수에 저장된 값을 화면에 출력 
    -- 특정 문자와 변수를 같이 출력하고자 할 때 연결연산자 (||)를사용     
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);  
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);

END;


DECLARE 
    EID NUMBER;         
    ENAME VARCHAR2(20); 
    PI CONSTANT NUMBER := 3.14;  
BEGIN 
-- 변수에 값을 대입 
    EID := '&사원번호';                   
    ENAME := '임수진';              
    
       
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);  
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);


END;
/
--------------------------------------------------------------------------------
/*
    * 레퍼런스 타입 변수 
      : 어떤 테이블의 어떤 컬럼의 데이터타입을 참조하여 해당 타입으로 변수를 지정 
      
      변수명 테이블명.컬럼명%TYPE
*/
DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;  -- EID라는  변수는 EMPLOYEE테이블의 EMP_ID 컬럼의 타입을 참조 
    ENAME EMPLOYEE.EMP_NAME%TYPE; -- ENAME 변수는 
    SAL EMPLOYEE.SALARY%TYPE;

BEGIN
   -- EMPLOYEE 테이블에서 200번 사원의 사번, 사원명, 급여조회
    SELECT EMP_ID, EMP_NAME, SALARY 
    INTO EID, ENAME, SAL
    FROM employee
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;

-- 문제 -- 
/*

    레퍼런스 타입의 변수로 EID, ENAME, SAL DTITLE을 선언하고 
    각 자료형을 EMPLOYEE테이블의 EMP_ID, EMP_NAME, JOB_CODE, SALARY 컬럼과
    DEPARTMENT 테이블의 DEPT_TITLE 컬럼을 참조하도록 한 뒤
    사용자가 입력한 사번의 사원 정보를 조회하여 변수에 담아 출력 
    
    출력 형식 : [사번], [이름], [직급코드], [월급], 부서명

*/
BEGIN
   -- EID := '100';
   --  ENAME := '임수진';
    
    -- EMPLOYEE 테이블에서 200번 사원의 사번, 사원명, 급여조회
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY 
    INTO EID, ENAME, JCODE, ESAL, DTITLE
    FROM employee
    WHERE EMP_ID = 200;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODE : ' ||JCODE);
END;

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;         
    ENAME EMPLOYEE.EMP_NAME%TYPE ; 
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    ESAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    
BEGIN 
-- 변수에 값을 대입 
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, ESAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE(EID || ', '  || ENAME || ', ' || JCODE || ',' );
    
    
END;   
/    
--------------------------------------------------------------------------------

/*
    * ROW 타입 변수 
    : 테이블의 한 행에 대한 모든 컬럼값을 한번에 담을 수 있는 변수 
    
    변수명 테이블명%ROWTYPE;
    
*/
DECLARE 
    E EMPLOYEE%ROWTYPE;
BEGIN 
    SELECT  *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;

    -- 사원명, 급여, 보너스 정보를 출력 
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || E.SALARY );
    DBMS_OUTPUT.PUT_LINE('보너스 : ' || E,BONUS);
    
END;
/

--==============================================================================

/*
    * 실행부 (BEGIN)
    
    ** 조건문 **
    -- 단일 IF문 : IF 조건식. THEN 실행내용 END IF;
    -- IF/ELSE문 : IF 조건식 THEN 조건식이 참일떄 실행내용 ELSE 실행 내용 
    ELSE 조건식이 거짓일 때 실행 내용 END IF;
    IF/ELSEIF문 : IF 조건식 1 THEN 실행내용1 ELSIF 조건식2 THEN 실행내뇽2 ...
    ELSE 실행내용 END IF; 
    
    - CASE/WHEN/THEN 문
        CASE 비교대상 WHEN 동등비교값1 THEN 결과값1
                     WHEN 동등비교값2 THEN 결과값2
                     WHEN 동등비교값3 THEN 결과값3
                     ... ELSE 결과값 N
                     END;
*/
-- 사용자에게 사번을 입력한 후 해당 사원의 사번, 이름, 급여, 보너스 정보를 출력 
-- 각 데이터에 대한 변수 : 사번(EID), 이름(ENAME), 급여(SAL), 보너스(BONUS)
-- 단, 보너스값이 0인 사원의 경우 "보너스를 받지 않는 사원입니다" 출력 

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;         
    ENAME EMPLOYEE.EMP_NAME%TYPE; 
    ESAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    
BEGIN 
    SELECT  EMP_ID , EMP_NAME, SALARY, NVL(BONUS, '0') 
        INTO  EID, ENAME, ESAL, BONUS
        FROM EMPLOYEE
        WHERE EMP_ID = '&EMP_ID';
       
        DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
        DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
        DBMS_OUTPUT.PUT_LINE('급여 : ' || ESAL);
        
        IF(BONUS = 0)
            THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급 받지 않는 사원입니다');
            
            ELSE 
            
            DBMS_OUTPUT.PUT_LINE('보너스율 ' || BONUS  || '%');
            END IF;
END;
/   

/*
    * DECLARE 
        레퍼런스 변수 (EID, ENAME, DTITLE, NCODE)
            참조변수(EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE)
         -- 일반타입변수(TEAM 문자타입) --> '국내팀' 또는 '해외팀' 저장할 예정
         
         BEGIN 
         -- 사용자가 입력한 사번의 해당하는 사번, 이름, 부서명, 근무국가코드 조회 
         -- 조회한 후 해당 변수에 저장 
         
         -- 이때 NCODE 값이 KO일 경우 '국내팀을' TEAM 변수에 저장 
         KO가 아닐 경우 '해외팀'을 TEAM 변수에 저장 
         
         -- 출력 형식 : 사번, 이름, 부서, 소속 
         END; 
         /
*/

DECLARE   
    EID EMPLOYEE.EMP_ID%TYPE;         
    ENAME EMPLOYEE.EMP_NAME%TYPE; 
    DTITLE DEPTARTMENT.DEPT_TITLE%TYPE;
    NCODE  NATIONAL.NATIONAL_CODE%TYPE;
    
    TEAM VARCHAR2(10);
    
BEGIN 

        SELECT  EMP_ID , EMP_NAME, DEPT_TITLE, NATIONAL_CODE
        INTO  EID, ENAME, DTITLE, NCODE
        FROM EMPLOYEE
        JOIN department ON DEPT_CODE = DEPT_ID
        JOIN  LOCATION ON LOCATION_ID = LOCAL_CODE 
        WHERE EMP_ID = '&EMP_ID';
       
       
        
        IF NCODE = 'KO'
            THEN TEAM := '국내팀';
        ELSE 
            TEAM := '해외팀';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
        DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
        DBMS_OUTPUT.PUT_LINE('부서명 : ' || DTITLE);
        DBMS_OUTPUT.PUT_LINE('NCODE : ' || NCODE);
            

END;
/

-- 점수 등급(SCORE)
-- 등급(GRADE) 'A', 'B', 'C','D','F' 
-- 그 아래면 F

DECLARE   
    SCORE NUMBER;
    CRADE CHAR(1);
    
BEGIN 
    SCOR := &점수;
    
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    
    DBMS_OUTPUT.PUT_LINE('점수는 ' || SCORE || '이고, 등급은 ' || GRADE || '입니다. '  );
    
    
    ELSE  GRADE := 'F';
    DBMS_OUTPUT.PUT_LINE('재수강 대상입니다 '  );
    
    END IF;
END;
     -- IF/ELSE문 : IF 조건식 THEN 조건식이 참일떄 실행내용 ELSE 실행 내용 

--------------------------------------------------------------------------------

-- 사번에 해당하는 사원의 부서코드 기준으로 부서명을 출력(JOIN 사용x)
DECLARE 
    EMP EMPLOYEE%ROWTYPE;
    DTITLE VARCHAR2(50);
BEGIN 
    SELECT *
    INTO EMP
    FROM EMPLOYEE 
    WHERE EMP_ID = &사번;
    
    -- 해당 사원의 부서코드 기준으로 부서명 저장 
    DTITLE := CASE EMP.DEPT_CODE
        WHEN 'D1' THEN '인사관리부' 
        WHEN 'D2' THEN '회계관리부'
        WHEN 'D3' THEN '마케팅부'
        WHEN 'D4' THEN '국내영업부'
        WHEN 'D5' THEN '해외영업부1'
        WHEN 'D6' THEN '해외영업부2'
        WHEN 'D7' THEN '해외영업부3'
        WHEN 'D8' THEN '기술지원부'
        WHEN 'D9' THEN '총무부'
        ELSE '부서없음'
        END;
        
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || '사원의 소속 부서는' || DTITLE || '입니다.');

END;
/
--------------------------------------------------------------------------------
/*
    * 반복문 
    
       - 기본 구문 : LOOP 
                    반복할 구문 
                    반복문을 종료할 구문 
                    END LOOP;
                    
               * 반복문을 종료할 구문 
               [1] IF 조건식 THEN; END IF; 
               [2] EXIT WHEN 조건식; 
               
            - FOR LOOP문 
                FOR 변수 [REVERSE] IN 초기값..최종값
                LOOP 반복할 구문 [반복문을 종료할 구문] END LOOP; 
                
        * REVERSE : 최종값부터 초기값까지 반복 
                
        - WHILE LOOP문
            WHILE 조건식 
            LOOP 반복할 구문 END LOOP;
*/
-- 기본구문 사용하여 'HELLO ORACLE!'을 5번 출력 

DECLARE 
    N NUMBER := 1;
    
BEGIN

    LOOP

        DBMS_OUTPUT.PUT_LINE( N || 'HELLO ORACLE');
            
        N := N+1;
       
        IF N > 5
            THEN EXIT;
        END IF;

    END LOOP;
END;


-------------------------------------------------------------------------------
DECLARE 
    I NUMBER := 1;
BEGIN

    FOR I IN REVERSE 1..5
        LOOP
         DBMS_OUTPUT.PUT_LINE( I || ' HELLO ORACLE!!');
    END LOOP;
END;


--------------------------------------------------------------------------------

BEGIN
    FOR I IN REVERSE 1..5
        LOOP
         DBMS_OUTPUT.PUT_LINE( I || ' HELLO ORACLE!!');
    END LOOP;
END;
--------------------------------------------------------------------------------

-- TEST
DROP TABLE TEST;

CREATE TABLE TEST (
    TNO NUMBER PRIMARY KEY,
    TDATE DATE
);

CREATE SEQUENCE SEQ_TNO
INCREMENT BY 2
MAXVALUE 1000
NOCYCLE 
NOCACHE;

-- TEST 테이블에 데이터를 100개 추가 (TNO: 시퀀스 적용, TDATE: 현재날짜 )



BEGIN
    
    FOR I IN REVERSE 1..100
    
    LOOP
    
    INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL, SYSDATE);
        
    END LOOP;
    
END;
/
SELECT * FROM TEST;



/*
  * 예외처리부 
    - 예외(EXCEPTION) : 실행중에 발생되는 오류 
   
   EXCEPTION 
      WHEN 예외명 THEN 예외처리구문; 
      WHEN 예외명 THEN 예외처리구문 
      WHEN OTHERS THEN 예외처리구문; 
      
      * 오라클에서 미리 정의한 예외들  = 시스템 예외 
       - NO_DATA_FOUND : 조회된 결과가 없을 때 
       - TOO_MANY_ROWS : 조회된 결과가 여러 행일 때 (=> 변수에 대입...)
       
       - ZERO_DIVIDE : 0으로 값을 나누려고할 떄
       - DUP_VAL_ON_INDEX : UNIQUE 조건에 위배될 때 (중복되는 경우)
       
       * OTHERS : 어떤 예외든 발생되었을 때 
*/

-- 사용자에게 숫자를 입력받아 10으로 나눈 결과를 출력 (0이 입력되었을 떄 오류가 발생할 수 있다 )
DECLARE
    NUM NUMBER := 0;
    
BEGIN
     NUM := &숫자;
     
     DBMS_OUTPUT.PUT_LINE(10 / NUM);
EXCEPTION WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('0으로 나눌 수 없습니다');
END;
/

--EMPLOYEE 테이블 
-- EMP_ID 컬럼을 기본키로 설정 
ALTER TABLE EMPLOYEE ADD PRIMARY KEY(EMP_ID);
-- 기본키 (PRIMARY KEY) : UNIQUE + NOT NULL

BEGIN 

    UPDATE  EMPLOYEE
    SET EMP_ID = '&변경할_사번'
    
    WHERE EMP_NAME = '노옹철';
    
    EXCEPTION 
        WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('중복된 사번입니다');
END;
/
---------------문제 -------------------------------------------------------------
/*
    * 사수의 사번을 입력 받아 해당 사원의 사번, 이름을 출력 
    
OTHERS
*/


DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;

BEGIN  
    SELECT  EMP_NAME, EMP_NAME 
    INTO EID, ENAME 
    FROM EMPLOYEE
    WHERE MANAGER_ID = '&사수사번';
    --문자타입으로 입력받고자 할 경우 ''작은따움표로 감싸준다. 
      
   DBMS_OUTPUT.PUT_LINE('사번' || EID);
   DBMS_OUTPUT.PUT_LINE('이름' || ENAME);

    EXCEPTION 
        WHEN NO_DATA_FOUND  THEN DBMS_OUTPUT.PUT_LINE('입력한 사수 사번을 가진 사원이 없습니다');
        WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('해당 사수에 대한 사원이 많습니다');
        WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다. 관리자에게 문의'); 
END; 
    










    
    
    


