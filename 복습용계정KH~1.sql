-- 모든 사람의 정보 조회 
SELECT * FROM customer;

-- 나이가 30대인 사람들의 정보 조회 


-- 광역시 
SELECT * 
FROM customer 
WHERE ADDRESS LIKE '%광역시%';


-- 이름이 두 자인 사람들의 정보 조회 
SELECT *
FROM customer
WHERE LENGTH(NAME) = 2; 
-- WHERE NAME LIKE '__';


-- 이름, 생년월일 나이 정보 조회 
SELECT NAME, birthdate,
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM  birthdate) + 1 나이
FROM customer;

-- 나이가 30대인 사람들의 정보 조회 
SELECT*
FROM customer
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BIRTHDATE) + 1 BETWEEN 30 AND 39;

-- SELECT ADDRESS LIKE(ADDRESS, '%광역시%') 
-- FROM customer; 


SELECT 
* FROM customer
WHERE BIRTHDATE in ''

--SELECT EMP_NAME, email, SUBSTR(email, '1',INSTR(EMAIL, '@') -1) 
--FROM EMPLOYEE;

--SELECT NAME BIRTHDATE
--FROM