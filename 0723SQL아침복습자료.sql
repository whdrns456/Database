--=========================================================================
-- ������ ���� �α��� �� �Ʒ� ������ ��ȸ�� �� �ִ� �������� �ۼ����ּ��� :D
--=========================================================================
-- �̸����� ���̵� �κп�(@ �պκ�) k�� ���Ե� ��� ���� ��ȸ
SELECT *
FROM employee
WHERE email LIKE '%k%@%';
-- ���� �� �𸣴� �κ� 

-- �μ��� ����� ���� ��� �� ��ȸ
SELECT DEPT_CODE,COUNT(*)
FROM employee
WHERE MANAGER_ID IS NULL
GROUP BY DEPT_CODE;

-- ����ó ���ڸ��� 010, 011�� �����ϴ� ��� �� ��ȸ
SELECT SUBSTR(PHONE, 1, 3),count(*)
FROM employee
WHERE SUBSTR(PHONE, 1, 3) IN('010','011')
GROUP BY SUBSTR(PHONE, 1, 3);
-- GROUP BY���� �÷��Ӹ� �ƴ϶� �Լ��� �� �� �ִ�. 


-- �μ��� ����� ���� ��� ���� ��ȸ (�μ���, ���, ����� ��ȸ)

-- ** ����Ŭ ���� **
SELECT DEPT_TITLE, EMP_ID, EMP_NAME
FROM employee, department
WHERE DEPT_CODE = DEPT_ID AND manager_id IS NULL;

-- ** ANSI ���� **
SELECT DEPT_TITLE, EMP_ID, EMP_NAME
FROM employee
JOIN department ON ( DEPT_CODE = DEPT_ID) -- ������ �� ������ �Ǵ� �÷��� ����  
AND manager_id IS NULL;                   -- ����� ���� ����� ���� ����

-- �μ��� ����� ���� ��� �� ��ȸ (�μ���, ����� ��ȸ)
-- ** ����Ŭ ���� **
SELECT DEPT_TITLE, count(*) 
FROM employee, department
WHERE DEPT_CODE = DEPT_ID AND  MANAGER_ID IS NULL
group by dept_title; 


-- ** ANSI ���� **
SELECT DEPT_TITLE, COUNT(*)
FROM employee
JOIN department ON (DEPT_CODE = DEPT_ID)
AND  MANAGER_ID IS  NULL
group by dept_title;


