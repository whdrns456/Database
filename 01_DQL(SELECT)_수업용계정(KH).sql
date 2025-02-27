/*
 데이터 조회(추출) : SELECT 
 
   - SELECT 조회하고자 하는 정보 FROM 테이블명; 
   - SELECT * 또는 컬럼명1, 컬럼명2, ... FROM 테이블명; 
  */
-- 모든 사원의 정보를 조회 
SELECT * FROM EMPLOYEE;


-- 모든 사원의 이름, 주민등록번호, 핸드폰 번호를 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE; 

-- JOB 테이블에서 직급이름만 조회 

SELECT JOB_NAME -- 컬럼 
FROM JOB; 
-- SELECT FROM JOB_NAME;

-- DEPARTMENT 테이블의 모든 정보를 조회 
SELECT * FROM DEPARTMENT; -- 대소문자 "" 안에서 구분 

-- 직원 테이블의 사원명, 이메일, 연락처, 입사일, 급여 조회
 

SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*

    컬럼값에 산술 연산하기 
    => SELECT절에 컬럼명 작성부분에 산술연산을 할 수 있다. 

*/

-- 사원 이름, 연봉 정보조회

SELECT EMP_NAME, SALARY 급여, (SALARY * 12) 연봉 -- SALARY 컬럼 데이터에 12를 곱하여 조회 
FROM  employee;

-- 사원 이름, 급여, 보너스, 보너스 포함 연봉(급여*보너스)*12 
SELECT EMP_NAME, SALARY,  BONUS "보너스 율", SALARY * 12, (SALARY +(SALARY * BONUS))*12
FROM  employee;

// 날짜타입

/*
        - 현재 날짜시간 정보 : SYSDATE
        - 가상 테이블(임시테이블) : DUAL

*/

-- 현재 시간 정보 조회 

SELECT SYSDATE  FROM DUAL; // YY/MM/DD 형식으로 조회됨!


-- 사원이름, 입사일, 근무일수 조회 
--DATE타입 - DATE타입 => 일로 표시됨!

SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE "근무 일수"
FROM employee;

/*

    *컬럼명 별칭 지정 : 연산식을 사용한 경우 의미파악이 어렵기 때문에, 
    별칭을 부여하고 명확하고 깔끔하게 표현할 수 있다  
    
    [표현법] 
            1) 컬럼명 별칭 
            2) 컬럼명 AS 별칭 
            3) 컬럼명 "별칭"
            3) 컬럼명 AS "별칭"
*/

-- 사원 이름, 급여, 보너스, 보너스 포함 연봉(급여*보너스)*12 
SELECT EMP_NAME 사원이름, SALARY as 급여,  BONUS 보너스, SALARY * 12 연봉, (SALARY +(SALARY * BONUS))*12 "보너스 포함 연봉"
FROM  employee;

/*
    값 자체 = 리터럴 
    
    리터럴 : 임의로 지정한 문자열 : ('') 작따 
    -> SELECT 절에 사용하는 경우 조회된 결과 (Result set)에 반복적으로 표현 
    
    -- 이름, 급여, '원' 조회 

*/


SELECT EMP_NAME 이름, SALARY 급여, '원' 단위 -- 조회하는 문법
FROM employee;

/*
  연결 연산자 : || 
  
*/

SELECT SALARY || '원'  급여  
FROM employee;

-- 사번, 이름, 급여일을 한번에 조회 
SELECT EMP_ID || EMP_NAME || SALARY    
FROM employee;


-- xxx의 급여는 xxxx원입니다 형식으로 출력 
SELECT EMP_NAME || '의 급여는' || SALARY || '원입니다' 급여정보
FROM employee;

-- 사원 테이블에서 직급 코드 

SELECT JOB_CODE || '입니다' 직급코드
FROM employee;

/*
 중복 제거 : DISTINCT
*/

SELECT DISTINCT JOB_CODE || '입니다' 직급코드
FROM employee;

-- DEPT_CODE

