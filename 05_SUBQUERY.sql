/*
   
     * ��������(SUBQUERY)
     : �ϳ��� ������ ���� ���Ե� �� �ٸ� ������ 
        ���� ������ �ϴ� �������� ���� ���� ������ �ϴ� ������
*/
-- "���ö" ����� ���� �μ��� ���� ��� ������ ��ȸ 

-- 1) ���ö ����� �μ��ڵ� ��ȸ --> 'D(' 

SELECT dept_code, SALARY
FROM EMPLOYEE 
WHERE EMP_NAME = '���ö';

-- 2) �μ��ڵ尡 'D9'�� ��� ��ȸ 
SELECT *
FROM employee
WHERE DEPT_CODE = 'D9';

-- ���� 2���� �������� �ϳ��� ���ĺ��ٸ� ?

SELECT *
FROM employee
WHERE DEPT_CODE = (SELECT DEPT_CODE 
                    FROM employee
                    WHERE EMP_NAME = '���ö' );
                    
-- ��ü ����� ��� �޿����� �� ���� �޿��� �޴� ����� ������ ��ȸ 

-- 1) ��ü ����� ��� �޿� ��ȸ (�ݿø� ó��)
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 2) ��� �޿�(3047663)���� �� ���� �޿��� �޴� ��� ���� ��ȸ 
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3047663;

-- ���������� �����غ���... 
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= (SELECT ROUND(AVG(SALARY))
                    FROM employee);

-- ----------------------------------------------------------------------------

/*
    * ���������� ���� *
    ���������� ������ ������� ���� ��� �����Ŀ� ���� �з� 
    
    - ������ �������� : ���������� ���� ����� ������ 1���� �� (1�� 1��)
    - ������ �������� : ���������� ���� ����� �������� �� (N�� 1��)
    - ���߿� �������� : ���������� ���� ����� �� ���̰� �������� �÷��� �� (1�� N��)
    - ������ ���߿� ���� ���� : ���������� ���� ����� ������ ���� �÷��� �� (N�� N��)
    
    >> ������ ���� �������� �տ� �ٴ� �����ڰ� �޶����� 
*/
SELECT SALARY FROM employee;

-- ������ �������� : �������� ����� ������ 1���� ��! 
/*
    �Ϲ����� �񱳿����� ��밡�� : =, !=, <>,    
*/
-- �� ������ ��� �޿����� �� ���� �޿��� �޴� ������� �����, �����ڵ�, �޿���ȸ 

SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY < (SELECT ROUND(AVG(SALARY))
                    FROM employee);

-- �����޿��� �޴� ����� ����� �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                    FROM employee);
                    
--------------------------------------------------------------------------------

-- ���ö ����� �޿����� ���� �޴� ����� �����, �μ��ڵ� �޿� ��ȸ
-- * ���ö ����� �޿�
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                    FROM employee
                   WHERE EMP_NAME = '���ö');
                   

-- ���� ������� �μ��ڵ带 �μ������� �����Ͽ� ��ȸ 
-- * ORACLE ���� *

SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, department
WHERE DEPT_CODE = DEPT_ID 
AND SALARY > (SELECT SALARY
                    FROM employee
                   WHERE EMP_NAME = '���ö');
                   
-- * ANSI ���� * 
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
WHERE SALARY > (SELECT SALARY
                    FROM employee
                   WHERE EMP_NAME = '���ö');
                   
-- �μ��� �޿����� ���� ū �μ��� �μ��ڵ�, �޿����� ��ȸ 

-- 1) �μ��� �޿��� �� ���� ū �ϳ��� ��ȸ 
SELECT MAX(SUM(SALARY))
FROM employee
GROUP BY DEPT_CODE;

-- 2) �μ��� �޿����� 17700000�� �μ��� �μ��ڵ�, �޿��� ��ȸ 
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE 
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;


SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE 
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM employee
                        GROUP BY DEPT_CODE);

-- ������ ����� ���� �μ��� ������� ���, ����� ����ó �Ի��� �μ��� ��ȸ 
--(�� ������ ����� �����ϰ� ��ȸ)

-- *����Ŭ ����*

SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, department
WHERE DEPT_CODE = DEPT_ID 
AND DEPT_CODE = (SELECT DEPT_CODE 
                    FROM employee
                    WHERE EMP_NAME = '������')
AND EMP_NAME <> '������';                    

-- *ANSI ����*

SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN department ON DEPT_CODE = DEPT_ID 
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM employee WHERE EMP_NAME = '������');


