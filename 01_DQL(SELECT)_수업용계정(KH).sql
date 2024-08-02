/*
 ������ ��ȸ(����) : SELECT 
 
   - SELECT ��ȸ�ϰ��� �ϴ� ���� FROM ���̺��; 
   - SELECT * �Ǵ� �÷���1, �÷���2, ... FROM ���̺��; 
  */
-- ��� ����� ������ ��ȸ 
SELECT * FROM EMPLOYEE;


-- ��� ����� �̸�, �ֹε�Ϲ�ȣ, �ڵ��� ��ȣ�� ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE; 

-- JOB ���̺��� �����̸��� ��ȸ 

SELECT JOB_NAME -- �÷� 
FROM JOB; 
-- SELECT FROM JOB_NAME;

-- DEPARTMENT ���̺��� ��� ������ ��ȸ 
SELECT * FROM DEPARTMENT; -- ��ҹ��� "" �ȿ��� ���� 

-- ���� ���̺��� �����, �̸���, ����ó, �Ի���, �޿� ��ȸ
 

SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*

    �÷����� ��� �����ϱ� 
    => SELECT���� �÷��� �ۼ��κп� ��������� �� �� �ִ�. 

*/

-- ��� �̸�, ���� ������ȸ

SELECT EMP_NAME, SALARY �޿�, (SALARY * 12) ���� -- SALARY �÷� �����Ϳ� 12�� ���Ͽ� ��ȸ 
FROM  employee;

-- ��� �̸�, �޿�, ���ʽ�, ���ʽ� ���� ����(�޿�*���ʽ�)*12 
SELECT EMP_NAME, SALARY,  BONUS "���ʽ� ��", SALARY * 12, (SALARY +(SALARY * BONUS))*12
FROM  employee;

// ��¥Ÿ��

/*
        - ���� ��¥�ð� ���� : SYSDATE
        - ���� ���̺�(�ӽ����̺�) : DUAL

*/

-- ���� �ð� ���� ��ȸ 

SELECT SYSDATE  FROM DUAL; // YY/MM/DD �������� ��ȸ��!


-- ����̸�, �Ի���, �ٹ��ϼ� ��ȸ 
--DATEŸ�� - DATEŸ�� => �Ϸ� ǥ�õ�!

SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE "�ٹ� �ϼ�"
FROM employee;

/*

    *�÷��� ��Ī ���� : ������� ����� ��� �ǹ��ľ��� ��Ʊ� ������, 
    ��Ī�� �ο��ϰ� ��Ȯ�ϰ� ����ϰ� ǥ���� �� �ִ�  
    
    [ǥ����] 
            1) �÷��� ��Ī 
            2) �÷��� AS ��Ī 
            3) �÷��� "��Ī"
            3) �÷��� AS "��Ī"
*/

-- ��� �̸�, �޿�, ���ʽ�, ���ʽ� ���� ����(�޿�*���ʽ�)*12 
SELECT EMP_NAME ����̸�, SALARY as �޿�,  BONUS ���ʽ�, SALARY * 12 ����, (SALARY +(SALARY * BONUS))*12 "���ʽ� ���� ����"
FROM  employee;

/*
    �� ��ü = ���ͷ� 
    
    ���ͷ� : ���Ƿ� ������ ���ڿ� : ('') �۵� 
    -> SELECT ���� ����ϴ� ��� ��ȸ�� ��� (Result set)�� �ݺ������� ǥ�� 
    
    -- �̸�, �޿�, '��' ��ȸ 

*/


SELECT EMP_NAME �̸�, SALARY �޿�, '��' ���� -- ��ȸ�ϴ� ����
FROM employee;

/*
  ���� ������ : || 
  
*/

SELECT SALARY || '��'  �޿�  
FROM employee;

-- ���, �̸�, �޿����� �ѹ��� ��ȸ 
SELECT EMP_ID || EMP_NAME || SALARY    
FROM employee;


-- xxx�� �޿��� xxxx���Դϴ� �������� ��� 
SELECT EMP_NAME || '�� �޿���' || SALARY || '���Դϴ�' �޿�����
FROM employee;

-- ��� ���̺��� ���� �ڵ� 

SELECT JOB_CODE || '�Դϴ�' �����ڵ�
FROM employee;

/*
 �ߺ� ���� : DISTINCT
*/

SELECT DISTINCT JOB_CODE || '�Դϴ�' �����ڵ�
FROM employee;