SELECT DISTINCT DEPT_CODE || ' 부서 코드 입니다' 직급코드
FROM employee;
-- DISTINCT는 한번만 사용 가능 
-- DISTINCT(JOB, DEPT_CODE) 한 쌍으로 묶어서 중복을 제거
-- 두개다 겹치는 걸 제거 

-- (JOB_CODE, DEPT_CODE)를 한 쌍으로 묶어서 중볷을 제거해줌
SELECT DISTINCT JOB_CODE, dept_code
FROM employee;

-- =======================================================================

/*
    WHERE 절 : 조회하고자 하는 데이터를 특정 조건에 따라 데이터를 추출하고자 할 떄 
    
    SELECT [컬럼명, 컬럼]데이터 기준 연산식 
    FROM 테이블명
    WHERE 조건;

    * 대소비교 : >, <, >=, <=
    * 동등비교 
      - 같은 지 : =
      - 다른지 : !=, <> 제네릭 ^=
*/

-- 사원테이블에서 부서코드가 'D9'인 사원들만 조회

SELECT * FROM employee   -- 전체 컬럼을 조회할 건데 
WHERE dept_code = 'D9';   -- EMPLOYEE
-- DEPT_CODE의 값이 'D9'인 정보만 조회 

-- 사원테이블에서 부서코드가 D1인 사원들의 사원명, 급여, 부서코드 조회 

SELECT EMP_NAME , SALARY 급여, DEPT_CODE 부서코드
FROM employee
WHERE dept_code = 'D1';

-- 부서코드가 D1이 아닌 사원들의 정보 조회(사원명, 급여, 부서코드)


SELECT EMP_NAME, SALARY, DEPT_CODE
FROM employee
WHERE dept_code <> 'D1';


-- 급여가 400만원 이상인 사원의 사원명 부서코드, 급여 정보를 조회
SELECT EMP_NAME 기다운, DEPT_CODE, SALARY * 12 || '원' as  급여
FROM employee
WHERE SALARY  > '400000';



-- 1 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉 조회()별칭적용
SELECT EMP_NAME 기다운,SALARY 급여, HIRE_DATE 입사일, (SALARY * 12) 연봉 
FROM employee
WHERE SALARY  >= '3000000';

-- === 2 연봉이 5천만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드조회 == 
SELECT EMP_NAME 기다운,SALARY 급여, SALARY * 12 연봉, dept_code
FROM employee
WHERE SALARY * 12  >= '50000000';

-- 3. 직급코드 'J3'가 아닌 사원들의 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회
SELECT  EMP_NO,EMP_NAME 기다운, JOB_CODE "직급 번호", ENT_DATE
FROM employee
WHERE JOB_CODE  <> 'J3'; -- 대소문자 구분한다 

-- 4 급여가 350 이상 600 만원 이하인 모든 사원의 사원명, 사번, 급여조회 
SELECT  EMP_NO,EMP_NAME 기다운, SALARY 
FROM employee
WHERE SALARY  >= '3000000' AND SALARY <= 6500000;

-- ============================================================================
/*
 * BETWEEN AND : 조건식에서 사용되는 구문 
   => 0이상 ~이하인 범위에 대한 조건을 제시하는 구문 
        
    [표현법]
            비교대상컬럼명 : BETWEEN 최소값 AND 최댓값
            = > 해당 컬럼의 값이 최소값 이상이고 최대값 이하인 경우 
*/

-- 급여가 350만원 이상이고 600만원 이하인 사원의 사원명, 사번, 급여 조회
SELECT EMP_NAME, EMP_ID,  SALARY
FROM employee
WHERE SALARY >= 3500000 AND SALARY <= 60000000;

-- BETWEEN을 사용한 예 
SELECT EMP_NAME, EMP_ID,  SALARY
FROM employee
WHERE SALARY BETWEEN 3500000 AND 6000000;

/*
        * ! 오라클에서의 논리부정연산자 
        * NOT
*/

-- NOT 급여가 350만원 미만 또는 600만원 초과인 사원의 사원명, 사번, 급여 조회(NOT X)

SELECT EMP_NAME, EMP_ID,  SALARY
FROM employee
WHERE SALARY < 3500000 OR SALARY > 6000000; 


