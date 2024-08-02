-- ━━━━???━━━━ 수업용 계정 접속 후 아래 SQL문을 작성해주세요 ━━━━???━━━━
--============================================================================--

-- [1] '240724' 문자열을 '2024년 7월 24일'로 표현해보기
SELECT  TO_CHAR(TO_DATE(240724), 'YYYY"년" MM"월" DD"일"')
FROM DUAL;

-- [2] 본인이 태어난 지 며칠째인지 확인해보기 (현재날짜 - 생년월일)
SELECT  CEIL(SYSDATE - TO_DATE('94/03/07'))
from dual;


-- [3] 다음 문장을 바꿔보기
-- bElIVe iN YoURseLF.      -->  Belive in yourself.
SELECT concat(upper(SUBSTR('bElIVe iN YoURseLF.', 1, 1)), LOWER(SUBSTR('Belive in yourself.', 2))) 
FROM DUAL;

-- 


/*
------------------------------------------------------------
    생월     |   입사월   |   입사 사원수|
         7월 |       4월 |          2명|
         7월 |       9월 |          1명|
         ...
         9월 |       6월 |          1명|
------------------------------------------------------------
*/
-- [4] 생일이 7월이후인 사원들의 입사월별 사원 수 조회 (아래와 같이 출력)
SELECT LPAD(SUBSTR(EMP_NO, 3, 2) || '월', 8) "생월"
    ,  EXTRACT(MONTH FROM HIRE_DATE) || '월'
    , LPAD(COUNT(*) || '명',5) "입사 사원수"
FROM employee
WHERE TO_NUMBER(SUBSTR(EMP_NO, 3, 2)) >= 7 
GROUP BY SUBSTR(EMP_NO, 3, 2), EXTRACT(MONTH FROM HIRE_DATE);
-- ~별 group BY


-- [5] 영업부서 사원의 사번, 사원명, 부서명, 직급명 조회

-- 사원, 부서, 직급 -- > 조인
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM employee
    JOIN department ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE)
WHERE DEPT_TITLE LIKE '%영업%';
    -- ON과 USING 둘 중 하나만 





