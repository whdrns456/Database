/*
    * PL/SQL 
    
    ����Ŭ ��ü�� ���� �Ǿ� �ִ� ������ ��� 
    SQL ���� ������ ���� ���� ����, �ݺ����� �����Ͽ� SQL ������ ����
    �ټ��� SQL���� �ѹ��� ���డ�� 
    
    * ���� *
    [�����] ���� ���� : DECLARE�� ����. ������ ����� �ʱ�ȭ�ϴ� �κ� 
    �����     : BEGIN���� ����. SQL�� �Ǵ� ���[���ǹ�, �ݺ���]���� ������ �ۼ��ϴ� �κ� 
    [����ó����] �������� EXCEPTOIN���� ���� ���� �߻� �� �ذ��ϱ� ���� �κ� 
*/
--
SET SERVEROUTPUT ON;
-- HELLO ORACLE ��� 
-- ȭ�鿡 ����ϰ��� �� �� DBMS_OUTPUT.PUT_LINE(����� ����)
BEGIN 

DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');

END;
--------------------------------------------------------------------------------

/*
    * ����� :  (DECLARE)
    : ���� �Ǵ� ����� �����ϴ� �κ� (����� ���ÿ� �ʱ�ȭ�� ����)

    - ������ Ÿ�� ���� ����
    + �Ϲ� Ÿ�� 
    + ���۷��� Ÿ�� 
    + ROW Ÿ��
*/

/*
    * �Ϲ� Ÿ�� ���� 
    
       ������ [CONSTANT] �ڷ��� [:=��]
       -- ��� ���� �� CONSTANT�� �ٿ� ��
       -- �ʱ�ȭ�� ���� ":=" ��ȣ�� ��� 
    
*/
DECLARE 
    EID NUMBER;         -- EID��� �̸��� NUMBER Ÿ�� ���� ����
    ENAME VARCHAR2(20); -- ENAME�̶�� �̸��� VARCHAR2(20) Ÿ�� ���� ����
    PI CONSTANT NUMBER := 3.14; -- PI��� �̸��� NUMBER Ÿ���� ��� ���� �� 3.14������ �ʱ�ȭ 
BEGIN 
-- ������ ���� ���� 
    EID := 100;                     -- EID��� ������ 100�̶�� ���� ���� 
    ENAME := '�Ӽ���';                -- ENAME�̶�� ������ ���̸� ������ ���� 
    
    -- �� ����, ����� ����� ���� ȭ�鿡 ��� 
    -- Ư�� ���ڿ� ������ ���� ����ϰ��� �� �� ���Ῥ���� (||)�����     
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);  
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);

END;


DECLARE 
    EID NUMBER;         
    ENAME VARCHAR2(20); 
    PI CONSTANT NUMBER := 3.14;  
BEGIN 
-- ������ ���� ���� 
    EID := '&�����ȣ';                   
    ENAME := '�Ӽ���';              
    
       
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);  
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);


END;
/
--------------------------------------------------------------------------------
/*
    * ���۷��� Ÿ�� ���� 
      : � ���̺��� � �÷��� ������Ÿ���� �����Ͽ� �ش� Ÿ������ ������ ���� 
      
      ������ ���̺��.�÷���%TYPE
*/
DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;  -- EID���  ������ EMPLOYEE���̺��� EMP_ID �÷��� Ÿ���� ���� 
    ENAME EMPLOYEE.EMP_NAME%TYPE; -- ENAME ������ 
    SAL EMPLOYEE.SALARY%TYPE;

BEGIN
   -- EMPLOYEE ���̺��� 200�� ����� ���, �����, �޿���ȸ
    SELECT EMP_ID, EMP_NAME, SALARY 
    INTO EID, ENAME, SAL
    FROM employee
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;