/*
    ������ �������� : �������� ���� ����� �������� ��� 
    IN(��������) : ���� ���� ����� �߿��� �ϳ��� ��ġ�ϴ� ���� �ִٸ� ��ȸ 
    > ANY(��������) : ���� ���� ����� �߿��� �ϳ��� ū ��찡 �ִٸ� ��ȸ
    
    < ANY(��������) : ���� ���� ����� �߿��� �ϳ��� ���� ��찡 �ִٸ� ��ȸ 
    
    > ALL(��������) : ���� ���� ��� ��������� Ŭ ��� ��ȸ 
    < ALL (��������) : ���� ���� ��� ��������� ���� ��� ��ȸ 
        + �� ��� > ����� 1 ANd �񱳴�� > �����2 AND �񱳴�� > �����3
*/
-- ����� ��� �Ǵ� ������ ����� ���� ������ ������� ���� ��ȸ(���/�����/�����ڵ�/�ڵ�)
-- * ����� ��� �Ǵ� ������ ����� �����ڵ� ��ȸ 

SELECT JOB_CODE 
FROM employee
WHERE EMP_NAME IN('�����','������');


-- * �����ڵ尡 'J3' �Ǵ� 'J7'�� ������� ������ ��ȸ 
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM employee
WHERE JOB_CODE IN('J3','J7');

-- ���������� �����غ��� 

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM employee
WHERE JOB_CODE IN( SELECT JOB_CODE 
                    FROM employee
                    WHERE EMP_NAME IN('�����','������'));
                    
-- �븮 ������ ����� �� ���� ������ ����� �ּ� �޿����� ���� �޴� ��� ���� ��ȸ
--(���, �̸�, ���޸�, �޿�)
-- * ���� ������ �޿� 

-- * ANY �����ڸ� ����Ͽ� �� 

-- * ���� ������ �޿� -- 3760000, 2200000, 2500000
SELECT SALARY
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';

-- *> ANY �����ڸ� ����Ͽ� �� 

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND  SALARY > ANY(3760000,2200000,2500000)
AND JOB_NAME = '�븮';


SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND  SALARY > ANY(SELECT SALARY FROM employee JOIN JOB USING(JOB_CODE)
            WHERE JOB_NAME = '����'
)
AND JOB_NAME = '�븮';

--------------------------------------------------------------------------------
/*


    * ���߿� �������� : �������� ���� ����� ���� �ϳ��̰�, �÷�(��) ���� ���� ���� ��� 


*/

-- ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ��� ������ ��ȸ 
-- 1) ������ ����� �μ��ڵ�, �����ڵ� ��ȸ 

SELECT DEPT_CODE, JOB_CODE 
FROM employee
WHERE EMP_NAME = '������';

-- *

SELECT DEPT_CODE
FROM employee
WHERE EMP_NAME = '������';

SELECT JOB_CODE 
FROM employee
WHERE EMP_NAME = '������';
-- �������� ���

SELECT EMP_NAME 
FROM EMPLOYEE 
WHERE DEPT_CODE = (SELECT DEPT_CODE 
                FROM EMPLOYEE
                WHERE EMP_NAME = '������')
            AND JOB_CODE = (SELECT JOB_CODE
                            FROM EMPLOYEE
                            WHERE EMP_NAME = '������');

-- ������ ���������� ����� ��� 

SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM employee
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                    FROM EMPLOYEE
                                    WHERE EMP_NAME = '������');
                                    
                                    
-- �ڳ��� ����� ���� �����ڵ�, ���� ����� �������ִ� ��� ���� ��ȸ 
-- (�����, �����ڵ�, �����ȣ)

SELECT EMP_NAME, JOB_CODE, MANAGER_ID
FROM employee
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                    FROM EMPLOYEE
                                    WHERE EMP_NAME = '�ڳ���');

-- 1) �ڳ��� ����� �����ڵ�, �����ȣ�� ��ȸ 
SELECT JOB_CODE, MANAGER_ID
FROM employee
WHERE EMP_NAME = '�ڳ���';


-- 2) ���� ���� �ڵ� ���� ����� ������ �ִ� ��� ������ ��ȸ 
SELECT EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE 
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID 
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '�ڳ���'   )
                             
                                AND EMP_NAME != '�ڳ���';
                                
--------------------------------------------------------------------------------


/*
  * ������ ���߿� �������� : ���������� ����� ������, �������� ���� ��� 
*/
-- �� ���޺� �ּұ޿��� �޴� ��� ������ ��ȸ 

-- 1) �� ���޺� �ּұ޿� 
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE 
GROUP BY JOB_CODE;


/*
J1	8000000
J2	3700000
J4	1550000
J3	3400000
J7	1380000
J5	2200000
J6	2000000
*/

-- 2) �� ���޺� �ּұ޿��� �޴� ��� ��ȸ 
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM employee
WHERE JOB_CODE = 'J1' AND SALARY = 8000000
    OR JOB_CODE = 'J1' AND SALARY = 3700000
    OR JOB_CODE = 'J3' AND SALARY = 3400000;
    
    
    
