/*

  * �Լ�(FUNCTION) : 
  : ���޵� �÷����� �о �Լ��� ������ ����� ��ȯ 
  
  - ������ �Լ� : N���� ���� �о N���� ������� ����(�ึ�� �Լ��� ������ ����� ��ȯ)
  - �׷� �Լ� : N���� ���� �о 1���� ������� ���� (�׷��� ���� �׷캰�� �Լ��� ������ ����� ��ȯ) 
  
  + SELECT���� ������ �Լ��� �׷��Լ��� �Բ� ����� �� ����!
    = > ��� ���� ������ �ٸ��� ������ 
    
    + �Լ����� ����� �� �ִ� ��ġ : SELECT��, WHERE�� ODER BY�� GROUP, HAVING�� 
*/
-- ==================������ �Լ� ================================================
/*
   * ����Ÿ���� ������ ó�� �Լ� : 
    = > VARCHAR2(n), CHAR(n) 
    
    = > LENGTH(�÷��� | '���ڿ�') : �ش� ���ڿ��� ���ڼ��� ��ȯ 
    lENGTHB(�÷��� | '���ڿ�') : �ش� ���ڿ��� Byte ���� ��ȯ 
    
    = > : ������, ����, Ư������ ���ڴ� 1byte 
    = > : �ѱ��� ���ڴ� 3byte
    
*/

-- '����Ŭ' �ܾ��� ���ڼ��� ����Ʈ���� Ȯ���غ���. 
SELECT LENGTH('����Ŭ') ���ڼ�, LENGTHB('����Ŭ') ����Ʈ��
FROM DUAL;

-- DUAL ���� ���̺� 
SELECT LENGTH('ORACLE') ���ڼ�, LENGTHB('ORACLE') ����Ʈ��
FROM DUAL;

SELECT LENGTH('��') ���ڼ�, LENGTHB('ORACLE') ����Ʈ��
FROM DUAL;

SELECT emp_name, LENGTH(emp_name) "��� ���ڼ�" , LENGTHB(emp_name) �������Ʈ, LENGTH(email) "�̸��� ���ڼ�" ,LENGTHB(email) "�̸��� ����Ʈ"
FROM employee;

/*

   [ǥ����]
   
   * INSTR : ���ڿ��κ��� Ư�� ������ ���� ��ġ�� ��ȯ �÷�
    
    INSTR(�÷� | '���ڿ�', 'ã�����ϴ� ����')[, ã�� ��ġ�� ���۰�, ����1]
    = > �Լ� ���� ����� ����Ÿ��[NUMBER]
    SELECT INSTR 
*/

SELECT INSTR ('AABAACAABBAA', 'B') -- ���ʿ� �ִ� ù��° B�� ��ġ : 3
FROM DUAL;

SELECT INSTR ('AABAACAABBAA', 'B', 1) -- ���ʿ� �ִ� ù��° B�� ��ġ : 3
FROM DUAL;    
-- ã�� ��ġ�� ���۰� : 1(�⺻��)
SELECT INSTR('AABAACAABBAA','B',-1)
FROM DUAL;

            -- �������� ���۰����� ���ö�� �ڿ������� ã�´� 
            -- �ٸ�, ��ġ�� ���� ���� �տ������� �о ����� ��ȯ�Ѵ� 
            -- ���ʿ� �ִ� ù��° B�� ��ġ : 10
            

-- ������ ���� ������ ���� ���۰��� �����ؾ� ��!
SELECT INSTR('AABAACAABBAA','B',1,2)
FROM DUAL;                              
-- ���ʿ� �ִ� �ι�° B�� ��ġ : 9

-- ��� ���� �� �̸��Ͽ� _�� ù��° ��ġ 
SELECT EMAIL, INSTR(email, '_', 1,1)"_ ��ġ", INSTR(email, '@', 1,1)"@ ��ġ"
FROM employee;                    
--------------------------------------------------------------------------------