-- ���� -- 
/*

    ���۷��� Ÿ���� ������ EID, ENAME, SAL DTITLE�� �����ϰ� 
    �� �ڷ����� EMPLOYEE���̺��� EMP_ID, EMP_NAME, JOB_CODE, SALARY �÷���
    DEPARTMENT ���̺��� DEPT_TITLE �÷��� �����ϵ��� �� ��
    ����ڰ� �Է��� ����� ��� ������ ��ȸ�Ͽ� ������ ��� ��� 
    
    ��� ���� : [���], [�̸�], [�����ڵ�], [����], �μ���

*/
BEGIN
   -- EID := '100';
   --  ENAME := '�Ӽ���';
    
    -- EMPLOYEE ���̺��� 200�� ����� ���, �����, �޿���ȸ
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY 
    INTO EID, ENAME, JCODE, ESAL, DTITLE
    FROM employee
    WHERE EMP_ID = 200;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODE : ' ||JCODE);
END;

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;         
    ENAME EMPLOYEE.EMP_NAME%TYPE ; 
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    ESAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    
BEGIN 
-- ������ ���� ���� 
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, ESAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE(EID || ', '  || ENAME || ', ' || JCODE || ',' );
    
    
END;   
/    
--------------------------------------------------------------------------------

/*
    * ROW Ÿ�� ���� 
    : ���̺��� �� �࿡ ���� ��� �÷����� �ѹ��� ���� �� �ִ� ���� 
    
    ������ ���̺��%ROWTYPE;
    
*/
DECLARE 
    E EMPLOYEE%ROWTYPE;
BEGIN 
    SELECT  *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &���;

    -- �����, �޿�, ���ʽ� ������ ��� 
    DBMS_OUTPUT.PUT_LINE('����� : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY );
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || E,BONUS);
    
END;
/

--==============================================================================

/*
    * ����� (BEGIN)
    
    ** ���ǹ� **
    -- ���� IF�� : IF ���ǽ�. THEN ���೻�� END IF;
    -- IF/ELSE�� : IF ���ǽ� THEN ���ǽ��� ���ϋ� ���೻�� ELSE ���� ���� 
    ELSE ���ǽ��� ������ �� ���� ���� END IF;
    IF/ELSEIF�� : IF ���ǽ� 1 THEN ���೻��1 ELSIF ���ǽ�2 THEN ���೻��2 ...
    ELSE ���೻�� END IF; 
    
    - CASE/WHEN/THEN ��
        CASE �񱳴�� WHEN ����񱳰�1 THEN �����1
                     WHEN ����񱳰�2 THEN �����2
                     WHEN ����񱳰�3 THEN �����3
                     ... ELSE ����� N
                     END;
*/
-- ����ڿ��� ����� �Է��� �� �ش� ����� ���, �̸�, �޿�, ���ʽ� ������ ��� 
-- �� �����Ϳ� ���� ���� : ���(EID), �̸�(ENAME), �޿�(SAL), ���ʽ�(BONUS)
-- ��, ���ʽ����� 0�� ����� ��� "���ʽ��� ���� �ʴ� ����Դϴ�" ��� 

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;         
    ENAME EMPLOYEE.EMP_NAME%TYPE; 
    ESAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    
BEGIN 
    SELECT  EMP_ID , EMP_NAME, SALARY, NVL(BONUS, '0') 
        INTO  EID, ENAME, ESAL, BONUS
        FROM EMPLOYEE
        WHERE EMP_ID = '&EMP_ID';
       
        DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
        DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
        DBMS_OUTPUT.PUT_LINE('�޿� : ' || ESAL);
        
        IF(BONUS = 0)
            THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���� ���� �ʴ� ����Դϴ�');
            
            ELSE 
            
            DBMS_OUTPUT.PUT_LINE('���ʽ��� ' || BONUS  || '%');
            END IF;
END;
/   

/*
    * DECLARE 
        ���۷��� ���� (EID, ENAME, DTITLE, NCODE)
            ��������(EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE)
         -- �Ϲ�Ÿ�Ժ���(TEAM ����Ÿ��) --> '������' �Ǵ� '�ؿ���' ������ ����
         
         BEGIN 
         -- ����ڰ� �Է��� ����� �ش��ϴ� ���, �̸�, �μ���, �ٹ������ڵ� ��ȸ 
         -- ��ȸ�� �� �ش� ������ ���� 
         
         -- �̶� NCODE ���� KO�� ��� '��������' TEAM ������ ���� 
         KO�� �ƴ� ��� '�ؿ���'�� TEAM ������ ���� 
         
         -- ��� ���� : ���, �̸�, �μ�, �Ҽ� 
         END; 
         /
*/