-- DEPT_CODE

SELECT DISTINCT DEPT_CODE || ' �μ� �ڵ� �Դϴ�' �����ڵ�
FROM employee;
-- DISTINCT�� �ѹ��� ��� ���� 
-- DISTINCT(JOB, DEPT_CODE) �� ������ ��� �ߺ��� ����
-- �ΰ��� ��ġ�� �� ���� 

-- (JOB_CODE, DEPT_CODE)�� �� ������ ��� �ߓ��� ��������
SELECT DISTINCT JOB_CODE, dept_code
FROM employee;

-- =======================================================================

/*
    WHERE �� : ��ȸ�ϰ��� �ϴ� �����͸� Ư�� ���ǿ� ���� �����͸� �����ϰ��� �� �� 
    
    SELECT [�÷���, �÷�]������ ���� ����� 
    FROM ���̺��
    WHERE ����;

    * ��Һ� : >, <, >=, <=
    * ����� 
      - ���� �� : =
      - �ٸ��� : !=, <> ���׸� ^=
*/

-- ������̺��� �μ��ڵ尡 'D9'�� ����鸸 ��ȸ

SELECT * FROM employee   -- ��ü �÷��� ��ȸ�� �ǵ� 
WHERE dept_code = 'D9';   -- EMPLOYEE
-- DEPT_CODE�� ���� 'D9'�� ������ ��ȸ 

-- ������̺��� �μ��ڵ尡 D1�� ������� �����, �޿�, �μ��ڵ� ��ȸ 

SELECT EMP_NAME , SALARY �޿�, DEPT_CODE �μ��ڵ�
FROM employee
WHERE dept_code = 'D1';

-- �μ��ڵ尡 D1�� �ƴ� ������� ���� ��ȸ(�����, �޿�, �μ��ڵ�)


SELECT EMP_NAME, SALARY, DEPT_CODE
FROM employee
WHERE dept_code <> 'D1';


-- �޿��� 400���� �̻��� ����� ����� �μ��ڵ�, �޿� ������ ��ȸ
SELECT EMP_NAME ��ٿ�, DEPT_CODE, SALARY * 12 || '��' as  �޿�
FROM employee
WHERE SALARY  > '400000';



-- 1 �޿��� 300���� �̻��� ������� �����, �޿�, �Ի���, ���� ��ȸ()��Ī����
SELECT EMP_NAME ��ٿ�,SALARY �޿�, HIRE_DATE �Ի���, (SALARY * 12) ���� 
FROM employee
WHERE SALARY  >= '3000000';

-- === 2 ������ 5õ���� �̻��� ������� �����, �޿�, ����, �μ��ڵ���ȸ == 
SELECT EMP_NAME ��ٿ�,SALARY �޿�, SALARY * 12 ����, dept_code
FROM employee
WHERE SALARY * 12  >= '50000000';

-- 3. �����ڵ� 'J3'�� �ƴ� ������� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ
SELECT  EMP_NO,EMP_NAME ��ٿ�, JOB_CODE "���� ��ȣ", ENT_DATE
FROM employee
WHERE JOB_CODE  <> 'J3'; -- ��ҹ��� �����Ѵ� 

-- 4 �޿��� 350 �̻� 600 ���� ������ ��� ����� �����, ���, �޿���ȸ 
SELECT  EMP_NO,EMP_NAME ��ٿ�, SALARY 
FROM employee
WHERE SALARY  >= '3000000' AND SALARY <= 6500000;

-- ============================================================================
/*
 * BETWEEN AND : ���ǽĿ��� ���Ǵ� ���� 
   => 0�̻� ~������ ������ ���� ������ �����ϴ� ���� 
        
    [ǥ����]
            �񱳴���÷��� : BETWEEN �ּҰ� AND �ִ�
            = > �ش� �÷��� ���� �ּҰ� �̻��̰� �ִ밪 ������ ��� 
*/

-- �޿��� 350���� �̻��̰� 600���� ������ ����� �����, ���, �޿� ��ȸ
SELECT EMP_NAME, EMP_ID,  SALARY
FROM employee
WHERE SALARY >= 3500000 AND SALARY <= 60000000;

-- BETWEEN�� ����� �� 
SELECT EMP_NAME, EMP_ID,  SALARY
FROM employee
WHERE SALARY BETWEEN 3500000 AND 6000000;

/*
        * ! ����Ŭ������ ������������ 
        * NOT
*/