/*
        * SUBSTR : ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ 
        
        
        [ǥ����]
                SUBSTR(���ڿ�|�÷�, ������ġ[, ����(����)])
                => 3��° ���� �κ��� �����ϸ� ���ڿ� ������ ����!                
*/

SELECT SUBSTR('ORACLE SQL DEVELOPER', 10) FROM DUAL;
SELECT SUBSTR('ORACLE SQL DEVELOPER', 8, 3) FROM DUAL; -- => 8��° ��ġ���� 3���ڸ� �߷� 
SELECT SUBSTR('ORACLE SQL DEVELOPER', -3) FROM DUAL; -- PER : �ڿ������� 3��° ��ġ���� ������ ����
SELECT SUBSTR('ORACLE SQL DEVELOPER', -9, 3) FROM DUAL; -- DEV
SELECT SUBSTR('ORACLE SQL DEVELOPER', -9, 3) FROM DUAL;

-- ����� �� ������鸸 
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2','4');

-- ����� �� ������鸸 
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1','3')
ORDER BY EMP_NAME;

-- ��� ���� �� �����, �̸���, ���̵� ��ȸ 
-- [1] �̸��Ͽ��� '@'�� ��ġ�� ã�� => INSTR �Լ� ��� 
-- [2] �̸����� �÷��� ������ 1��° ��ġ���� '@'��ġ(1���� Ȯ��)������ ���� 
SELECT EMP_NAME, email, SUBSTR(email, '1',INSTR(EMAIL, '@') -1) 
FROM EMPLOYEE;





/*
    LPAD / RPAD : ���ڿ��� ��ȸ�� �� ���ϰ��ְ� ��ȸ�ϰ��� �� �� ��� 
                : ���ڿ��� �� ���̰����ϴ� ���ڸ� ���� �Ǵ� �����ʿ��� �ٿ��� 
                ���� ���̸�ŭ ���ڿ� ��ȯ 
                
               LPAD(���ڿ�|�÷�|,��������[, ������ ����])
               RPAD(���ڿ�|�÷�|,��������[, ������ ����])
               
               *������ ���� ���� �� �⺻������ �������� ä���� 
*/
-- ��� ���� �� ������� ������ �������� ä���� 
SELECT EMP_NAME,LPAD(EMP_NAME, 20) �̸�2 
FROM EMPLOYEE;

SELECT EMP_NAME,RPAD(EMP_NAME, 20) �̸�2 
FROM EMPLOYEE;

-- ��� ���� �̸�, �̸��� ������ �����Ͽ� ��ȸ
SELECT EMP_NAME,LPAD(email, 20, '��ٿ�') �̸���
FROM EMPLOYEE;
-- ����Ʈ �������� 20BYTE�� �� �� ���� 

-- ��� ���� �̸�, �̸��� ������ �����Ͽ� ��ȸ
SELECT EMP_NAME,RPAD(email, 20) ���� 
FROM EMPLOYEE;


-- ������� ������ �ֹ� ��ȣ ��ȸ
SELECT EMP_NAME,EMP_NO,RPAD(SUBSTR(EMP_NO, 1,8),14,'*') 
FROM EMPLOYEE;

-- ���� �����ڵ� ��밡��, 

--------------------------------------------------------------------------------

/*
        *LTRIM/RTRIM : ���ڿ����� Ư�� ���ڸ� ������ �� �������� ��ȯ 
        
        [ǥ����]
                LTRIM(���ڿ�|�÷�|[, �����ϰ����ϴ� ���ڵ�])
                RTRIM(���ڿ�|�÷�|[, �����ϰ����ϴ� ���ڵ�])
                * ������ ���ڸ� ������ �� ������ ���ŵ� 
*/

-- *������ ���ڸ� ���� �� ������ ���ŵ� 
SELECT LTRIM('     H I') FROM DUAL; -- ���ʺ���(�տ�������) �ٸ����ڰ� ���� ������ ���� ����  
SELECT LTRIM('H I     ') FROM DUAL; -- �����ʿ� �ִ� ������� ���� (I�� ������)

