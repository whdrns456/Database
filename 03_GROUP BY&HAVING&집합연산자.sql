/*

    GROUP BY�� 
    : �׷� ������ ������ �� �ִ� ���� 
    : ���� ���� ������ �ϳ��� �׷����� ��� ó���ϴ� �������� ��� 

*/
-- ��ü ����� �޿� �� �� ��ȸ
SELECT TO_CHAR(SUM(SALARY), 'L9,999,999,999') 
FROM employee;

-- �μ��� �޿� �� �� ��ȸ 
SELECT DEPT_CODE, SUM(SALARY)
FROM employee 
GROUP BY DEPT_CODE;

-- �μ��� ��� �� ��ȸ 
SELECT DEPT_CODE, COUNT(*)       -- 3
FROM employee                    -- 1
GROUP BY DEPT_CODE;              -- 2

-- �μ��ڵ尡 D6, D9, D1�� �� �μ��� �޿� ����, ��� �� ��ȸ 

SELECT DEPT_CODE, SUM(SALARY), COUNT(*)   -- 4
FROM employee                             -- 1
WHERE DEPT_CODE IN('D6','D9','D1')        -- 2
GROUP BY DEPT_CODE                        -- 3 
ORDER BY DEPT_CODE;                       -- 5

-- �� ���޺� �� �����/���ʽ��� �޴� �����/ �޿���/��ձ޿�/�����޿�/ �ְ�޿� ��ȸ 
-- ��, ���� �������� 

SELECT JOB_CODE,COUNT(*) "�� �����", COUNT(BONUS) "���ʽ��� �޴� ��� ��", ROUND(AVG(SALARY)) "��ձ޿�", MIN(SALARY)"�����޿�", MAX(SALARY)"�ְ�޿�"
FROM employee
WHERE BONUS is not null
GROUP BY JOB_CODE
ORDER BY JOB_CODE;
-- COUNT�� �÷��� ���� ��� NULL�� �ƴ� ���� �����ϰ� ������ �����ش�. 

-- ���� ��� ��, ���� ��� �� ��ȸ 
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') "����", COUNT(*) "��� ��"
FROM employee
GROUP BY SUBSTR(EMP_NO, 8, 1);
-- DECODE : �����Լ� 

-- �μ� �� ���޺� �����, �޿� ����:
SELECT DEPT_CODE, JOB_CODE, COUNT(*) "�����", SUM(SALARY) "�޿�����"
FROM employee
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;
-- �μ��ڵ忡�� ���� ������ �� 
-- �μ��ڵ� �������� �׷�ȭ�ϰ�, �� ������ �����ڵ� �������� ���α׷�ȭ ��!


-- �׷����� ���� 

/*
        HAVING�� 
        : �׷쿡 ���� ������ ������ �� ���Ǵ� ���� (���� �׷��Լ����� ������ ������ �ۼ���!)
*/
-- �� �μ��� ��� �޿� ��ȸ(�μ�, ��� �޿�)
-- �� �μ��� ��� �޿��� 300���� �̻��� �μ��� ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM employee
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= '3000000' 
-- WHERE AVG(SALARY) >= '3000000' -- WHERE �������� �׷��Լ� ��� �Ұ�!
-- �׷��Լ��� �㰡���� �ʴ´ٶ�� ��. 
ORDER BY DEPT_CODE;

-- ���� �� �����ڵ�, �� �޿��� ��ȸ(�� ���޺� �޿� ���� 1000���� �̻��� ���޸� ��ȸ)

SELECT JOB_CODE, SUM(SALARY)
FROM employee
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= '10000000' 
ORDER BY JOB_CODE;

-- �μ��� ���ʽ��� �޴� ����� ���� �μ��� �μ��ڵ� ��ȸ 
-- WHERE BONUS IS NULL -- �μ� ������� ���ʽ��� NULL�� ������� ���� �ɷ�����. -> �ش� �μ��� 
-- ���ʽ��� �ִ� ����� ����  �� ���� 
SELECT DEPT_CODE �μ��ڵ�
FROM employee
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;
-- �׷�ȭ�� �Ŀ� COUNT�Լ��� ����Ͽ� BONUS �޴� ����� ���� ������ �������ؾ��Ѵ� 


/*
        * ���� ���� 
        SELECT * | ��ȸ�ϰ��� �ϴ� �÷� AS "��Ī" | �Լ��� | ����� 
        FROM ��ȸ�ϰ��� �ϴ� ���̺� | DUAL 
        WHERE ���ǽ�(�����ڵ��� Ȱ���Ͽ� �ۼ�)
        GROUP BY �׷�ȭ�� ������ �Ǵ� �÷� | �Լ��� 
        HAVING ���ǽ� (�׷��Լ��� Ȱ���Ͽ� �ۼ�)
        
        ORDER BY �÷� | ��Ī ��밡�� �÷� ���� �����ϴ� [ASC | DESC]
        * NULLS FIRST(DESC), NULLS LAST(ASC)
        
        SELECT 5������ ������ �ȴ� 
        FROM���� ù ��°�� ������ �ȴ�. 
        WHERE �� ������ ������ �ȴ� 
        GROUP BY  ����°�� ���� 
        HAVING ���ǽ� �׹����� ���� 
        ORDER BY ���������� ���� 
        
        -- > ����Ŭ�� ����(��ġ) 1���� ����
        
*/
-- ===============================================================

/*
     * ���� ������ 
     
     : ���� ���� �������� �ϳ��� ���������� ������ִ� ������
     
     - UNION : ������ OR(�� �������� ������ ������� ������)
     - INTERSECT : ������ AND (�� �������� ������ ������� �ߺ��� �κ��� �������ش�.)
     - UNION ALL : ������ + ������(�ߺ��Ǵ� �κ��� �ι� ǥ�õ� �� �ִ�)
     - MINUS : ������(���� ������� ���� ������� �A ������)   
*/



-- **UNION**
-- �μ��ڵ尡 D5�� ��� �Ǵ� �޿��� 300���� �ʰ��� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

-- �μ��ڵ尡 D5�� ����� ���, �̸�, �μ��ڵ�, �޿� ��ȸ 
-- �޿��� 300���� �ʰ��� ����� ���, �̸�, �μ��ڵ�, �޿���ȸ 



-- UNION���� 2�� �������� ��ġ�� 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5'
UNION -- ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE  SALARY > 3000000;

-- ** ������(INTERSECT)
-- �μ��ڵ尡 D5�̰� �޿��� 300���� �ʰ��� ����� ���, �̸�, �μ��ڵ�, �޿� ��ȸ 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D5'
MINUS 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY  > 3000000;
-- INTERSECT



-- MINUS : ���� ��������� ���� ��� ���� �� ������ 
-- �μ��ڵ尡 D5�� ����� �� �޿��� 300���� �ʰ��� ������� �����ϰ� ��ȸ

/*
        ���� ������ ��� �� ���ǻ��� 
        
        1) �÷� ������ �����ؾ��Ѵ�. 
        2) �÷� �ڸ����� ������ Ÿ������ �ۼ��ؾ� �� 
        3) �����ϰ��� �Ѵٸ� ORDER BY���� �������� �ۼ��ؾ��Ѵ�.
*/








