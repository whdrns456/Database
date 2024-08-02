/*
    *VIEW (뷰)
    :SELECT문을 통해 얻어진 결과물을 저장해둘 수 있는 객체 
    = > 자주 사용하는 쿼리문을 저장해두면 매번 다시 해당 쿼리문을 기술할 필요가 없다 
    임시테이블과 같은 존재 : 실제 데이터가 저장되는 게 아니라, 논리적으로만 저장되어 있음!
*/
-- 사원(EMPPLOYEE), 부서(DEPARTMENT), 지역(LOCATION), 국가(LOCATION)


-- 한국에서 근무하는 사원 정보 조회 (사번, 이름, 부서명, 급여, 근무국가명)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE )
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '한국';
-- AND는 필요가 없다. 

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE, department, LOCATION L, NATIONAL N
WHERE (DEPT_CODE = DEPT_ID) AND LOCATION_ID = LOCAL_CODE AND (L.NATIONAL_CODE = N.NATIONAL_CODE) 
AND NATIONAL_NAME = '러시아';

/*
    VIEW 생성하기 
    
    CREATE VIEW 뷰명
    AS 서브쿼리 
*/

-- 참고사항 테이블 객체의 이름줄 때 참고!
--          테이블 : TB_XXX, 
--          뷰 : VW_XXX

CREATE VIEW VW_EMPLOYEE 
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE )
JOIN NATIONAL USING (NATIONAL_CODE);


-- 뷰를 생성할 수 있는 권한을 부여 (관리자 권한으로 실행!)
-- GRANT CREATE VIEW TO C##KH;


SELECT * FROM vw_employee;
--> 실제로는 아래와 같이 실행될 것임
SELECT * FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE )
JOIN NATIONAL USING (NATIONAL_CODE));

SELECT * FROM vw_employee
WHERE NATIONAL_NAME = '한국';

-- 러시아에서 근무하는 사원 정보 조회

SELECT * FROM vw_employee
WHERE NATIONAL_NAME = '러시아';

-- (참고) 현재 계정으로 설정된 뷰 목록 조회 -->TEXT 컬럼에 저장된 서브쿼리 정보가 있음!
SELECT * FROM USER_VIEWS;

-- view도 옵션이 있다.

-- 덮어쓰기가 됨 OR REPLACE

CREATE OR REPLACE VIEW VW_EMPLOYEE 
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE )
JOIN NATIONAL USING (NATIONAL_CODE);

SELECT * FROM VW_EMPLOYEE;
--------------------------------------------------------------------------------

/*
    -- * 사번, 사원명, 직급명, 성별(남|여), 근무년수 정보를 조회 
*/

SELECT EMP_ID 사번, EMP_NAME 이름, JOB_CODE 직급명, DECODE(SUBSTR(EMP_NO, 8, 1), '1''남','2','여') 성별
,EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) + 1 근무년수
FROM employee
JOIN JOB USING(JOB_CODE);
   
-- => 함수식 또는 연산식이 있는 경우 별칭을 부여해야지 view로 잘 생성할 수 있다 
-- 모든 컬럼명을 순서대로 뷰명 옆에 나열하여 작성 가능!

CREATE OR REPLACE VIEW VW_EMP_JOB (사번, 이름,직급명,성별,근무년수)
AS SELECT EMP_ID, EMP_NAME, JOB_CODE , DECODE(SUBSTR(EMP_NO, 8, 1), '1''남','2','여') 성별
,EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) + 1 근무년수
FROM employee
JOIN JOB USING(JOB_CODE);

SELECT * FROM vw_emp_job WHERE 성별 = '여';
SELECT * FROM vw_emp_job WHERE 근무년수 >= 20;

DROP VIEW VW_EMP_JOB;