SELECT LTRIM('123123H123', '123')FROM DUAL;
SELECT LTRIM('321321H123', '123')FROM DUAL;

SELECT LTRIM('KKHHII','123')FROM DUAL;

/*
    *TRIM : ���ڿ� ��/��/���ʿ� �ִ� ������ ���ڵ��� ������ �� �ʸ��� ���� ��ȯ 

    [ǥ����]
        TRIM([LEADING | TRAILING | BOTH] ������ ���� FROM ���ڿ�|�÷�)
        * ������ ���� ���� �� ���� ���� 
        * �⺻ �ɼ��� BOTH(����)
*/


SELECT TRIM('   H I   ') �� FROM DUAL;

SELECT TRIM(LEADING 'L' FROM 'LLLLLHLILLLLLLL') �� FROM DUAL;
SELECT TRIM(TRAILING 'L' FROM 'LLLLLHLILLLLLLL') �� FROM DUAL;
SELECT TRIM(BOTH 'L' FROM 'LLLLLHLILLLLLLL') �� FROM DUAL;

-- LEADING LTRIM�� �����ϴ�.
-- TRAILING RTRIM�� �����ϴ�.
-- BOTH TRIM�� �����ϴ�. 

--------------------------------------------------------------------------------

/*
    * SELECT TRIM(BOTH 'L' FROM 'LLLLLHLILLLLLLL') �� FROM DUAL;
     / UPPER /  INITCAP - ���� �������� 
    
    - LOWER : ���ڿ��� ��� �ҹ��ڷ� �����Ͽ� ��ȯ 
    - UPPER : ���ڿ��� ��� �빮�ڷ� �����Ͽ� ��ȯ 
    - INITCAP : ���� �������� ù ���ڸ��� 
    
*/
-- "I Think so I am"
SELECT LOWER('I Think so I am') FROM DUAL;

SELECT UPPER('I Think so I am') FROM DUAL;

SELECT INITCAP('I Think so i am') FROM DUAL;

/*
  * CONCAT : ���ڿ� �� ���� ���޹޾� �ϳ��� ��ģ �� ���ڿ� ��ȯ 
  
     [ǥ����] 
     
             [CONCAT(���ڿ�1, ���ڿ�2)]
             
*/
-- 'KH' 'L������'
SELECT CONCAT('KH', ' L������')FROM DUAL;
SELECT 'KH' || ' L������' FROM DUAL;

SELECT '�ٿ��' || ' 30' FROM DUAL;
SELECT CONCAT('KH', ' L������')FROM DUAL;

SELECT CONCAT(EMP_NAME, ' ��')FROM EMPLOYEE;
-- ��� ��ȣ�� {�����}�� �� �ϳ��� ���ڿ��� ��ȸ => 200�����ϴ� 

SELECT EMP_NAME || '��' 
FROM EMPLOYEE;

SELECT CONCAT(EMP_ID, CONCAT(EMP_NAME,'��'))
FROM EMPLOYEE;
-------------------------------------------------------------------------------

/*

  * REPLACE :Ư�� ���ڿ����� Ư�� �κ��� �ٸ� �κ����� ��ü�Ͽ� ���ڿ� ��ȯ 
  
  [ǥ����]
         REPLACE(���ڿ�, ã�� ���ڿ�, ������ ���ڿ�)
*/
SELECT * FROM employee;

SELECT * FROM employee;
-- ��� ���̺��� �̸��� ���� �� 'or.kr' �κ��� "kh.or.kr" ���� �����Ͽ� ��ȸ 
SELECT REPLACE(EMAIL, '@or.kr' ,'@gmail.com') �̸���
FROM employee;
-- ��ҹ��� ��Ȯ�ϰ� ������ ���ֶ�
-- ============================================================================

/*
     [ ���� Ÿ���� ������ ó�� �Լ� ]
        
       
       * ABS : ������ ���밪�� �����ִ� �Լ�       
*/