DECLARE   
    EID EMPLOYEE.EMP_ID%TYPE;         
    ENAME EMPLOYEE.EMP_NAME%TYPE; 
    DTITLE DEPTARTMENT.DEPT_TITLE%TYPE;
    NCODE  NATIONAL.NATIONAL_CODE%TYPE;
    
    TEAM VARCHAR2(10);
    
BEGIN 

        SELECT  EMP_ID , EMP_NAME, DEPT_TITLE, NATIONAL_CODE
        INTO  EID, ENAME, DTITLE, NCODE
        FROM EMPLOYEE
        JOIN department ON DEPT_CODE = DEPT_ID
        JOIN  LOCATION ON LOCATION_ID = LOCAL_CODE 
        WHERE EMP_ID = '&EMP_ID';
       
       
        
        IF NCODE = 'KO'
            THEN TEAM := '������';
        ELSE 
            TEAM := '�ؿ���';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
        DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
        DBMS_OUTPUT.PUT_LINE('�μ��� : ' || DTITLE);
        DBMS_OUTPUT.PUT_LINE('NCODE : ' || NCODE);
            

END;
/

-- ���� ���(SCORE)
-- ���(GRADE) 'A', 'B', 'C','D','F' 
-- �� �Ʒ��� F

DECLARE   
    SCORE NUMBER;
    CRADE CHAR(1);
    
BEGIN 
    SCOR := &����;
    
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    
    DBMS_OUTPUT.PUT_LINE('������ ' || SCORE || '�̰�, ����� ' || GRADE || '�Դϴ�. '  );
    
    
    ELSE  GRADE := 'F';
    DBMS_OUTPUT.PUT_LINE('����� ����Դϴ� '  );
    
    END IF;
END;
     -- IF/ELSE�� : IF ���ǽ� THEN ���ǽ��� ���ϋ� ���೻�� ELSE ���� ���� 

--------------------------------------------------------------------------------

-- ����� �ش��ϴ� ����� �μ��ڵ� �������� �μ����� ���(JOIN ���x)
DECLARE 
    EMP EMPLOYEE%ROWTYPE;
    DTITLE VARCHAR2(50);
BEGIN 
    SELECT *
    INTO EMP
    FROM EMPLOYEE 
    WHERE EMP_ID = &���;
    
    -- �ش� ����� �μ��ڵ� �������� �μ��� ���� 
    DTITLE := CASE EMP.DEPT_CODE
        WHEN 'D1' THEN '�λ������' 
        WHEN 'D2' THEN 'ȸ�������'
        WHEN 'D3' THEN '�����ú�'
        WHEN 'D4' THEN '����������'
        WHEN 'D5' THEN '�ؿܿ�����1'
        WHEN 'D6' THEN '�ؿܿ�����2'
        WHEN 'D7' THEN '�ؿܿ�����3'
        WHEN 'D8' THEN '���������'
        WHEN 'D9' THEN '�ѹ���'
        ELSE '�μ�����'
        END;
        
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || '����� �Ҽ� �μ���' || DTITLE || '�Դϴ�.');

END;
/
--------------------------------------------------------------------------------
/*
    * �ݺ��� 
    
       - �⺻ ���� : LOOP 
                    �ݺ��� ���� 
                    �ݺ����� ������ ���� 
                    END LOOP;
                    
               * �ݺ����� ������ ���� 
               [1] IF ���ǽ� THEN; END IF; 
               [2] EXIT WHEN ���ǽ�; 
               
            - FOR LOOP�� 
                FOR ���� [REVERSE] IN �ʱⰪ..������
                LOOP �ݺ��� ���� [�ݺ����� ������ ����] END LOOP; 
                
        * REVERSE : ���������� �ʱⰪ���� �ݺ� 
                
        - WHILE LOOP��
            WHILE ���ǽ� 
            LOOP �ݺ��� ���� END LOOP;
*/
-- �⺻���� ����Ͽ� 'HELLO ORACLE!'�� 5�� ��� 

DECLARE 
    N NUMBER := 1;
    