-- NOT 급여가 350만원 미만 또는 600만원 초과인 사원의 사원명, 사번, 급여 조회(NOT O)

SELECT EMP_NAME, EMP_ID,  SALARY
FROM employee
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

-- NOT은 BETWEEN 앞에 붙이거나 컬럼명 앞에 붙여서 사용 가능!


/*
    IN : 비교대상컬럼값이 제시한 값들 중에 일치하는 값이 있는 경우 조회하는 연산자 
    
    [표현법]
            비교대상컬럼명 IN ('값1','값2','값3', .....)            
*/
-- 부서코드가 D6이거나 D8이거나 
-- 사원명, 부서코드, 급여를 조회 (IN : X)

SELECT EMP_NAME, dept_code,  SALARY
FROM employee
WHERE dept_code = 'D6' OR  dept_code = 'D8' OR dept_code = 'D5';


SELECT EMP_NAME, dept_code,  SALARY
FROM employee
WHERE dept_code IN  ('D6','D8','D5');


SELECT EMP_NAME, DEPT_CODE, hire_date
FROM employee
WHERE DEPT_CODE IN ('D9','D5') AND hire_date  < '02/01/01';

-- ==============================================================
/*
    * LIKE : 비교하고자하는 컬럼의 값이 제시한 특정 패턴에 만족할 경우 조회 
    = > 특정 패턴 : '%', '_'를 와일드카드로 사용 
        '%' : 0글자 이상 
    * ex) 비교대상컬럼명 LIKE '문자%' => 비교대상컬럼의 값에 문자로 시작되는 것을 조회 
          비교대상컬럼명 LIKE '%문자' => 비교대상컬럼의 값이 문자로 끝나는 것을 조회 
          
          문자다
          문자
          문자에요
          이것은 문자다
          
          => 비교대상컬럼의 값에 문자가 "포함"되는 것을 조회 %문자% (키워드 검색)
          문자가 포함된 전부가 
          
          
          '_' : 1글자 
        ex) 비교대상컬럼명 LIKE '_문자' => 비교대상컬럼의 값에서 문자 앞에 무조건 한글자가 올 경우 조회
            비교대상컬럼명 LIKE '__문자' => 비교대상컬럼의 값에서 문자 앞에 무조건 두글자가 올경우 
            비교대상컬럼명 LIKE '_문자_' => 비교대상컬럼의 값에서 문자 앞 뒤에 무조건 한글자씩 있을 경우 조회        
*/

-- 사원들 중에 전씨인 사원의 사원명 급여, 입사일 
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM employee
WHERE EMP_NAME LIKE '기%'; -- 시작되는 값 조회 
-- 사원 이름에 하가 포함된 


SELECT EMP_NAME, EMP_NO, PHONE
FROM employee
WHERE EMP_NAME LIKE '%임%'; -- 키워드 검색 
-- 사원 이름의 가운데 글자가 하인 사원 사원명, 연락처 조회


SELECT EMP_NAME, PHONE
FROM employee
WHERE EMP_NAME LIKE '_수_'; --

-- 사원들 중 연락처의 3번째 자리가 1인 사원의 사번 사원명 연락처 이메일 

SELECT EMP_ID, EMP_NAME, PHONE, email
FROM employee
WHERE PHONE LIKE '__1%'; -- 시작되는 값 조회 



-- 사원들 중 이메일에 4번째 _가 있으면 해당 문자 앞이 3글자인 사원의 사번, 이름,이메일 조회
SELECT EMP_ID, EMP_NAME, email
FROM employee
WHERE email LIKE '___';  

--  ESCAPE
--> 와일드카드로 사용되는 문자와 컬럼에 담긴 문자가 동일하기 때문에 모두 와일드카드로 인식됨
--> 따라서, 구분을 해줘야 함! (=> ESCAPE를 사용하여 등록 후 적용)

SELECT EMP_ID, EMP_NAME, email
FROM employee
WHERE email LIKE '___!_%' ESCAPE '!';
-- =======================================================

