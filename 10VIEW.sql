/*
    *VIEW (��)
    :SELECT���� ���� ����� ������� �����ص� �� �ִ� ��ü 
    = > ���� ����ϴ� �������� �����صθ� �Ź� �ٽ� �ش� �������� ����� �ʿ䰡 ���� 
    �ӽ����̺�� ���� ���� : ���� �����Ͱ� ����Ǵ� �� �ƴ϶�, �������θ� ����Ǿ� ����!
*/
-- ���(EMPPLOYEE), �μ�(DEPARTMENT), ����(LOCATION), ����(LOCATION)


-- �ѱ����� �ٹ��ϴ� ��� ���� ��ȸ (���, �̸�, �μ���, �޿�, �ٹ�������)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE )
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '�ѱ�';
-- AND�� �ʿ䰡 ����. 

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE, department, LOCATION L, NATIONAL N
WHERE (DEPT_CODE = DEPT_ID) AND LOCATION_ID = LOCAL_CODE AND (L.NATIONAL_CODE = N.NATIONAL_CODE) 
AND NATIONAL_NAME = '���þ�';

/*
    VIEW �����ϱ� 
    
    CREATE VIEW ���
    AS �������� 
*/

-- ������� ���̺� ��ü�� �̸��� �� ����!
--          ���̺� : TB_XXX, 
--          �� : VW_XXX

CREATE VIEW VW_EMPLOYEE 
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE )
JOIN NATIONAL USING (NATIONAL_CODE);


-- �並 ������ �� �ִ� ������ �ο� (������ �������� ����!)
-- GRANT CREATE VIEW TO C##KH;


SELECT * FROM vw_employee;
--> �����δ� �Ʒ��� ���� ����� ����
SELECT * FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE )
JOIN NATIONAL USING (NATIONAL_CODE));

SELECT * FROM vw_employee
WHERE NATIONAL_NAME = '�ѱ�';

-- ���þƿ��� �ٹ��ϴ� ��� ���� ��ȸ

SELECT * FROM vw_employee
WHERE NATIONAL_NAME = '���þ�';

-- (����) ���� �������� ������ �� ��� ��ȸ -->TEXT �÷��� ����� �������� ������ ����!
SELECT * FROM USER_VIEWS;

-- view�� �ɼ��� �ִ�.

-- ����Ⱑ �� OR REPLACE

CREATE OR REPLACE VIEW VW_EMPLOYEE 
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE )
JOIN NATIONAL USING (NATIONAL_CODE);

SELECT * FROM VW_EMPLOYEE;
--------------------------------------------------------------------------------

/*
    -- * ���, �����, ���޸�, ����(��|��), �ٹ���� ������ ��ȸ 
*/

SELECT EMP_ID ���, EMP_NAME �̸�, JOB_CODE ���޸�, DECODE(SUBSTR(EMP_NO, 8, 1), '1''��','2','��') ����
,EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) + 1 �ٹ����
FROM employee
JOIN JOB USING(JOB_CODE);
   
-- => �Լ��� �Ǵ� ������� �ִ� ��� ��Ī�� �ο��ؾ��� view�� �� ������ �� �ִ� 
-- ��� �÷����� ������� ��� ���� �����Ͽ� �ۼ� ����!

CREATE OR REPLACE VIEW VW_EMP_JOB (���, �̸�,���޸�,����,�ٹ����)
AS SELECT EMP_ID, EMP_NAME, JOB_CODE , DECODE(SUBSTR(EMP_NO, 8, 1), '1''��','2','��') ����
,EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) + 1 �ٹ����
FROM employee
JOIN JOB USING(JOB_CODE);

SELECT * FROM vw_emp_job WHERE ���� = '��';
SELECT * FROM vw_emp_job WHERE �ٹ���� >= 20;

DROP VIEW VW_EMP_JOB;








