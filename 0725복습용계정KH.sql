-- ���� ����� ���� ���� �� �Ʒ� ������ �ۼ����ּ���.
-- ID/PW  :  C##TESTUSER / 1234

-- �Ʒ� ������ �߰��ϱ� ���� ���̺��� �������ּ���.
-- �� �÷��� ������ �߰����ּ���.
--=========================================================
/*
	- �л� ���� ���̺� : STUDENT
	- ���� ����
	  - �л� �̸�, ��������� NULL���� ������� �ʴ´�.
	  - �̸����� �ߺ��� ������� �ʴ´�.
	- ���� ������
		+ �л� ��ȣ ex) 1, 2, 3, ...
		+ �л� �̸� ex) '�踻��', '�ƹ���', ...
		+ �̸���    ex) 'kim12@kh.or.kr', 'dogdog@kh.or.kr', ...
		+ �������  ex) '24/07/25', '00/02/20', '88/12/25', ...
*/

------------------------------------------------------------
/*
	- ���� ���� ���̺� : BOOK
	- ���� ����
	  - ����� ���ڸ��� NULL���� ������� �ʴ´�.
	  - ISBN ��ȣ�� �ߺ��� ������� �ʴ´�.
	- ���� ������
	  + ���� ��ȣ ex) 1, 2, 3, ...
	  + ���� ex) '�ﱹ��', '�����', '�ڽ���', ...
	  + ���� ex) '����', '�������丮', 'Į ���̰�', ...
	  + ������ ex) '14/02/14', '22/09/19', ...
	  + ISBN��ȣ ex) '9780394502946', '9780152048044', ...
*/

------------------------------------------------------------


CREATE TABLE STUDENT(

    ST_NO NUMBER ,
    ST_NAME VARCHAR2(100) NOT NULL,
    ST_EMAIL VARCHAR2(100) UNIQUE ,
    ST_BIRTH DATE NOT NULL   
);

COMMENT ON COLUMN STUDENT.ST_NO IS '�л� ��ȣ';
COMMENT ON COLUMN STUDENT.ST_NAME IS '�л� �̸�';
COMMENT ON COLUMN STUDENT.ST_EMAIL IS '�̸���';
COMMENT ON COLUMN STUDENT.ST_BIRTH IS '�������';

INSERT INTO STUDENT
     VALUES(1, '��ٿ�', 'KIDAWUN@KH.OR.KR', '95/04/01');
    
INSERT INTO STUDENT
     VALUES(2, NULL, 'INCHANG@.OR.KR', NULL); --> ST_NAME �÷��� NOT NULL ���࿡ �����
     

INSERT INTO STUDENT
     VALUES(3, '���ǿ�', 'KIDAWUN@.OR.KR', '99/09/28');
--> EMAIL �÷��� ���࿡ �����


/*
	- ���� ���� ���̺� : BOOK
	- ���� ����
	  - ����� ���ڸ��� NULL���� ������� �ʴ´�.
	  - ISBN ��ȣ�� �ߺ��� ������� �ʴ´�.
	- ���� ������
	  + ���� ��ȣ ex) 1, 2, 3, ...
	  + ���� ex) '�ﱹ��', '�����', '�ڽ���', ...
	  + ���� ex) '����', '�������丮', 'Į ���̰�', ...
	  + ������ ex) '14/02/14', '22/09/19', ...
	  + ISBN��ȣ ex) '9780394502946', '9780152048044', ...
*/


CREATE TABLE BOOK(
    
    BK_NO NUMBER,
    BK_TITLE VARCHAR2(100) NOT NULL,
    BK_AUSHOR VARCHAR2(15) NOT NULL,
    PUB_DATE DATE,
    ISBN VARCHAR2(20) UNIQUE
    
-- NOT NULL ���̺� ���� ���: x 
);
COMMENT ON COLUMN BOOK.BK_NO IS '���� ��ȣ';
COMMENT ON COLUMN BOOK.BK_TITLE IS '���� ����';
COMMENT ON COLUMN BOOK.BK_AUSHOR IS '���� ����';
COMMENT ON COLUMN BOOK.PUB_DATE IS '������';
COMMENT ON COLUMN BOOK.ISBN IS '�Ϸù�ȣ';

INSERT INTO BOOK
     VALUES(1, '�����', '����������', '24/07/25', '9780394502946');


INSERT INTO BOOK
     VALUES(2, '�����', '����������', '24/07/25', '9780394502946');

-- COMMIT; ������ ���� 
-- ROLLBACK; ������ �������� ����


/*
    *CHECK(���ǽ�) : �ش� �÷��� ������ �� �ִ� ���� ���� ���� ���� 
                    ���ǿ� �����ϴ� ������ ������ �� ���� 
            = > ������ ������ �����ϰ��� �ҋ� ��� 
*/
-- ������ ���� �÷��� ������ ���� �� '��'/'��' ������ ���� 
CREATE TABLE MEMBER_CHECK (
    
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    JOIN_DATE DATE,
    
    UNIQUE(MEM_ID)
    
    -- CHECK(GENDER IN ('��','��'))
    

);