SELECT ABS(-10) "-10�� ���밪" FROM DUAL;
 
SELECT ABS(-7.7) "-7�� ���밪" FROM DUAL; 


/*

    * MOD : �� ���� ���� ������ ���� �����ִ� �Լ� 
    MOD(����1, ����2) --> ����1 % ����2 
*/
-- 10�� 3���� ���� �������� ���غ��ٸ�..?
SELECT MOD(10,3) FROM DUAL;
SELECT MOD(10.9,3) FROM DUAL;
SELECT MOD(10.9,3.2) FROM DUAL;
-- =============================================================================

/*
    * ROUND : �ݿø��� ���� �����ִ� �Լ� 
    
    ROUND(����[, ��ġ]) : ��ġ => �Ҽ��� N��°�ڸ�
    
    *
*/
SELECT ROUND(123.456) FROM DUAL; -- 123
SELECT ROUND(123.456 , 1) FROM DUAL; -- 123.5
SELECT ROUND(123.456 , 2) FROM DUAL; -- 123.46

SELECT ROUND(123.456 , -1) FROM DUAL; -- ��� : 120 
SELECT ROUND(123.456 , -2) FROM DUAL; -- ��� : 100
-- => ��ġ���� ����� ������ ���� �Ҽ��� �ڷ� ��ĭ�� �̵�, ������ ������ ���� �Ҽ��� ���ڸ��� �̵� 

/*
    * CEIL : �ø�ó���� ���� �����ִ� �Լ� 
*/

SELECT CEIL(123.456) FROM DUAL;

SELECT FLOOR(123.456) FROM DUAL;

/*
     TRUNC : ����ó���� ���� �����ִ� �Լ�(��ġ ���� ����)
*/
SELECT TRUNC(123.456,1) FROM DUAL; -- ��� : 123.4
SELECT TRUNC(123.456,-1) FROM DUAL; -- ��� : 120 

-- ==================================================

-- sysdate : �ý����� ���� ��¥ �� �ð��� ��ȯ 

SELECT sysdate FROM DUAL;

-- MONTHS_BETWEEN 
-- �� ��¥ ������ ���� ���� ��ȯ 
-- [ǥ����] MONTHS_BETWEEN(��¥A, ��¥B) : ��¥A  - ��¥V => ���� �� ��� 
SELECT EMP_NAME, HIRE_DATE, concat(CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)), '������') "�ټӰ�����" 
FROM employee
ORDER BY HIRE_DATE;


SELECT CEIL(MONTHS_BETWEEN(SYSDATE, '24/06/11')) || '������' "���� ��������"
FROM DUAL;

--�����ϱ��� �� ���� ���Ҵ��� 
SELECT CEIL(MONTHS_BETWEEN(SYSDATE, '24/06/11')) || '������' "���� ��������"
FROM DUAL;

SELECT MONTHS_BETWEEN('24/11/25', sysDATE) || '���� ����!' "�������" 
FROM DUAL;


SELECT FLOOR(MONTHS_BETWEEN('24/11/25', sysDATE)) || '���� ����!' "�������" 
FROM DUAL;

SELECT MONTHS_BETWEEN('24/11/25', sysDATE) || '���� ����!' "�������" 
FROM DUAL;
--  : Ư�� ��¥�� N���� ���� ���ؼ� ��ȯ 
-- [ǥ����] ADD_MONTHS(��¥, ���� ���� ���� ���ؼ� ��ȯ)


SELECT  SYSDATE ���糯¥, ADD_MONTHS(SYSDATE, 4) ������
FROM DUAL;


-- ��� ���̺��� �����, �Ի���, �Ի��� +  3���� "����������" ��ȸ 
SELECT  EMP_NAME, HIRE_DATE �Ի���, ADD_MONTHS(HIRE_DATE, 3) ���������� 
FROM employee;