-- NOT �޿��� 350���� �̸� �Ǵ� 600���� �ʰ��� ����� �����, ���, �޿� ��ȸ(NOT X)

SELECT EMP_NAME, EMP_ID,  SALARY
FROM employee
WHERE SALARY < 3500000 OR SALARY > 6000000; 


-- NOT �޿��� 350���� �̸� �Ǵ� 600���� �ʰ��� ����� �����, ���, �޿� ��ȸ(NOT O)

SELECT EMP_NAME, EMP_ID,  SALARY
FROM employee
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

-- NOT�� BETWEEN �տ� ���̰ų� �÷��� �տ� �ٿ��� ��� ����!


/*
    IN : �񱳴���÷����� ������ ���� �߿� ��ġ�ϴ� ���� �ִ� ��� ��ȸ�ϴ� ������ 
    
    [ǥ����]
            �񱳴���÷��� IN ('��1','��2','��3', .....)            
*/
-- �μ��ڵ尡 D6�̰ų� D8�̰ų� 
-- �����, �μ��ڵ�, �޿��� ��ȸ (IN : X)

SELECT EMP_NAME, dept_code,  SALARY
FROM employee
WHERE dept_code = 'D6' OR  dept_code = 'D8' OR dept_code = 'D5';


SELECT EMP_NAME, dept_code,  SALARY
FROM employee
WHERE dept_code IN  ('D6','D8','D5');


SELECT EMP_NAME, DEPT_CODE, hire_date
FROM employee
WHERE DEPT_CODE IN ('D9','D5') AND hire_date  < '02/01/01';

-- ==============================================================
/*
    * LIKE : ���ϰ����ϴ� �÷��� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ 
    = > Ư�� ���� : '%', '_'�� ���ϵ�ī��� ��� 
        '%' : 0���� �̻� 
    * ex) �񱳴���÷��� LIKE '����%' => �񱳴���÷��� ���� ���ڷ� ���۵Ǵ� ���� ��ȸ 
          �񱳴���÷��� LIKE '%����' => �񱳴���÷��� ���� ���ڷ� ������ ���� ��ȸ 
          
          ���ڴ�
          ����
          ���ڿ���
          �̰��� ���ڴ�
          
          => �񱳴���÷��� ���� ���ڰ� "����"�Ǵ� ���� ��ȸ %����% (Ű���� �˻�)
          ���ڰ� ���Ե� ���ΰ� 
          
          
          '_' : 1���� 
        ex) �񱳴���÷��� LIKE '_����' => �񱳴���÷��� ������ ���� �տ� ������ �ѱ��ڰ� �� ��� ��ȸ
            �񱳴���÷��� LIKE '__����' => �񱳴���÷��� ������ ���� �տ� ������ �α��ڰ� �ð�� 
            �񱳴���÷��� LIKE '_����_' => �񱳴���÷��� ������ ���� �� �ڿ� ������ �ѱ��ھ� ���� ��� ��ȸ        
*/

-- ����� �߿� ������ ����� ����� �޿�, �Ի��� 
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM employee
WHERE EMP_NAME LIKE '��%'; -- ���۵Ǵ� �� ��ȸ 
-- ��� �̸��� �ϰ� ���Ե� 


SELECT EMP_NAME, EMP_NO, PHONE
FROM employee
WHERE EMP_NAME LIKE '%��%'; -- Ű���� �˻� 
-- ��� �̸��� ��� ���ڰ� ���� ��� �����, ����ó ��ȸ


SELECT EMP_NAME, PHONE
FROM employee
WHERE EMP_NAME LIKE '_��_'; --

-- ����� �� ����ó�� 3��° �ڸ��� 1�� ����� ��� ����� ����ó �̸��� 

SELECT EMP_ID, EMP_NAME, PHONE, email
FROM employee
WHERE PHONE LIKE '__1%'; -- ���۵Ǵ� �� ��ȸ 



-- ����� �� �̸��Ͽ� 4��° _�� ������ �ش� ���� ���� 3������ ����� ���, �̸�,�̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, email
FROM employee
WHERE email LIKE '___';  

--  ESCAPE
--> ���ϵ�ī��� ���Ǵ� ���ڿ� �÷��� ��� ���ڰ� �����ϱ� ������ ��� ���ϵ�ī��� �νĵ�
--> ����, ������ ����� ��! (=> ESCAPE�� ����Ͽ� ��� �� ����)