/*
    IS null / IS not Null : 컬럼값에 NULL이 있을 경우 NULL값을 비교할 때 사용하는 연산자 
*/
-- 보너스를 받지 않는 사원들의(BONUS의 값이 NULL) 사번, 이름,급여,보너스 조회 
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM employee
WHERE bonus IS NULL;

-- 보너스를 받는 사원들의 사번, 이름, 급여, 보너스 조회 

SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM employee
-- WHERE bonus IS not NULL
WHERE  bonus IS NOT NULL;


-- 사수가 없는 사원 (MANAGER_ID의 값이) NULL!들의 사원명, 사수사번, 부서코드 조회
SELECT  EMP_NAME, MANAGER_ID, DEPT_CODE
FROM employee
-- WHERE bonus IS not NULL
WHERE MANAGER_ID IS NULL;

-- 부서 배치를 받지 않았지만, 보너스를 받고 있는 사원의 사원명, 보너스, 부서코드 조회
SELECT  EMP_NAME, bonus, DEPT_CODE
FROM employee
-- WHERE bonus IS not NULL
WHERE dept_code IS NULL AND BONUS IS NOT NULL; 
-- =============================================================================

/*
   * 연산자 우선 순위 
   - 0 : ()
   - 1 : 산술연산 : +,-,*,/
   - 2 : 연결연산자 : ||
   - 3 : 비교연산자 : > < >= <= = != ^= <>
   - 4 : IS NULL, IS NOT NULL '패턴' / IN
   - 5 : BETWEEN AND
   - 6 : NOT 
   - 7 : AND
   - 8 : OR
*/

-- 직급코드가 J7이거나 T2인 사원들 중 급여가 200만원 이상인 사원의 모든 정보를 조회 
SELECT * FROM employee
-- WHERE bonus IS not NULL
WHERE job_code IN('J7', 'J2') AND SALARY >= '2000000'; 

-- ==========================================================================
/*
    * ORDER BY : SELECT문의 가장 마지막 줄에 작성, 실행 순서 또한 마지막에 실행 
    
    [표현법]
            SELECT 조회할 컬럼...
            FROM 테이블명 
            WHERE 조건식 
            ORDER BY 정렬기준으로 잡은 컬럼 |별칭| 컬럼 순번 [ASC | DESC] 생략 가능 
            NULLS FIRST| NULLS LAST 
            
    * ASC : 오름차순 정렬(기본값)
    *DESC : 내림차순 정렬
    
    *  NULLS FIRST : 정렬하고자하는 컬럼의 값이 NULL인 경우 해당 데이터를 맨 앞에 배치
        [DESC인 경우 기본값]
    *  NULLS LAST  : 정렬하고자하는 컬럼의 값이 NULL인 경우 해당 데이터를 맨 뒤에 배치 
        [ASC인 경우 기본값]
        
        
        = > NULL 값은 큰 값으로 분류되어 정렬된다. 
    
*/

-- 모든 사원의 사원명, 연봉 조회 (연봉별 내림차순 정렬)





SELECT EMP_NAME, SALARY *12 연봉  
FROM employee   
ORDER BY 2 DESC; -- 컬럼 순번 사용 (오라클에서는 1부터 시작!)

-- 보너스 기준으로 정렬해보기 

SELECT *  
FROM employee   
ORDER BY bonus; -- 기본값 (ASC, NULLS LAST)

SELECT *  
FROM employee   
ORDER BY bonus ASC; -- 기본값 (ASC, NULLS LAST)

SELECT *  
FROM employee   
ORDER BY bonus ASC NULLS LAST; -- 기본값 (ASC, NULLS LAST)


SELECT *  
FROM employee   
ORDER BY bonus DESC; -- 기본값 (ASC, NULLS FIST)


-- 보너스는 내림차순, 급여는 오름차순
SELECT *  
FROM employee   
ORDER BY bonus DESC, SALARY ASC; -- 기본값 (ASC, NULLS FIST
-- 보너스 값을 내림차순 정렬하는데 같은 값인 경우 급여의 값을 오름차순 정렬하겠다

-----------------------------------------------------------------------------
















