/*
    * Ʈ���� (TRIGGER)
    : ������ ���̺� DML(INSERT, UPDATE, DELETE)���� ���� ��������� ���� �� 
    (���̺� �̺�Ʈ�� �߻����� ��)
    �ڵ����� �Ź� ������ ������ �̸� �����صδ� �� 
    
    ex) ȸ�� Ż�� �� ���� ȸ�����̺��� ������ ����(DELETE)�ϰ� 
        Ż�� ȸ�� ���̺� ������ �߰�(INSERT)�ؾ� �� �� �ڵ����� ���� 
        
    ex) �Ű� Ƚ���� Ư�� ���� �Ѿ�� �� �ش� ȸ���� ������Ʈ ó�� 
    
    ex) ����� ���� �����͸� ����� �� �ش� ��ǰ�� ��� ������ �����ؾ� �� ��
*/


/*
    * Ʈ������ ���� *
    
    -SQL���� ���� �ñ⿡ ���� �з�
     *BEFORE TRIGGER : ������ ���̺� �̺�Ʈ�� �߻��ϱ� ���� Ʈ���� ���� 
     * AFTER TRIGGER : ������ ���̺� �̺�Ʈ�� �߻��ϱ� �Ŀ� Ʈ���Ž��� 
    
    -SQL���� ���� ������ �޴� �� �࿡ ���� �з� 
    
    + ���� Ʈ����  : �̺�Ʈ�� �߻��� SQL�� ���� �� �ѹ��� ���� 
    + �� Ʈ���� : �ش� SQL���� ����� ������ �Ź� Ʈ���� ���� 
                FOR EACH ROW �ɼ� ���� �ʿ� 
                
                : OLD ~ DEFORE UPDATE (���� �� �ڷ�), BEFORE DELETE(���� �� �ڷ�) 
                : NEW ~ AFTER INSERT(�߰��� �ڷ�), AFTER UPDATE(���� �� �ڷ�)
*/

/*
    * Ʈ���� �����ϱ� 
    CREATE [OR REPLACE] TRIGGER                         -- Ʈ���� �̸�  
    BEFORE | AFTER INSERT | UPDATE | DELETE ON ���̺�� -- �̺�Ʈ ���� ���� 
    [FOR EACH ROW]                                     -- �Ź� Ʈ���Ÿ� ������ �������� ���� �ɼ�
    
    [DECLARE] -- ����/��� ���� �� �ʱ�ȭ
    BEGIN -- ����� (SQL��, ���ǹ�, �ݺ���,...)
                �̺�Ʈ �߻� �� �ڵ����� ó���� ���� 
                
    
   [EXCEPTION] -- ����ó���� 
   END;
*/
-- EMPLOYEE ���̺� �߰��� ������ '���Ի���� ȯ���մϴ� ^^ ���'


CREATE TRIGGER TRG_01
AFTER INSERT
ON EMPLOYEE
BEGIN
DBMS_OUTPUT.PUT_LINE('���� ����� ȯ���մϴ�');
END;
 /
 INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,DEPT_CODE, JOB_CODE, HIRE_DATE)
    VALUES (500, '������','000501-3000000','D4','J4',sysdate);
    
 INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,DEPT_CODE, JOB_CODE, HIRE_DATE)
    VALUES (501, '����â','950704-100000','D6','J5',sysdate);
--------------------------------------------------------------------------------
-- ��ǰ �԰� �� ��� ���� 
-- *���̺�, ������ ����
-- ��ǰ�� �����ϱ� ���� ���̺� 

CREATE TABLE TB_PRODUCT(
    PNO NUMBER PRIMARY KEY, -- ��ǰ ��ȣ 
    PNAME VARCHAR2(30) NOT NULL, -- ��ǰ��
    BRAND VARCHAR2(30) NOT NULL, -- �귣�� 
    PRICE NUMBER DEFAULT 0,-- ����
    STOCK NUMBER DEFAULT 0-- ������ 
);
 