-- �������� ���� 
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM employee
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                                FROM employee
                                GROUP BY JOB_CODE);




-- �� �μ����� �ְ�޿��� �޴� ��� ���� ��ȸ 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                                FROM employee
                                GROUP BY DEPT_CODE);

--------------------------------------------------------------------------------


/*
    �ζ��� �� : ���������� FROM���� ����ϴ� ��
        
        = > ���������� ���� ����� ��ġ ���̺�ó�� ����ϴ� ��             
*/
-- ������� ���, �̸�, ���ʽ� ���� ����, �μ��ڵ带 ��ȸ
-- * ���ʽ� ���� ������ NULL�� �ƴϾ�� �ϰ�, ���ʽ� ���� ������ 3000���� �̻��� ����鸸 ��ȸ 
SELECT EMP_ID, EMP_NAME, (SALARY + (SALARY * NVL(BONUS, '0'))) * 12, DEPT_CODE  
FROM employee
WHERE (SALARY + (SALARY * NVL(BONUS,0))) * 12 >= 30000000
ORDER BY 3 DESC;

/*
�ζ��� FROM ���� 
*/

SELECT ROWNUM, ���, �̸�, "���ʽ� ���� ����", �μ��ڵ�  
FROM (SELECT EMP_ID ���, EMP_NAME �̸�, (SALARY + (SALARY * NVL(BONUS, '0'))) * 12 "���ʽ� ���� ����", DEPT_CODE �μ��ڵ�
FROM employee
WHERE (SALARY + (SALARY * NVL(BONUS,0))) * 12 >= 30000000
ORDER BY 3 DESC
)
WHERE ROWNUM <= 5;


-- ���� �ֱٿ� �Ի��� ��� 5���� ��ȸ 
-- �Ի��� ���� �������� ���� (���, �̸�, �Ի���)

SELECT ROWNUM, ���,  �̸�, �Ի��� 
FROM (SELECT EMP_ID ���, EMP_NAME �̸�, HIRE_DATE �Ի��� 
    FROM employee
    ORDER BY HIRE_DATE DESC
)
WHERE ROWNUM <= 5;

/*

    -RANK() OVER(���ı���) : ������ ���� ������ ����� ������ �� ��ŭ �ǳʶٰ� ���� ���
    -DENSE_RANK() OVER(���ı���) : ������ ������ �ִ��� �� ���� ����� +1�ؼ� ���� ��� 
    
    * SELECT�������� ��� ����! 
*/
-- �޿��� ���� ������� ������ �Űܼ� ��ȸ 
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "����"
FROM employee;
--> ���� 19���� 2���� �ְ�, �� ���� ������ 21�� ǥ�õ�.

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
FROM employee
where rownum  <= 5;


SELECT *
FROM (
select EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
from EMPLOYEE
)
where rownum  <= 5;
--> ���� 19���� 2�� ���Ŀ� �� ���� ������ 20���� ǥ�õ�(+1)
--> ���� 5�� 

-- ���� 3�� ~ 5�� ��ȸ 

select *
from (select EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
from EMPLOYEE
)
where ���� >= 3 and ���� <= 5;
--------------------------------------------------------------------------------

-- 1) ROWNUM�� Ȱ���Ͽ� �޿��� ���� ���� 5���� ��ȸ�Ϸ� ������, ����� ��ȸ�� ���� �ʾҴ�
SELECT ROWNUM, EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC)
FROM employee
WHERE  ROWNUM <= 5
ORDER BY SALARY DESC;

-- ������(����) : ������ �Ǳ� ���� 5���� �߷�����. 
-- �ذ��� : 
--ROW -> ROWNUM  

SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY 
        FROM employee
        ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;


-- 2) �μ��� ��� �޿��� 270������ �ʰ��ϴ� �μ��� �ش��ϴ� �μ��ڵ� �μ��� �� �޿��� 
-- �μ��� ��ձ޿�, �μ��� ��� �� �� ��ȸ 
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY 
        FROM employee
        ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;


-- ������(����) : �μ��� ��� �޿��� Ȯ���ؾ��ϴµ�, ��� �������� �޿��� Ȯ���ߴ�. 
-- �ذ��� : HAVING�� SALARY 

SELECT DEPT_CODE, SUM(SALARY) "����",FLOOR(AVG(SALARY)) AS "���", COUNT(*) "�ο���"
FROM EMPLOYEE 
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 2700000
ORDER BY DEPT_CODE ASC;

--SELECT
--FROM (SELECT DEPT_CODE, SUM(SALARY), "����", FLOOR(AVG(SALARY)) AS "���", COUNT(*) "�ο���"
--        FROM EMPLOYEE
--        GROUP BY DEPT_CODE
--)

































                    






