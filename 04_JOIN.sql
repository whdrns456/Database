/*

 JOIN 
 : �ΰ� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����. 
    ��ȸ����� �ϳ��� �����(RESULT SET)�� ���� 
    
    * ������ �����ͺ��̽�(RDB)������ �ּ����� �����͸� ������ ���̺� ���� 
      �ߺ������� �ּ�ȭ�ϱ� ���� �ִ��� �ɰ��� �����Ѵ�. 
      
      = > ������ �����ͺ��̽����� �������� �̿��� ���̺��� "����"�� �δ� ��� 
      (�� ���̺��� �����(�ܷ�Ű))�� ���ؼ� �����͸� ��Ī���Ѽ� ��ȸ��! 
      
      
      JOIN�� ũ�� "����Ŭ ���� ����"�� "ANSI ����"(�̱�����ǥ����ȸ )

        ����Ŭ ���� �����̶� ?       |       ANSI ���� 
-------------------------------------------------------------------------------
             � ����              |         �������� 
            (EQUAL JOIN)           |  (INNER JOIN) --> JOIN USING/ON
--------------------------------------------------------------------------------
        ���� ����                   |         ���� �ܺ� ����(LEFT OUTER JOIN)
        (LEFT OUTER)               |        ������ �ܺ� ����(RIGHT OUTER JOIN)
        (RIGHT OUTER)              |        ��ü �ܺ� ���� (FULL OUTER JOIN)
--------------------------------------------------------------------------------
                                   |            
        ��ü ���� (SELF JOIN)       |               JOIN ON
    �� ����(NON EQUAL JOIN)     |
--------------------------------------------------------------------------------         

*/
-- ��ü ������� ���, �����, �μ��ڵ� ��ȸ 

SELECT EMP_ID, EMP_NAME, DEPT_CODE 
FROM employee;

-- �μ��ڵ�, �μ��� ��ȸ(�μ� ������ ����� ���̺� : DEPARTMENT)
SELECT DEPT_ID, dept_title FROM department;

-- ��ü ������� ���, �����, �����ڵ� ��ȸ 
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM employee;

-- �����ڵ�, ���޸� ��ȸ(���� ���� : JOB)
SELECT JOB_CODE, JOB_NAME FROM JOB;

/*
    �����(EQUAL JOIN) / ��������(INNER JOIN)
    = > ���� ��Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ��ȸ(=> ��ġ���� �ʴ� ���� ��ȸ���� ����)
*/

-- ����Ŭ ���� ���� -- 
/*
        * FROM���� ��ȸ�ϰ����ϴ� ���̺��� ����(,�� ����)
        * WHERE���� ��Ī��ų �÷��� ���� ������ �ۼ� 
*/
-- ����� ���, �̸�, �μ����� ��ȸ(�μ��ڵ� �÷� => EMPLOYEE : DEPT_CODE, DEPARTMENT : DEPT_ID)
SELECT EMP_ID, EMP_NAME, dept_title
FROM employee, department 
WHERE DEPT_CODE = DEPT_ID;
-->NULL(EMPLOYEE. DEPT_CODE), �����ú�(D3), �ؿܿ��� 3��(D7), ����������(D4) --> DEPARTMENT �����ʹ� ���ܵ�
--> �� ���̺��� �����ϴ� ���� 

-- ������� ��� �̸� ���޸��� ��ȸ (�����ڵ� �÷� => EMPLOYEE : JOB_CODE, JOB : JOB_CODE)
-- �� ���̺��� �÷����� ������ ��� ��Ī�� ���������ν� ������ �� �ִ�! 
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM employee E, JOB J
WHERE E.JOB_CODE  = J.JOB_CODE;

-- ANSI ���� -- 

/*
    FROM���� ������ �Ǵ� ���̺��� �ϳ� �ۼ� : 
    JOIN���� �����ϰ����ϴ� ���̺��� ���  + ��Ī��Ű���� �ϴ� ������ �ۼ� 
    
    - JOIN USING : �÷����� ���� ��� 
    - JOIN ON : �÷����� ���ų� �ٸ� ��� 

*/
-- ���, �����, �μ��� ��ȸ 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE 
FROM employee
JOIN department ON (DEPT_CODE = DEPT_ID);
--------------------------------------------------------------------------------

-- ���, �����, ���޸� ��ȸ (EMPLOYEE : JOB_CODE, JOB : JOB_CODE)
-- JOIN USING���� ��� 
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM employee
    JOIN JOB USING(JOB_CODE);

