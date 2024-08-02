/*
    *������(SEQUENCE) 
    : �ڵ����� ��ȣ�� �߻� �����ִ� ������ �ϴ� ��ü 
      ������ ���������� ������ ������ ���� ��Ű�鼭 ���� 
    
    EX) �����ȣ, ȸ����ȣ, ������ȣ, .... 
*/

/*
    *������ �����ϱ�*
    
    CREAT SEQUENCE �������� 
    [START WITH ����] --> ó�� �߻���ų ���۰� ���� : [���� �� �⺻���� 1]
    INCREMENT BY ���� --> �󸶸�ŭ�� ������ų �������� ���� �� ���� [�⺻�� : 1]
    MAXVALUE ���� --> �ִ밪 �⺻�� [100..��ûŭ]
    MINVALUE -- �ּҰ�[�⺻�� : 1]
    CYCLE | NOCYCLE : ���� ��ȯ���� [�⺻�� : NOCYCLE]
    -->  CUCLE : ������ ���� �ִ밪�� �����ϸ� �ּҰ����� �ٽ� ��ȯ�ϵ��� ����
    --> NOCYCLE : ������ ���� �ִ밪�� �����ϸ� ���̻� ���� ������Ű�� �ʵ��� ���� 
    
    NOCACHE | CACHE --> ĳ�ø޸� �Ҵ� ���� [�⺻�� : CACHE 20]
                    --> ĳ�ø޸� : �̸� �߻��� ������ �����ؼ� �����صδ� ���� 
                            �Ź� ȣ���� ������ ���� �����ϴ� ���� �ƴ϶� 
                            ĳ�ø޷θ���� ������ �̸� ������ ������ �����ٰ� ��� 
                            (�ӵ��� ����)
                            
                            
       [����]
       * ���̺� : TB_
       * ��    : VW_
       * ������ : SEQ_
       * Ʈ���� : TRG_
*/
-- SEQ_TEST��� �̸��� ������ ���� 

CREATE SEQUENCE SEQ_TEST;

SELECT * FROM user_sequences;

-- SEQ_EMPNO��� �̸��� ������ ���� 
-- ���� ��ȣ�� 300��, �������� 5, �ִ밪�� 310, ��ȯx ĳ�ø޸�x
CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
    * ������ ����ϱ� *

    - ��������.CURRVAL : ���� ������ ��(���������� ������ NEXTVAL�� ������ ��)
    - ��������.NEXTVAL : ������ ���� ���� ���� �������� �߻��� ����� 
                        ���� ������ ������ INCREMENT BY ������ �� ��ŭ ������ ��     
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- ���� �߻� ! NEXTVAL�� �ѹ��� �������� ���� �̻�
-- CURRVAL�� ����� �� ����. 

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
-- ���� �� ó�� ���� �� ���۰� : 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
-- 315 ==> ���� �߻�! �ִ밪�� 310���� �����Ǿ� �־� �� �̻��� ���� ��ȸ�ǹǷ� ���� 
SELECT * FROM user_sequences;

/*
    *������ ���� �����ϱ�*
    
    ALTER SEQUENCE �������� 
    (INCREMENT BY ����) -- > ������ (�⺻)
    MAXVALUE           --> �ִ밪 (�⺻�� : ��ûŭ..)
    MINVALUE --< �ּҰ� 1
    [CYCLE | NOCYCLE ] -- > �� ��ȯ���� (�⺻�� : NICYCLE)
    [NOCACHE | CACHE] --> ĳ�ø޸� ��뿩��. ���� ����(����Ʈ ����)(�⺻�� : CACHE)
    
    => START WITH ���� �Ұ�!  
*/
-- SEQ_EMPNO �������� �������� 10, �ִ밪�� 400���� ���� 

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10 
MAXVALUE 100000;



SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 

-- ������ ���� : DROP 
DROP SEQUENCE SEQ_EMPNO;

-- ������ ���� Ȯ�� : 
SELECT * FROM USER_SEQUENCES;
--------------------------------------------------------------------------------

/*
    * EMPLOYEE ���̺� ������ ����
    -> ������ ���� �÷� : �����ȣ(EMP_ID)
*/
--> ������ �����ϱ� : 
CREATE SEQUENCE SEQ_EID 
START WITH 300

NOCACHE; -- ĳ�ø޸� ��� X

-- ���۰� : 300, ������ 1 .. ��ȯ���� : NOCYCLE, �ִ� : ��ûū�� 

-- * ������ ����ϱ� : EMPLOYEE ���̺� ������ �߰��� �� 
INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,HIRE_DATE)
    VALUES (SEQ_EID.NEXTVAL, '���ǿ�', '990928-1111111', 'J4',SYSDATE);

SELECT * FROM employee;


INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,HIRE_DATE)
    VALUES (SEQ_EID.NEXTVAL, '���Ǽ�', '990928-2111111', 'J4',SYSDATE);

INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,HIRE_DATE)
    VALUES (SEQ_EID.NEXTVAL, '���α�', '990928-2111111', 'J4',SYSDATE);


INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,HIRE_DATE)
    VALUES (SEQ_EID.NEXTVAL, '������', '990928-2111111', 'J4',SYSDATE);


ROLLBACK;
-- DELETE TABLE EMPLOYEE  

DROP SEQUENCE SEQ_EID;