BEGIN

    LOOP

        DBMS_OUTPUT.PUT_LINE( N || 'HELLO ORACLE');
            
        N := N+1;
       
        IF N > 5
            THEN EXIT;
        END IF;

    END LOOP;
END;


-------------------------------------------------------------------------------
DECLARE 
    I NUMBER := 1;
BEGIN

    FOR I IN REVERSE 1..5
        LOOP
         DBMS_OUTPUT.PUT_LINE( I || ' HELLO ORACLE!!');
    END LOOP;
END;


--------------------------------------------------------------------------------

BEGIN
    FOR I IN REVERSE 1..5
        LOOP
         DBMS_OUTPUT.PUT_LINE( I || ' HELLO ORACLE!!');
    END LOOP;
END;
--------------------------------------------------------------------------------

-- TEST
DROP TABLE TEST;

CREATE TABLE TEST (
    TNO NUMBER PRIMARY KEY,
    TDATE DATE
);

CREATE SEQUENCE SEQ_TNO
INCREMENT BY 2
MAXVALUE 1000
NOCYCLE 
NOCACHE;

-- TEST ���̺� �����͸� 100�� �߰� (TNO: ������ ����, TDATE: ���糯¥ )



BEGIN
    
    FOR I IN REVERSE 1..100
    
    LOOP
    
    INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL, SYSDATE);
        
    END LOOP;
    
END;
/
SELECT * FROM TEST;



/*
  * ����ó���� 
    - ����(EXCEPTION) : �����߿� �߻��Ǵ� ���� 
   
   EXCEPTION 
      WHEN ���ܸ� THEN ����ó������; 
      WHEN ���ܸ� THEN ����ó������ 
      WHEN OTHERS THEN ����ó������; 
      
      * ����Ŭ���� �̸� ������ ���ܵ�  = �ý��� ���� 
       - NO_DATA_FOUND : ��ȸ�� ����� ���� �� 
       - TOO_MANY_ROWS : ��ȸ�� ����� ���� ���� �� (=> ������ ����...)
       
       - ZERO_DIVIDE : 0���� ���� ���������� ��
       - DUP_VAL_ON_INDEX : UNIQUE ���ǿ� ����� �� (�ߺ��Ǵ� ���)
       
       * OTHERS : � ���ܵ� �߻��Ǿ��� �� 
*/

-- ����ڿ��� ���ڸ� �Է¹޾� 10���� ���� ����� ��� (0�� �ԷµǾ��� �� ������ �߻��� �� �ִ� )
DECLARE
    NUM NUMBER := 0;
    
BEGIN
     NUM := &����;
     
     DBMS_OUTPUT.PUT_LINE(10 / NUM);
EXCEPTION WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('0���� ���� �� �����ϴ�');
END;
/

--EMPLOYEE ���̺� 
-- EMP_ID �÷��� �⺻Ű�� ���� 
ALTER TABLE EMPLOYEE ADD PRIMARY KEY(EMP_ID);
-- �⺻Ű (PRIMARY KEY) : UNIQUE + NOT NULL

BEGIN 

    UPDATE  EMPLOYEE
    SET EMP_ID = '&������_���'
    
    WHERE EMP_NAME = '���ö';
    
    EXCEPTION 
        WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�ߺ��� ����Դϴ�');
END;
/
---------------���� -------------------------------------------------------------
/*
    * ����� ����� �Է� �޾� �ش� ����� ���, �̸��� ��� 
    
OTHERS
*/


DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;

BEGIN  
    SELECT  EMP_NAME, EMP_NAME 
    INTO EID, ENAME 
    FROM EMPLOYEE
    WHERE MANAGER_ID = '&������';
    --����Ÿ������ �Է¹ް��� �� ��� ''��������ǥ�� �����ش�. 
      
   DBMS_OUTPUT.PUT_LINE('���' || EID);
   DBMS_OUTPUT.PUT_LINE('�̸�' || ENAME);

    EXCEPTION 
        WHEN NO_DATA_FOUND  THEN DBMS_OUTPUT.PUT_LINE('�Է��� ��� ����� ���� ����� �����ϴ�');
        WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('�ش� ����� ���� ����� �����ϴ�');
        WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ �߻��߽��ϴ�. �����ڿ��� ����'); 
END; 
    










    
    
    


