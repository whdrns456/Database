-- * ������ �������� ������ �� �Ʒ� �������� �������ּ���.
--   USERNAME / PWD : C##TESTUSER / 1234
--------------------------------------------------------------------------------------------------------
DROP TABLE DEPARTMENTS;
DROP TABLE EMPLOYEES;

-- DEPARTMENTS ���̺� ����
CREATE TABLE DEPARTMENTS (
    DEPT_ID NUMBER PRIMARY KEY,
    DEPT_NAME VARCHAR2(50) NOT NULL
);

-- EMPLOYEES ���̺� ����
CREATE TABLE EMPLOYEES (
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(50) NOT NULL,
    SALARY NUMBER,
    HIRE_DATE DATE,
    DEPT_ID NUMBER,
    FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENTS(DEPT_ID)
);

-- DEPARTMENTS ������ ����
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (1, '�λ��');
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (2, '�繫��');
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (3, 'IT�μ�');

-- EMPLOYEES ������ ����
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (101, 'ȫ�浿', 5000, TO_DATE('2020-01-15', 'YYYY-MM-DD'), 1);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (102, '��ö��', 4500, TO_DATE('2019-03-22', 'YYYY-MM-DD'), 2);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (103, '�̿���', 5500, TO_DATE('2021-07-10', 'YYYY-MM-DD'), 3);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (104, '������', 6500, TO_DATE('2018-11-05', 'YYYY-MM-DD'), 2);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (105, '�ֹ�ȣ', 7000, TO_DATE('2022-02-18', 'YYYY-MM-DD'), 1);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (106, '�ű��', 4000, TO_DATE('2024-05-13', 'YYYY-MM-DD'), 3);
--------------------------------------------------------------------------------------------------------

-- ��� ������ �̸��� �޿��� ��ȸ 

SELECT EMP_NAME, SALARY 
FROM employeeS;

-- '�繫��'�� ���� �������� �̸��� �μ����� ��ȸ 
SELECT EMP_NAME, DEPT_NAME
FROM employees E, DEPARTMENTS D
WHERE E.DEPT_ID = D.dept_id AND DEPT_NAME = '�繫��';

-- ��� ������ ��� �޿��� ��� 
-- * �ݿø� : ROUND, �ø� : CEIL , 
SELECT ROUND(AVG(SALARY))
FROM employees;


-- �μ��� ���� ���� ����ϰ�, ���� ���� 1�� �̻��� �μ��� ��ȸ 
SELECT DEPT_ID, COUNT(*)
FROM employees
GROUP BY DEPT_ID
HAVING  COUNT(*) >= 1;

-- ��� ������ �̸��� �ش� �μ����� ��ȸ 
SELECT EMP_NAME, DEPT_NAME
FROM employees, departments
WHERE employees.dept_id = departments.dept_id;


-- �޿��� ���� ���� ������ �̸��� �޿��� ��ȸ
SELECT EMP_NAME, SALARY 
FROM employees
WHERE salary = (SELECT MAX(SALARY) FROM employees);


-- ���ο� ���̺� PROJECTS�� ���� ( ���� ����: ������Ʈ��ȣ (PROJECT_ID:NUMBER (PK), ������Ʈ�� (PROJECT_NAME:VARCHAR2(100) NULL ���X)))

CREATE TABLE PROJECTS(
        
        PROJECT_ID NUMBER CONSTRAINT PRH_PK PRIMARY KEY, 
        PROJECT_NAME VARCHAR2(100) NOT NULL 
        
        
); 

-- ���ο� ���� '�����'�� EMPLOYEES ���̺� ���� ( ��� ����, �޿� 6200, IT�μ�, ���� �Ի�)
INSERT INTO EMPLOYEES VALUES (107,'�����',6200, sysdate, 3);
-- ������ ���� x commit����ߵô٤� 


SELECT *  FROM EMPLOYEES
WHERE EMP_NAME = 'ȫ�浿';

-- EMPLOYEES ���̺��� 'ȫ�浿'�� �޿��� 5500���� ����
UPDATE employees
SET SALARY = 5500
WHERE EMP_NAME = 'ȫ�浿';


-- EMPLOYEES ���̺��� �޿��� 5000 ������ �������� ����
dELETE FROM employees;
ROLLBACK;
dELETE FROM employees WHERE SALARY <= 5000;

-- EMPLOYEES ���̺� ���ο� �÷� EMAIL�� �߰� (VARCHAR2(100))
ALTER TABLE EMPLOYEES
ADD EMALL VARCHAR2(100);
--DDL�� �����ϴ� ���� �ڵ� Ŀ�Եȴ�

-- �μ��� ��� �޿��� ����ϰ�, ��� �޿��� 6000 �̻��� �μ��� ��ȸ
SELECT DEPT_NAME, AVG(SALARY)
FROM EMPLOYEES
    JOIN departments USING(DEPT_ID)
GROUP BY DEPT_NAME
HAVING AVG(SALARY) >= 6000;

-- ��� ������ �̸��� �޿��� �����ϴ� �� EMP_VIEW�� ����
SELECT EMP_NAME, SALARY FROM employees;

-- �� ���� ���� �ʿ� ==> ������ ����  
GRANT CREATE VIEW TO C##TESTUSER; 

CREATE OR REPLACE VIEW EMP_VIEW 
AS SELECT EMP_NAME, SALARY FROM employees
WITH READ ONLY;
-- OR REPLACE : ���� �̸��� �䰡 ���� ��� �����(����)
-- WITH READ ONLY �б� ���� 
SELECT * FROM EMP_VIEW;
-- �� EMP_VIEW�� ����
DROP VIEW  EMP_VIEW;

-- EMPLOYEES ���̺��� ����
DROP TABLE EMPLOYEES;