-- JOIN ON ���� ��� 
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM employee E
JOIN JOB J  ON (E.JOB_CODE =J.JOB_CODE);

-- �븮 ������ ����� ���, ����� ���޸�, �޿� ��ȭ 
-- ����Ŭ ���� 

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM employee E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND JOB_NAME = '�븮'; 
    
-- ** ANSI ���� ** --     
    
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE 
 JOIN JOB  USING(JOB_CODE)
WHERE JOB_NAME = '�븮';
--------------------------------------------------------------------------------

-- [1] �μ��� �λ�������� ������� ���, �����, ���ʽ� ��ȸ 

-- **����Ŭ ���� **
SELECT EMP_ID, EMP_NAME, NVL(BONUS, '0')
FROM employee ,department 
WHERE DEPT_CODE = DEPT_ID
    AND DEPT_TITLE = '�λ������';

-- **ANSI ����**

SELECT EMP_ID, EMP_NAME, NVL(BONUS, '0')
FROM employee 
JOIN department ON (DEPT_ID = DEPT_ID)
WHERE DEPT_TITLE = '�λ������';


-- USING�� ���� �÷����� ���� 

--[2]�μ� (DEPARTMENT)�� ����(LOCATION) ������ �����Ͽ� 
-- ��ü �μ��� �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ 

-- **����Ŭ ���� **
SELECT DEPT_ID,  dept_title �μ���, LOCAL_CODE �����ڵ�, LOCAL_NAME ������
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;

-- **ANSI ����**
-- ������ �Ǵ� �� FROM���� ��� 
SELECT DEPT_ID,  dept_title �μ���, LOCAL_CODE �����ڵ�, LOCAL_NAME ������
FROM DEPARTMENT
JOIN  LOCATION ON(LOCATION_ID = LOCAL_CODE);

--[3] ���ʽ��� �޴� ������� ��� �����, ���ʽ� �μ��� ��ȸ 

-- **����Ŭ ���� **
SELECT EMP_NAME, BONUS, dept_title
FROM employee, DEPARTMENT
WHERE BONUS IS NOT NULL
AND DEPT_CODE = DEPT_ID;

-- **ANSI ����**
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM employee
JOIN department on(DEPT_CODE = DEPT_ID)
AND BONUS IS NOT NULL;


--[4] �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿� ��ȸ 
-- **����Ŭ ���� **
SELECT EMP_ID, EMP_NAME, DEPT_ID,DEPT_TITLE
FROM employee, department 
WHERE  DEPT_ID = DEPT_CODE 
AND NOT DEPT_TITLE = '�ѹ���';

-- **ANSI ����**
SELECT EMP_ID, EMP_NAME, DEPT_ID,DEPT_TITLE
FROM employee
JOIN department ON(DEPT_ID = DEPT_CODE )
AND NOT DEPT_TITLE = '�ѹ���';


--------------------------------------------------------------------------------

/*
    �������� / �ܺ����� (OUTER JOIN) " 
    
    �� ���̺��� ��JOIN�� ��ġ���� �ʴ� �൵ �����Ͽ� ��ȸ�ϴ� ���� 
    ��, �ݵ�� LEFT/RIGHT�� �����ؾ��Ѵ�.(������ �Ǵ� ���̺�)
*/

-- LEFT JOIN : �� ���̺� �� ���ʿ� �ۼ��� ���̺��� �������� JOIN 

-- **ORACLE ����**
-- ��� �����, �μ���, �޿�, ���� ������ ��ȸ 
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM employee, department
WHERE DEPT_CODE = DEPT_ID(+);
-- ������ �ƴ� �ٸ� ���̺��ٰ� (+)

--**ANSI ����** 
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM employee
    LEFT JOIN department ON DEPT_CODE = DEPT_ID; 
    

-- * RIGHT JOIN : �� ���̺� �� �����ʿ� �ۼ��� ���̺� �������� JOIN
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM employee, department
WHERE DEPT_CODE(+) = DEPT_ID
ORDER BY EMP_NAME;
    
    
-- ** ANSI ����**  
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM employee
  RIGHT JOIN department ON DEPT_CODE = DEPT_ID; 


-- * FULL JOIN : �� ���̺��� ���� ��� ���� ��ȸ�ϴ� ���α��� (����Ŭ ���� ���� X)
-- ** ANSI ���� 
    SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
    FROM employee
    FULL JOIN department ON DEPT_CODE = DEPT_ID;
    -- ���� �ڱ���� ������ �ִ� �������� ������ �ȴ�. 
    
    