-- NEXT_DAY : Ư�� ��¥ ���� ���� ����� ������ ��¥�� ��ȯ 
-- [NEXT_DAY](��¥, ����[����|����])

-- *1:�� 2:�� 
SELECT  EMP_NAME, HIRE_DATE �Ի���, NEXT_DAY(HIRE_DATE, 3) 
FROM employee;

-- ���� ��¥ ���� ���� ����� �ݿ����� ��¥ ��ȸ 

SELECT NEXT_DAY(SYSDATE, 6) -- ���ڴ� ���� ������� ���۵�! 
FROM DUAL;

SELECT NEXT_DAY(SYSDATE, '�ݿ���') 
FROM DUAL;

-- ��� ���� : KOREAN / AMERICAN
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

SELECT sysdate, NEXT_DAY(SYSDATE, 'fri') 
FROM DUAL;

-- LAST_DAY : �ش� ���� ������ ��¥�� ���ؼ� ��ȯ 
SELECT sysdate, LAST_DAY(SYSDATE) 
FROM DUAL;


-- ��� ���̺��� �����, �Ի���, �Ի��� ���� ��������¥, �Ի��� ���� �ٹ��ϼ� ��ȸ
SELECT EMP_NAME �����, HIRE_DATE �Ի���, LAST_DAY(HIRE_DATE) "�Ի��� ���� ��������¥",  LAST_DAY(HIRE_DATE) - hire_date + 1 "�ٹ� Ƚ��"   
FROM employee;

-- =============================================================================

-- SELECT SYSDATE - '24/06/11' FROM DUAL;


/*
    * EXTRACT : Ư�� ��¥�κ��� �⵵/��/�� ���� �����ؼ� ��ȯ���ִ� �Լ� 
    
    [ǥ����]
            EXTRACT(YEAR FROM ��¥)  : ��¥���� ������ ���� 
            EXTRACT(MONTH FROM ��¥) : ��¥���� ���� ���� 
            EXTRACT(DAY FROM ��¥) : ��¥���� �ϸ� ����     
*/
-- ���� ��¥ ����, ����, ��, �� ���� �����Ͽ� ��ȸ

SELECT EXTRACT(YEAR FROM sysdate) ,EXTRACT(MONTH FROM sysdate), EXTRACT(DAY FROM sysdate)
FROM DUAL;

-- ��� ���̺� �����, �Ի�⵵, �Ի�� �Ի��� ��ȸ

SELECT EMP_NAME,EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵,EXTRACT(MONTH FROM HIRE_DATE)�Ի��, EXTRACT(DAY FROM HIRE_DATE) �Ի���
FROM employee
ORDER BY 2,3,4; 
-- "�Ի�⵵", "�Ի��","�Ի���"
-- 2,3,4

/*
    * ����ȯ �Լ� : ������Ÿ�� �������ִ� �Լ� 
         
         - ���� / ���� / ��¥ 
    
    TO_CHAR : ���� �Ǵ� ��¥ Ÿ���� ���� ���� Ÿ������ ��ȯ�����ִ� �Լ� 
    
    [ǥ����]
     TO_CHAR(����|��¥[, ����])
-- ����Ÿ�� --> ����Ÿ�� 
*/
SELECT 1234 , TO_CHAR(1234) FROM DUAL;

SELECT TO_CHAR(1234),TO_CHAR(1234, '999999') "���˵�����" FROM DUAL;
-- '9' : ������ŭ �ڸ����� Ȯ���ϰ�. ������ ����. ��ĭ�� �������� ä��. 

SELECT TO_CHAR(1234),TO_CHAR(1234, '000000') "���˵�����" FROM DUAL;
-- '0' ������ŭ �ڸ����� Ȯ��. ������ ����. ��ĭ�� 0���� ä��.  

SELECT TO_CHAR(1234),TO_CHAR(1234, 'L999999') "���˵�����" FROM DUAL;
-- => ���� ������ ������ ���� ȭ������� ���� ǥ��. ���� KOREAN �̹Ƿ� \(��ȭ)�� ǥ�õ�

SELECT TO_CHAR(1234),TO_CHAR(1234, '$999999') "���˵�����" FROM DUAL;


SELECT TO_CHAR(1000000, 'L9,999,999') "���˵�����" FROM DUAL;

-- ������� �����, ����, ������ ��ȸ(ȭ�����, 3�ھ� �����Ͽ� ǥ�õǵ���)
SELECT EMP_NAME, SALARY, TO_CHAR(SALARY*12, 'L9,999,999,999')
FROM employee;


-- ��¥Ÿ�� --> ����Ÿ�� 
SELECT SYSDATE, TO_CHAR(SYSDATE) "���ڷ� ��ȯ" FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;

--HH24 : 24�ð��� 
--HH : �� ���� 12�ð���  
-- MI : ������ 
-- SS: �� ���� 

-- =============================================================================

SELECT TO_CHAR(SYSDATE, 'yyyy-mm-dd DAY DY') FROM DUAL;
-- DAY : ��������(X����) -> '�Ͽ���', '������',.....'�����'
-- DY : ���� ����(X) - > '��', 'ȭ', '��'.....'��'

SELECT TO_CHAR(SYSDATE, 'MON') FROM DUAL;
-- MON : �� ����(X��) -> '1��', '2��', .....'12��'
-- MONTH : ���� ������ ���´�. 

-- ������̺��� �����, �Ի糯¥ ��ȸ(��, �Ի糯¥ ���� "XXXX�� XX�� XX��")���� ��ȸ

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"�� "MM"�� "DD"��"') "�Ի糯¥"
FROM employee;
-- ū ����ǥ�� �����ش� "��" 
-- ǥ���� ����(����)�� ū����ǥ("")�� ��� ���Ŀ� �����ؾ� ��!

/*
        * ������ ���õ� ���� 
        
        * YYYY : �⵵�� 4�ڸ��� ǥ��  --> 50�� ���� ���� ��¥�� 2000���� �ν� => 2050x
           YY : �⵵�� 2�ڸ��� ǥ��
          RRRR : �⵵�� 1900���� �ν�  --> 50�� �̻� ���� 195x
          RR : �⵵�� 4�ڸ��� ǥ��


*/


SELECT TO_CHAR(HIRE_DATE, 'YYYY-MM-DD'), TO_CHAR(HIRE_DATE, 'RRRR-MM-DD')
FROM EMPLOYEE;


/*
    * MM : �� ������ 2�ڸ��� ǥ�� 
      MON/MONTH : �� ������ 'X��', �������� ǥ��  - > ��� ������ ���� �ٸ� ����!
*/

SELECT TO_CHAR(SYSDATE, 'MM') "���ڸ�ǥ��", TO_CHAR(SYSDATE, 'MON') "����ǥ��1"
                                , TO_CHAR(SYSDATE, 'MONTH')
FROM DUAL;


/*
    �ϰ� ���õ� ����
    
        * DD : �� ������ 2�ڸ��� ǥ�� 
        * DDD : �ش� ��¥�� �� �� ���� �� ���� �ϼ�����  
        * D : ���� ������  => ���� Ÿ������ (1: �Ͽ���,.....7:�����)
         -> DAY : "X����"  ǥ�� 
          DY : Xǥ�� 
         
*/

SELECT TO_CHAR(SYSDATE,'DD') "�� ����", TO_CHAR(SYSDATE, 'DDD') "���° �ϼ�"
               , TO_CHAR(SYSDATE, 'D') "���� ����", TO_CHAR(SYSDATE, 'DAY') "��������2"
               , TO_CHAR(SYSDATE, 'DY') "���� ����3"
FROM DUAL;

- =============================================================================

/*
   
   * TO_DATE : ����Ÿ�� �Ǵ� ����Ÿ���� ��¥Ÿ������ �����ϴ� �Լ� 
  
  [ǥ����]
            TO_DATE(����|����[, ����]) => ��¥Ÿ�� 
*/
--
SELECT TO_DATE(20240719) FROM DUAL; 

