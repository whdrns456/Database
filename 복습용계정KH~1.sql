-- ��� ����� ���� ��ȸ 
SELECT * FROM customer;

-- ���̰� 30���� ������� ���� ��ȸ 


-- ������ 
SELECT * 
FROM customer 
WHERE ADDRESS LIKE '%������%';


-- �̸��� �� ���� ������� ���� ��ȸ 
SELECT *
FROM customer
WHERE LENGTH(NAME) = 2; 
-- WHERE NAME LIKE '__';


-- �̸�, ������� ���� ���� ��ȸ 
SELECT NAME, birthdate,
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM  birthdate) + 1 ����
FROM customer;

-- ���̰� 30���� ������� ���� ��ȸ 
SELECT*
FROM customer
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BIRTHDATE) + 1 BETWEEN 30 AND 39;

-- SELECT ADDRESS LIKE(ADDRESS, '%������%') 
-- FROM customer; 


SELECT 
* FROM customer
WHERE BIRTHDATE in ''

--SELECT EMP_NAME, email, SUBSTR(email, '1',INSTR(EMAIL, '@') -1) 
--FROM EMPLOYEE;

--SELECT NAME BIRTHDATE
--FROM