SELECT EMP_ID, EMP_NAME, email
FROM employee
WHERE email LIKE '___!_%' ESCAPE '!';
-- =======================================================

/*
    IS null / IS not Null : �÷����� NULL�� ���� ��� NULL���� ���� �� ����ϴ� ������ 
*/
-- ���ʽ��� ���� �ʴ� �������(BONUS�� ���� NULL) ���, �̸�,�޿�,���ʽ� ��ȸ 
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM employee
WHERE bonus IS NULL;

-- ���ʽ��� �޴� ������� ���, �̸�, �޿�, ���ʽ� ��ȸ 

SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM employee
-- WHERE bonus IS not NULL
WHERE  bonus IS NOT NULL;


-- ����� ���� ��� (MANAGER_ID�� ����) NULL!���� �����, ������, �μ��ڵ� ��ȸ
SELECT  EMP_NAME, MANAGER_ID, DEPT_CODE
FROM employee
-- WHERE bonus IS not NULL
WHERE MANAGER_ID IS NULL;

-- �μ� ��ġ�� ���� �ʾ�����, ���ʽ��� �ް� �ִ� ����� �����, ���ʽ�, �μ��ڵ� ��ȸ
SELECT  EMP_NAME, bonus, DEPT_CODE
FROM employee
-- WHERE bonus IS not NULL
WHERE dept_code IS NULL AND BONUS IS NOT NULL; 
-- =============================================================================

/*
   * ������ �켱 ���� 
   - 0 : ()
   - 1 : ������� : +,-,*,/
   - 2 : ���Ῥ���� : ||
   - 3 : �񱳿����� : > < >= <= = != ^= <>
   - 4 : IS NULL, IS NOT NULL '����' / IN
   - 5 : BETWEEN AND
   - 6 : NOT 
   - 7 : AND
   - 8 : OR
*/

-- �����ڵ尡 J7�̰ų� T2�� ����� �� �޿��� 200���� �̻��� ����� ��� ������ ��ȸ 
SELECT * FROM employee
-- WHERE bonus IS not NULL
WHERE job_code IN('J7', 'J2') AND SALARY >= '2000000'; 

-- ==========================================================================
/*
    * ORDER BY : SELECT���� ���� ������ �ٿ� �ۼ�, ���� ���� ���� �������� ���� 
    
    [ǥ����]
            SELECT ��ȸ�� �÷�...
            FROM ���̺�� 
            WHERE ���ǽ� 
            ORDER BY ���ı������� ���� �÷� |��Ī| �÷� ���� [ASC | DESC] ���� ���� 
            NULLS FIRST| NULLS LAST 
            
    * ASC : �������� ����(�⺻��)
    *DESC : �������� ����
    
    *  NULLS FIRST : �����ϰ����ϴ� �÷��� ���� NULL�� ��� �ش� �����͸� �� �տ� ��ġ
        [DESC�� ��� �⺻��]
    *  NULLS LAST  : �����ϰ����ϴ� �÷��� ���� NULL�� ��� �ش� �����͸� �� �ڿ� ��ġ 
        [ASC�� ��� �⺻��]
        
        
        = > NULL ���� ū ������ �з��Ǿ� ���ĵȴ�. 
    
*/

-- ��� ����� �����, ���� ��ȸ (������ �������� ����)





SELECT EMP_NAME, SALARY *12 ����  
FROM employee   
ORDER BY 2 DESC; -- �÷� ���� ��� (����Ŭ������ 1���� ����!)

-- ���ʽ� �������� �����غ��� 

SELECT *  
FROM employee   
ORDER BY bonus; -- �⺻�� (ASC, NULLS LAST)

SELECT *  
FROM employee   
ORDER BY bonus ASC; -- �⺻�� (ASC, NULLS LAST)

SELECT *  
FROM employee   
ORDER BY bonus ASC NULLS LAST; -- �⺻�� (ASC, NULLS LAST)


SELECT *  
FROM employee   
ORDER BY bonus DESC; -- �⺻�� (ASC, NULLS FIST)


-- ���ʽ��� ��������, �޿��� ��������
SELECT *  
FROM employee   
ORDER BY bonus DESC, SALARY ASC; -- �⺻�� (ASC, NULLS FIST
-- ���ʽ� ���� �������� �����ϴµ� ���� ���� ��� �޿��� ���� �������� �����ϰڴ�

-----------------------------------------------------------------------------
