/*
    �� ����(NON EQUAL JOIN)
    
    : ��Ī ��ų �÷��� ���� ���� �ۼ� �� '='�� ������� �ʴ� ���� 
    
    *ANSI ���������� JOIN ON�� ��� ���� * 
*/
-- ����� ���� �޿� ������ ��ȸ (�����, �޿�, �޿����)
-- ���(EMPLOYEE), �޿����(SAL_GRADE)
-- * ����Ŭ ���� *

SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM employee, SAL_GRADE
-- WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- *ANSI ���� * 
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM employee
JOIN SAL_GRADE ON SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
-- �ش���� �ʴ� �÷��� ��ȸ�� �� �ִ�. 
--------------------------------------------------------------------------------

/*
    * ��ü ����(SELF JOIN)
    : ���� ���̺��� �ٽ� �� �� �����ϴ� ���� 
*/
-- ��ü ����� ���, �����, �μ��ڵ�, 
-- ������, ��� �����, ��� �μ��ڵ� ��ȸ 

--���(EMPLOYEE), ���(���) (EMPLOYEE) --> ���̺���� �����ϹǷ� ��Ī !
-- * ����Ŭ ���� 
SELECT E.EMP_ID ���, E.EMP_NAME �����, E.DEPT_CODE �μ��ڵ�,
        M.EMP_ID ������, M.EMP_NAME "��� �����", M.DEPT_CODE "��� �μ��ڵ�"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID; --����� �����ȣ,����� �������� �־� ��������� ��ȸ


SELECT E.EMP_ID ���, E.EMP_NAME �����, E.DEPT_CODE �μ��ڵ�,
        M.EMP_ID ������, M.EMP_NAME "��� �����", M.DEPT_CODE "��� �μ��ڵ�"
FROM EMPLOYEE E 
   LEFT JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;

-- LEFT JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;
-- ����� ���� ��� ������ ��ȸ�ϰ��� �� �� !

--------------------------------------------------------------------------------

/*
    * ���� ���� 
    : 2�� �̻��� ���̺��� �����ϴ� �� 
*/
-- ���, �����, �μ���, ���޸� ��ȸ 
-- ���(EMPLOYEE) / �μ�(DEPARTMENT) / ����(JOB)

-- *����Ŭ ����*

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID
    AND E.JOB_CODE = J.JOB_CODE;
    
--* ANSI ���� *   
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE 
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID) 
    JOIN JOB USING(JOB_CODE);
   
    
-- ���, �����, �μ���, ������ ��ȸ 
SELECT * FROM employee;      -- �μ��ڵ� : DEPT_CODE  
SELECT * FROM department;    -- �μ��ڵ� : DEPT_CODE, �����ڵ� : LOCATION_ID 
select * from location;      -- �����ڵ� : LOCAL_CODE


SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM employee, department, location
WHERE DEPT_CODE = DEPT_ID 
 AND LOCATION_ID = LOCAL_CODE;

-- **ANSI ����**
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID -- EMPLOYEE���̺�� ���� 
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE; -- DEPARTMENT ���̺�� LOCATION ����
    

-- 1) ���, �����, �μ���, ������, ������ ��ȸ 
-- ���(EMPLOYEE) / �μ�(DEPARTMENT)/ ����(LOCATION)/ ����(NATIONAL)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, locAl_NAME, NATIONAL_NAME
FROM employee, department, NATIONAL N, location L
WHERE DEPT_CODE = DEPT_ID -- employee ���̺�� department ���̺� ����
       AND LOCATION_ID = LOCAL_CODE
       AND L.NATIONAL_CODE = N.NATIONAL_CODE;


-- ** ANSI ���� ** 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, locAl_NAME, NATIONAL_NAME
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL USING (NATIONAL_CODE );
    
-- 2) ���, �����, �μ���, ������, ������ ��ȸ �޿����

-- *����Ŭ ����*
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, locAl_NAME, NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE E, DEPARTMENT, LOCATION L, NATIONAL N, JOB J, sal_grade
WHERE DEPT_CODE =  DEPT_ID 
 AND E.JOB_CODE = J.JOB_CODE
 AND SALARY BETWEEN MIN_SAL AND MAX_SAL
 AND LOCATION_ID = LOCAL_CODE 
 AND L.NATIONAL_CODE = N.NATIONAL_CODE;
 
 
 SELECT EMP_ID, EMP_NAME, DEPT_TITLE, locAl_NAME, NATIONAL_NAME, SAL_LEVEL
 FROM EMPLOYEE 
 JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
 JOIN JOB USING(JOB_CODE)
 JOIN 
 
 
 
