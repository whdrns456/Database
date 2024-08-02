--=========================================================================
-- 수업용 계정 로그인 후 아래 정보를 조회할 수 있는 쿼리문을 작성해주세요 :D
--=========================================================================
-- 이메일의 아이디 부분에(@ 앞부분) k가 포함된 사원 정보 조회
SELECT *
FROM employee
WHERE email LIKE '%k%@%';
-- 내가 잘 모르는 부분 

-- 부서별 사수가 없는 사원 수 조회
SELECT DEPT_CODE,COUNT(*)
FROM employee
WHERE MANAGER_ID IS NULL
GROUP BY DEPT_CODE;

-- 연락처 앞자리가 010, 011로 시작하는 사원 수 조회
SELECT SUBSTR(PHONE, 1, 3),count(*)
FROM employee
WHERE SUBSTR(PHONE, 1, 3) IN('010','011')
GROUP BY SUBSTR(PHONE, 1, 3);
-- GROUP BY에는 컬럼뿐만 아니라 함수도 들어갈 수 있다. 


-- 부서별 사수가 없는 사원 정보 조회 (부서명, 사번, 사원명 조회)

-- ** 오라클 구문 **
SELECT DEPT_TITLE, EMP_ID, EMP_NAME
FROM employee, department
WHERE DEPT_CODE = DEPT_ID AND manager_id IS NULL;

-- ** ANSI 구문 **
SELECT DEPT_TITLE, EMP_ID, EMP_NAME
FROM employee
JOIN department ON ( DEPT_CODE = DEPT_ID) -- 조인할 때 기준이 되는 컬럼의 조건  
AND manager_id IS NULL;                   -- 사수가 없는 사원에 대한 조건

-- 부서별 사수가 없는 사원 수 조회 (부서명, 사원수 조회)
-- ** 오라클 구문 **
SELECT DEPT_TITLE, count(*) 
FROM employee, department
WHERE DEPT_CODE = DEPT_ID AND  MANAGER_ID IS NULL
group by dept_title; 


-- ** ANSI 구문 **
SELECT DEPT_TITLE, COUNT(*)
FROM employee
JOIN department ON (DEPT_CODE = DEPT_ID)
AND  MANAGER_ID IS  NULL
group by dept_title;