SELECT TO_DATE(240719) FROM DUAL; --> �ڵ����� 50�� �̸��� 20XX���� ����

SELECT TO_DATE(880719) FROM DUAL; --> �ڵ����� 50�� �̻��� 19XX���� ����

SELECT TO_DATE(020222) FROM DUAL;
-->������ ���� ���� 0���� �����ؼ� ���ڴ� 0���� �����ϸ� �ȵȴ� 

SELECT TO_DATE('020222') FROM DUAL; -- 0���� ���۵Ǵ� ��� ����Ÿ������ ���� 

SELECT TO_DATE('20240719 104900', 'YYYYMMDD HH24MISS') FROM DUAL;
--> �̰�쿡�� ������ �����ؾߵȴ� 

-- ---------------------------------------------------------------------------

/*
     TO_NUMBER : ����Ÿ���� �����͸� ����Ÿ������ ��������ִ� �Լ� 

    [ǥ����]
        TO_NUMBER(����[, ����]) : ���ڿ� ���� ������ ����(��ȣ�� ���Եǰų� ȭ����� ���ԵǴ� ���....)
*/

SELECT TO_NUMBER('0123456789') FROM DUAL;


SELECT '10000' + '500' FROM DUAL;
--> �ڵ����� ���� -> ���� Ÿ������ ��ȯ�Ǿ� ������� �����! 

SELECT '10,000' + '500' FROM DUAL;

SELECT TO_NUMBER('10,000', '99,999')  + TO_NUMBER('500','999')FROM DUAL;
-- �긦 ���� �������� �ٲ� �޶�  99,999 ������ �˷��ش�. 


-- =============================================================================
/*
    NULL ó�� �Լ� : 
*/
/*
   * NVL : �ش� �÷��� ���� NULL�� ��� �ٸ� ������ ����� �� �ֵ��� ��ȣ�����ִ� �Լ� 
   
   [ǥ����]
        NVL(�÷�, �ش� �÷��� ���� NULL�� ��� ����� ��)
        
   
*/

SELECT EMP_NAME ����̸�, NVL(BONUS, 0) ���ʽ�
FROM EMPLOYEE;

-- ��� ���̺��� ����� ���ʽ� ���� ����

-- ��� ���̺��� �����, ���ʽ� ���� ����((SALARY + (SALARY )))

SELECT EMP_NAME ����̸�, SALARY ,(SALARY +(SALARY * NVL(BONUS, 0)))* 12 "���ʽ� ���� ����"
FROM EMPLOYEE;




/*
   * NVL2 : �ش� �÷��� ���� NULL�� ��� ǥ���� ���� �����ϰ�, 
                NULL�� �ƴ� ���(�����Ͱ� �����ϴ� ���) ǥ���� ���� ���� 
   [ǥ����]
   
        NVL2(�÷�, �����Ͱ� �����ϴ� ��� ����� ��, NULL�� ��� ����� ��)
*/

-- �����, ���ʽ� ����

SELECT EMP_NAME, NVL2(BONUS, 'O', 'X') "���ʽ� ����"
FROM EMPLOYEE;

-- �����, �μ��ڵ�, �μ���ġ ���� 


-- SELECT 
SELECT EMP_NAME, NVL(DEPT_CODE, '�̹���'), NVL2(DEPT_CODE, '�����Ϸ�', '�̹���') "�μ�"
FROM EMPLOYEE;



-- NULLIF : �� ���� ��ġ�ϸ� NULL, ��ġ���� �ʴ´ٸ� �񱳴��1 ��ȯ 
-- [ǥ����] NULLIF(�񱳴��1, �񱳴��2)

SELECT NULLIF('999','999') FROM DUAL; -- ����� NULL
SELECT NULLIF('999','555') FROM DUAL; -- ����� "999"
-- ==============================================================================












