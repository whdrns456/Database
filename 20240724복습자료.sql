-- ��������???�������� ������ ���� ���� �� �Ʒ� SQL���� �ۼ����ּ��� ��������???��������
--============================================================================--

-- [1] '240724' ���ڿ��� '2024�� 7�� 24��'�� ǥ���غ���
SELECT  TO_CHAR(TO_DATE(240724), 'YYYY"��" MM"��" DD"��"')
FROM DUAL;

-- [2] ������ �¾ �� ��ĥ°���� Ȯ���غ��� (���糯¥ - �������)
SELECT  CEIL(SYSDATE - TO_DATE('94/03/07'))
from dual;


-- [3] ���� ������ �ٲ㺸��
-- bElIVe iN YoURseLF.      -->  Belive in yourself.
SELECT concat(upper(SUBSTR('bElIVe iN YoURseLF.', 1, 1)), LOWER(SUBSTR('Belive in yourself.', 2))) 
FROM DUAL;

-- 


/*
------------------------------------------------------------
    ����     |   �Ի��   |   �Ի� �����|
         7�� |       4�� |          2��|
         7�� |       9�� |          1��|
         ...
         9�� |       6�� |          1��|
------------------------------------------------------------
*/
-- [4] ������ 7�������� ������� �Ի���� ��� �� ��ȸ (�Ʒ��� ���� ���)
SELECT LPAD(SUBSTR(EMP_NO, 3, 2) || '��', 8) "����"
    ,  EXTRACT(MONTH FROM HIRE_DATE) || '��'
    , LPAD(COUNT(*) || '��',5) "�Ի� �����"
FROM employee
WHERE TO_NUMBER(SUBSTR(EMP_NO, 3, 2)) >= 7 
GROUP BY SUBSTR(EMP_NO, 3, 2), EXTRACT(MONTH FROM HIRE_DATE);
-- ~�� group BY


-- [5] �����μ� ����� ���, �����, �μ���, ���޸� ��ȸ

-- ���, �μ�, ���� -- > ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM employee
    JOIN department ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE)
WHERE DEPT_TITLE LIKE '%����%';
    -- ON�� USING �� �� �ϳ��� 





