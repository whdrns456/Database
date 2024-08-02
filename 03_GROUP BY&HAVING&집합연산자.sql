/*

    GROUP BY절 
    : 그룹 기준을 제시할 수 있는 구문 
    : 여러 개의 값들을 하나의 그룹으로 묶어서 처리하는 목적으로 사용 

*/
-- 전체 사원의 급여 총 합 조회
SELECT TO_CHAR(SUM(SALARY), 'L9,999,999,999') 
FROM employee;

-- 부서별 급여 총 합 조회 
SELECT DEPT_CODE, SUM(SALARY)
FROM employee 
GROUP BY DEPT_CODE;

-- 부서별 사원 수 조회 
SELECT DEPT_CODE, COUNT(*)       -- 3
FROM employee                    -- 1
GROUP BY DEPT_CODE;              -- 2

-- 부서코드가 D6, D9, D1인 각 부서별 급여 총합, 사원 수 조회 

SELECT DEPT_CODE, SUM(SALARY), COUNT(*)   -- 4
FROM employee                             -- 1
WHERE DEPT_CODE IN('D6','D9','D1')        -- 2
GROUP BY DEPT_CODE                        -- 3 
ORDER BY DEPT_CODE;                       -- 5

-- 각 직급별 총 사원수/보너스를 받는 사원수/ 급여합/평균급여/최저급여/ 최고급여 조회 
-- 단, 직급 오름차순 

SELECT JOB_CODE,COUNT(*) "총 사원수", COUNT(BONUS) "보너스를 받는 사원 수", ROUND(AVG(SALARY)) "평균급여", MIN(SALARY)"최저급여", MAX(SALARY)"최고급여"
FROM employee
WHERE BONUS is not null
GROUP BY JOB_CODE
ORDER BY JOB_CODE;
-- COUNT에 컬럼만 넣을 경우 NULL이 아닐 경우는 제외하고 갯수를 세어준다. 

-- 남자 사원 수, 여자 사원 수 조회 
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') "성별", COUNT(*) "사원 수"
FROM employee
GROUP BY SUBSTR(EMP_NO, 8, 1);
-- DECODE : 선택함수 

-- 부서 내 직급별 사원수, 급여 총합:
SELECT DEPT_CODE, JOB_CODE, COUNT(*) "사원수", SUM(SALARY) "급여총합"
FROM employee
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;
-- 부서코드에서 먼저 정렬한 후 
-- 부서코드 기준으로 그룹화하고, 그 내에서 직급코드 기준으로 세부그룹화 함!


-- 그룹절에 기준 

/*
        HAVING절 
        : 그룹에 대한 조건을 제시할 때 사용되는 구문 (보통 그룹함수식을 가지고 조건을 작성함!)
*/
-- 각 부서별 평균 급여 조회(부서, 평균 급여)
-- 각 부서별 평균 급여가 300만원 이상인 부서만 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM employee
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= '3000000' 
-- WHERE AVG(SALARY) >= '3000000' -- WHERE 절에서는 그룹함수 사용 불가!
-- 그룹함수는 허가되지 않는다라고 뜸. 
ORDER BY DEPT_CODE;

-- 직급 별 직급코드, 총 급여합 조회(단 직급별 급여 합이 1000만원 이상인 직급만 조회)

SELECT JOB_CODE, SUM(SALARY)
FROM employee
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= '10000000' 
ORDER BY JOB_CODE;

-- 부서별 보너스를 받는 사원이 없는 부서의 부서코드 조회 
-- WHERE BONUS IS NULL -- 부서 상관없이 보너스가 NULL인 사원들을 먼저 걸러낸다. -> 해당 부서에 
-- 보너스가 있는 사람이 있을  수 있음 
SELECT DEPT_CODE 부서코드
FROM employee
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;
-- 그룹화한 후에 COUNT함수를 사용하여 BONUS 받는 사원이 없는 조건을 제시해해야한다 


/*
        * 실행 순서 
        SELECT * | 조회하고자 하는 컬럼 AS "별칭" | 함수식 | 연산식 
        FROM 조회하고자 하는 테이블 | DUAL 
        WHERE 조건식(연산자들을 활용하여 작성)
        GROUP BY 그룹화할 기준이 되는 컬럼 | 함수식 
        HAVING 조건식 (그룹함수를 활용하여 작성)
        
        ORDER BY 컬럼 | 별칭 사용가능 컬럼 순서 가능하다 [ASC | DESC]
        * NULLS FIRST(DESC), NULLS LAST(ASC)
        
        SELECT 5번쨰로 실행이 된다 
        FROM절이 첫 번째로 실행이 된다. 
        WHERE 두 번쨰로 실행이 된다 
        GROUP BY  세번째로 실행 
        HAVING 조건식 네번쨰로 실행 
        ORDER BY 마지막으로 실행 
        
        -- > 오라클은 순서(위치) 1부터 시작
        
*/
-- ===============================================================

/*
     * 집합 연산자 
     
     : 여러 개의 쿼리문을 하나의 쿼리문으로 만들어주는 연산자
     
     - UNION : 합집합 OR(두 쿼리문을 수행한 결과값을 더해줌)
     - INTERSECT : 교집합 AND (두 쿼리문을 수행한 결과값의 중복된 부분을 추출해준다.)
     - UNION ALL : 합집합 + 교집합(중복되는 부분이 두번 표시될 수 있다)
     - MINUS : 차집합(선행 결과값에 후행 결과값을 뺸 나머지)   
*/



-- **UNION**
-- 부서코드가 D5인 사원 또는 급여가 300만원 초과인 사원들의 사번, 이름, 부서코드, 급여 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

-- 부서코드가 D5인 사원의 사번, 이름, 부서코드, 급여 조회 
-- 급여가 300만원 초과인 사원의 사번, 이름, 부서코드, 급여조회 



-- UNION으로 2개 쿼리문을 합치기 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5'
UNION -- ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE  SALARY > 3000000;

-- ** 교집합(INTERSECT)
-- 부서코드가 D5이고 급여가 300만원 초과인 사원의 사번, 이름, 부서코드, 급여 조회 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5'
MINUS 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY  > 3000000;
-- INTERSECT



-- MINUS : 선행 결과값에서 후행 결과 값을 뺀 나머지 
-- 부서코드가 D5인 사원들 중 급여가 300만원 초과인 사원들을 제외하고 조회

/*
        집합 연산자 사용 시 주의사항 
        
        1) 컬럼 갯수가 동일해야한다. 
        2) 컬럼 자리마다 동일한 타입으로 작성해야 함 
        3) 정렬하고자 한다면 ORDER BY절은 마지막에 작성해야한다.
*/