-- ��ǰ��ȣ�� ����� ������ ���۹�ȣ 200, ������ 5 ĳ�ø޸� x

CREATE SEQUENCE SEQ_PNO
START WITH 200
INCREMENT BY 5 
NOCACHE;

-- SAMPLE ������ �߰� 
INSERT INTO TB_PRODUCT (PNO,PNAME, BRAND) VALUES(SEQ_PNO.NEXTVAL, '������15','���' );
INSERT INTO TB_PRODUCT VALUES(SEQ_PNO.NEXTVAL, '������ ����6','����',2000000,500);
INSERT INTO TB_PRODUCT VALUES(SEQ_PNO.NEXTVAL, '������','�����',80000,500);

COMMIT; -- DB�� �ݿ��ϱ� 

-- ��ǰ ����� ������ �����ϱ� ���� ���̺� 
CREATE TABLE TB_PDETAIL(
        DNO NUMBER PRIMARY KEY,
        PNO NUMBER REFERENCES TB_PRODUCT(PNO), -- ��ǰ��ȣ 
        DDATE DATE DEFAULT SYSDATE,
        AMOUNT NUMBER NOT NULL,
        TYPE CHAR(6) CHECK(TYPE IN('�԰�','���')) -- ����� ���� 
        
        
);
-- ����� ������ ���� ������ (���� ��ȣ)
CREATE SEQUENCE SEQ_DNO
NOCACHE;

-- 205�� ��ǰ ���� ��¥ 5�� ��� 
INSERT INTO TB_PDETAIL VALUES(SEQ_DNO.NEXTVAL, 205, DEFAULT, 5, '���');

-- * TB_PRODUCT 
UPDATE tb_product
SET STOCK = STOCK - 5
WHERE PNO = 205;

COMMIT;
SELECT * FROM tb_pdetail;
SELECT * FROM tb_product;

--200�� ��ǰ�� ��� 10 �԰� 
INSERT INTO tb_pdetail VALUES(SEQ_DNO.NEXTVAL, 200, DEFAULT, 10, '�԰�');
ROLLBACK;

UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PNO = 205;

COMMIT;
--------------------------------------------------------------------------------
/*
    * TB_PDETAIL(������Է�) ���̺� ������ �߰�(INSERT)�̺�Ʈ �߻� �� 
    TB_PRODUCT(��ǰ) ���̺� ��� ������ ����(UPDATE)�Ǿ�� ��! => �ڵ����� ó���� �� �ֵ��� Ʈ���� ���� 
    
    - UPDATE ���� 
        * ��ǰ�� �԰�� ��� => �ش� ��ǰ�� ã�Ƽ� ��� ���� ���� 
        UPDATE TB_PRODUCT
        SET STOCK = STOCK + �԰����(TB_PDETAIL.AMOUNT) --> NEW.AMOUNT
        WHERE PNO = �԰�� ��ǰ��ȣ(TB_PDETAIL.PNO) --> new.PNO
        
        * ��ǰ�� ���� ��� => �ش� ��ǰ�� ã�Ƽ� ������ ���� 
       UPDATE ���� 
        UPDATE TB_PRODUCT
        SET STOCK = STOCK - �԰����(TB_PDETAIL.AMOUNT) --> NEW.AMOUNT
        WHERE PNO = �԰�� ��ǰ��ȣ(TB_PDETAIL.PNO) --> new.PNO
*/

UPDATE TB_PRODUCT
SET STOCK = STOCK + NEW.AMOUNT
WHERE PNO = NEW.PNO;

UPDATE TB_PRODUCT
SET STOCK = STOCK - NEW.AMOUNT
WHERE PNO = NEW.PNO;

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PDETAIL
BEGIN
DBMS_OUTPUT.PUT_LINE('��ǰ ���� ����');
END;
/



INSERT INTO tb_pdetail VALUES(SEQ_DNO.NEXTVAL, 200, DEFAULT, 10, '�԰�');



 
    
 





