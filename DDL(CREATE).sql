-- ȸ�� ������ ������ ���̺� : MEMBER 
/*
    -- �߻�ȭ �۾�, 
    -ȸ����ȣ        :����(NUMBER) 
    -ȸ�����̵�       :���� (VARCHAR2(20))
    -ȸ����й�ȣ     :���� (VARCHAR2(20))
    -ȸ���̸�         :���� ���� (VARCHAR2(20))
    -����            : ���� (CHAR(3)) ��/�� 
    -����ó          : ���� - CHAR(13)
    -�̸���          : ���� - (VARCHAR2(50))
    -������           : ��¥- (DATE)
*/


CREATE TABLE MEMBER (
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    JOIN_DATE DATE
);

-- MEMBER ���̺� ���� ��ȸ 
SELECT * FROM MEMBER;
--------------------------------------------------------------------------------
/*
    �÷��� ���� �߰��ϱ� 
    
    COMMENT ON COLUMN ���̺��.�÷��� IS '������';
    * �߸� �ۼ����� ��� �ٽ� �ۼ� �� ���� = > �������

*/
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.GENDER IS '����';
COMMENT ON COLUMN MEMBER.PHONE IS '����ó';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.JOIN_DATE IS '������';

-- ���̺� �����ϱ� : DROP TABLE ���̺��; 
--DROP TABLE MEMBER;


-- ���̺� ������ �߰��ϱ� : INSERT IN TO ���̺�� VALUSE(��,��,��, .....)
INSERT INTO MEMBER VALUES(1, 'whdrns','1234','������','��','010-2725-0780','whdrns456@naver.com',sysdate);
SELECT * FROM member;
INSERT INTO MEMBER VALUES(2, 'DAWUN','1234','��ٿ�','��','NULL','NULL',sysdate);
INSERT INTO MEMBER VALUES(NULL, 'DAWUN','NULL','NULL','NULL','NULL','NULL',NULL);

COMMIT;
--------------------------------------------------------------------------------

/*
    �������� : ���ϴ� �����Ͱ��� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
             ������ ���Ἲ�� �����ϱ� ���� ����!
             
    * ���� ��� : �÷��������/ ���̺������
    
    * ���� : NOT NULL, UNIAUE, CHECK, PRIMARY KEY, FOREIGN KEY     
    
    
*/


/*
    * NOT NULL ���� ����
    : �ش� �÷��� �ݵ�� ���� �����ؾ��ϴ� ��� �����ϴ� ���� 
        = > ����� NULL���� ����Ǹ� �ȵǴ� ��� 
    
    * ������ �߰�(����)/���� �� NULL���� ������� ����! 
    => �÷� ���� ������θ� ���� ���� 
*/

-- NOT NULL ������ �߰��� ȸ�� ���̺� : MEMBER_NOTNULL 

-- ȸ�� ��ȣ, ���̵�, ��й�ȣ, �̸��� ���� �����ʹ� NULL���� �������� �ʰڴ�!
CREATE TABLE MEMBER_NOTNULL (
        
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20)NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    JOIN_DATE DATE
);

SELECT * FROM MEMBER_NOTNULL;

INSERT INTO MEMBER_NOTNULL
    VALUES(1, 'DAWUN','1234','��ٿ�','��','010-1234-1234','DAWUNI@GMAIL.COM',sysdate);
    
INSERT INTO MEMBER_NOTNULL
    VALUES(2, 'QWER','1234','QWER','��','NULL','NULL',NULL);

INSERT INTO MEMBER_NOTNULL
    VALUES(3, NULL,'1234','QQQ','��','NULL','NULL',NULL);
--> ������ ��� ȸ�����̵� �κп� �����Ͱ� NULL���̶� ������ �߻�! (���������� �����)

INSERT INTO MEMBER_NOTNULL
    VALUES(1, 'DAWUN','1234','��ٿ�','��','010-1234-1234','DAWUNI@GMAIL.COM',sysdate);

-- �ߺ��Ǵ� �����Ͱ� �������� �߰��� �� �Ǿ���....(����ϴ�)

/*
    * UNIQUE ���� ���� 
    : �ش� �÷��� �ߺ��� ���� ���� ��� �����ϴ� ���� ���� 
    
    * ������ �߰�(����)/���� �� ������ �ִ� ������ �� �߿� �ߺ��Ǵ� ���� ���� ��� ���� �߻�!    
*/

CREATE TABLE MEMBER_UNIQUE(
    
    MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL ,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NT NOT NULL ,
    MEM_PWD VARCHAR2(20)CONSTRAINT MEMPWD_NT NOT NULL,
    MEM_NAME VARCHAR2(20)CONSTRAINT MEMNAME_NT NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    JOIN_DATE DATE

    -- , UNIQUE(MEM_ID) -- ���̺� ���� ���
  , CONSTRAINT MEMID_UQ UNIQUE (MEM_ID)  
);




INSERT INTO MEMBER 


SELECT * FROM member_unique;

INSERT INTO MEMBER_UNIQUE
    VALUES(1, 'KIDAWUN','1234','��ٿ�','��','010-1234-1234','DAWUNI@GMAIL.COM',sysdate);

INSERT INTO MEMBER_UNIQUE
    VALUES(2, 'KIDAWUN','9999','�ٿ��','��',NULL,NULL,NULL);
--UNIQUE ���� ���ǿ� ����Ǿ� ������ �߰� ����! 
-- ���� ���뿡 �������Ǹ����� �˷���(�˾ƺ��Ⱑ ��ƴ�...)
-- ���� ���� ���� �� �������Ǹ��� �������� ������ �ý��ۿ��� �˾Ƽ� �̸��� �ο��� 

/*
    ���� ���Ǹ� �����ϱ� 
    
    * �÷� ���� ��� 
        CREATE TABLE ���̺��(
        �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] ��������
        );
        
    * ���̺� ���� ��� 
        
        CREATE TABLE ���̺��(
        
        �÷��� �ڷ���,
        �÷��� �ڷ���,
       
       
        ex)  -- , UNIQUE(MEM_ID) 
        [CONSTRAINT �������Ǹ�] ��������(�÷���)
        
        );     
*/

-- MEMBER_UNIQUE ���̺� ���� 
DROP TABLE MEMBER_UNIQUE;


INSERT INTO member_unique
    VALUES(1, 'DAWUNI', '1234', '��ٿ�','��','010-1234-1234','KIDAWUN@GMAIL.COM', sysdate);

INSERT INTO MEMBER
    VALUES(2, 'QWER', '1234', 'QWER','��',NULL,NULL, NULL);

SELECT * FROM member_unique;

INSERT INTO MEMBER
    VALUES(3, NULL, NULL, NULL,NULL,NULL,NULL, NULL);

INSERT INTO MEMBER
    VALUES(4, 'DAWUNI', '1234', '�ٿ��','��',NULL,NULL, NULL);

------------------------------------------------------------------------------

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
SELECT * FROM MEMBER_CHECK;


INSERT INTO MEMBER_CHECK
    VALUES(1, 'HONG','1234','ȫ�浿','��',NULL,NULL,SYSDATE);
    
    
INSERT INTO MEMBER_CHECK
    VALUES(2, 'wan00','1234','���','qqq',NULL,NULL,null);
-- CHECK ���ǿ� ���� ���� 

INSERT INTO MEMBER_CHECK
    VALUES(2, 'wan00','1234','���','��',NULL,NULL,null);
    
INSERT INTO MEMBER_CHECK
    VALUES(3, 'seoun','1234','�ּ���',NULL,NULL,NULL,SYSDATE);
    
--> ���� �÷��� NULL���� �������� 
--> NULL ���� ���ٴ� ���̱� ������ ������ ����!
--> NULL���� ������� �ʰ��� �Ѵٸ� NOT NULL ���� ������ �߰��ؾ���!

/*
    * PRIMARY KEY(�⺻Ű)
    : ���̺��� �� ���� �ĺ��ϱ� ���� ���Ǵ� �÷��� �ο��ϴ� �������� 
    
    ex) ȸ����ȣ, �п�, ��ǰ�ڵ�, �ֹ���ȣ, �����ȣ, ����, ......
    
    
    PRIMARY KEY = > NOT NULL + UNIQUE 
    
    * ������ �� : ���̺� �� ���� �� ���� ���� ����!
*/

CREATE TABLE MEMBER_PRI(
    
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    JOIN_DATE DATE,
    
    UNIQUE(MEM_ID)
);
INSERT INTO MEMBER_PRI
    VALUES(1, 'jy999','1234','���翵','��',NULL,NULL,sysdate);
    
    
INSERT INTO MEMBER_PRI
    VALUES(2, 'ys333','1234','�̿��','��',NULL,NULL,sysdate);
-- �⺻Ű(mem_no)�� �ߺ��� ���� �����Ϸ��� �� �� ���� ���� �����(UNOQUE)

INSERT INTO MEMBER_PRI
    VALUES(null, 'ey777','1234','������','��',NULL,NULL,sysdate);
-- �⺻Ű(MEM_NO)�� NULL���� �����Ϸ��� �� �� ���� ���� �����!(=> NOT NULL �������� ����)
SELECT * FROM MEMBER_PRI;

--------------------------------------------------------------------------------

-- ȸ����ȣ(MEM_NO), ȸ�����̵�(MEM_ID)�� �⺻Ű�� ������ ���̺� ����

    
    CREATE TABLE MEMBER_PRI2(
    
    MEM_NO NUMBER ,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    JOIN_DATE DATE,
    
    UNIQUE(MEM_ID),
    CONSTRAINT  MEMPRI2_PK PRIMARY KEY(MEM_NO, MEM_ID)    
);

--> ����Ű : �ΰ��� �÷��� ���ÿ� �ϳ��� �⺻Ű�� �����ϴ� �� 


INSERT INTO MEMBER_PRI2 VALUES(1, 'JG555','1234','������','��',NULL,NULL,SYSDATE );
INSERT INTO MEMBER_PRI2 VALUES(1, 'HY666','1234','������','��',NULL,NULL,SYSDATE );
--> ȸ����ȣ�� ���� �ϳ� ȸ�����̵� ���� �ٸ��� ������ �߰��� ��!

SELECT * FROM MEMBER_PRI2;

DROP TABLE MEMBER_PRI2




-- � ȸ���� ��ǰ�� ��ٱ��Ͽ� ��� ������ �����ϴ� ���̺� 
CREATE TABLE MEMBER_LIKE(
    
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(50),
    LIKE_DATE DATE, 
    
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);

INSERT INTO MEMBER_LIKE
    VALUES(1, '����', '24/07/24');
    
INSERT INTO MEMBER_LIKE
    VALUES(1, '�Ƹ޸�ī��', '24/07/25');
        
INSERT INTO MEMBER_LIKE
    VALUES(2, '����� ���', '24/07/14');
    
INSERT INTO MEMBER_LIKE
    VALUES(2, '����� ��', '24/07/14');

INSERT INTO MEMBER_LIKE
    VALUES(2, '�Ƹ޸�ī��', '24/07/25'); 


INSERT INTO MEMBER_LIKE
    VALUES(3, '�����', '24/07/25');     
    
SELECT * FROM  MEMBER_LIKE;



SELECT MEM_NAME, PRODUCT_NAME
FROM MEMBER_PRI2 M
    JOIN MEMBER_LIKE L USING (MEM_NO);
    
/*
    * FOREIGN KEY (�ܷ�Ű) *
    : �ٸ� ���̺� �����ϴ� ���� �����ϰ��� �� �� ���Ǵ� �������� 
    - > �ٸ� ���̺��� �����Ѵ�. 
    - > �ַ� �ܷ�Ű�� ���� ���̺��� ���谡 �����ȴ�. 
    
    - �÷� ���� ��� : 
    * �÷��� �ڷ��� REPERENCES ������ ���̺��(������ �÷���)
      ���� �� �⺻Ű 
    
    - ���̺� ���� ��� 
      FOREIGN KEY (�÷���) REPERRENCES ������ ���̺��[������ �÷���]
      
      => ������ �÷����� ������ ��� �����ϴ� ���̺��� �⺻Ű �÷��� ��Ī��
*/
-- MEMBER ���̺� ���� 
DROP TABLE MEMBER;

-- ȸ�� ��� ������ ������ ���̺� 
CREATE TABLE MEMBER_GRADE(
    GRADE_NO NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO MEMBER_GRADE VALUES(100, '�Ϲ�ȸ��');
INSERT INTO MEMBER_GRADE VALUES(200, 'VIPȸ��');
INSERT INTO MEMBER_GRADE VALUES(300, 'VVIPȸ��');

SELECT * FROM MEMBER_GRADE;

CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')),
    JOIN_DATE DATE,
    MEM_GRADEID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) -- �÷� ���� ��� 
    
   --  , FOREIGN KEY(MEM_GRADEID)  REFERENCES MEMBER_GRADE(GRADE_NO) ���̺� ���� ���         
);

INSERT INTO MEMBER
    VALUES(1, 'whdrns456', '0780', '������','��',sysdate, 100);
INSERT INTO MEMBER
    VALUES(2, 'jgw0928', '1234', '���ǿ�','��',sysdate, 200);    
INSERT INTO MEMBER
    VALUES(3, 'HH00', 'QWER', '����ȣ','��',sysdate, null);    
--> �ܷ�Ű�� ������ �÷����� �⺻������ NULL���� ���� ����!


INSERT INTO MEMBER
    VALUES(4, 'jw33', '0987', '���ֿ�','��',sysdate, 400);    
-- ���� �߻�! "�θ�Ű�� ã�� �� ���� " --> ȸ����� ���̺� ������� ���� ���� ��� 
-- MEMBER_GRADE (�θ����̺�) -|----------------------<- MEMBER(�ڽ����̺�)
-- 1 : N ���� 1 (�θ����̺� - MEMBER_GRADE), N (�ڽ����̺� : MEMBER)


  

INSERT INTO MEMBER
    VALUES(4, 'jw33', '0987', '���ֿ�','��',sysdate, 100);   

select * from memBER_GRADE;
select * from memBER;


--> �θ����̺��� �����͸� �ϳ� �����غ��ٸ�...?
-- ������ ���� : DELETE FROM ���̺�� WHERE ����; 

-- MEMBER_GRADE ���̺��� 100���� �ش��ϴ� ��޵����� ���� 


DELETE FROM MEMBER_GRADE 
WHERE GRADE_NO = 100;
-- ORA-02292: ���Ἲ ��������(C##KH.SYS_C008466)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�
--> �ڽ����̺�(MEMBER)���� 100�̶�� ���� ����ϰ� �ֱ� ������ ���� �Ұ�! 

DELETE FROM MEMBER_GRADE
WHERE GRADE_NO = 300;
--> �ڽ����̺�(MEMBER)���� 300�̶�� ���� ������� �ʾұ� ������ ���� ����! 

-- * �ڽ����̺��� �̹� ����ϰ� �ִ� ���� ���� ��� 
--      �θ����̺�κ��� ������ ������ ���� �ʴ� "�����ɼ�"�� ����!

ROLLBACK; -- ������ ��������� ������� �������� �� 
--------------------------------------------------------------------------------

/*
    * �ܷ�Ű ���� ���� ���� �ɼ� 
    : �θ����̺��� ������ ���� �� �ش� �����͸� ����ϰ� �ִ� �ڽ����̺��� ���� 
        ��� �� �������� ���� �ɼ� 
        
        -(�⺻��) ON DELETE RESTRICTED : �ڽĵ����ͷκ��� ������� ���� ������ 
        �θ����̺��� ������ ���� �Ұ�
    
    - ON DELETE SET NULL : �θ����̺� �ִ� ������ ���� �� �ش� �����͸� ��� ���� 
    �ڽ� ���̺��� ���� NULL�� �ٲ��ش�. 
    
    - ON DELETE CASCADE : �θ����̺� �ִ� ������ ���� �� �ش� �����͸� ��� ���� 
    �ڽ� ���̺��� ���� ���� 
*/
-- MEMBER ���̺� ���� 
DROP TABLE MEMBER;


CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')),
    JOIN_DATE DATE,
    MEM_GRADEID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE SET NULL-- �÷� ���� ���     
);


INSERT INTO MEMBER VALUES(1, 'whdrns456', '0780', '������','��',sysdate, 100);
INSERT INTO MEMBER VALUES(2, 'jgw0928', '1234', '���ǿ�','��',sysdate, 200);    
INSERT INTO MEMBER VALUES(3, 'HH00', 'QWER', '����ȣ','��',sysdate, null);    

SELECT * FROM MEMBER; 

-- 100�� ��޿� ���� ������ ����(MEMBER_GRADE)
DELETE FROM MEMBER_GRADE
WHERE GRADE_NO = 100;

--> �ڽ����̺�(MEMBER)���� 100�� ����� ���� �����Ͱ� NULL�� ����Ǹ鼭 
-- �θ����̺�(MEMBER_GRADE)������ �����Ͱ� �� ���� �� 

ROLLBACK;

DROP TABLE MEMBER;

CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')),
    JOIN_DATE DATE,
    MEM_GRADEID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE CASCADE -- �÷� ���� ���     
);

INSERT INTO MEMBER VALUES(1, 'whdrns456', '0780', '������','��',sysdate, 100);
INSERT INTO MEMBER VALUES(2, 'jgw0928', '1234', '���ǿ�','��',sysdate, 200);    
INSERT INTO MEMBER VALUES(3, 'HH00', 'QWER', '����ȣ','��',sysdate, null);    

SELECT * FROM MEMBER; 

DELETE FROM MEMBER_GRADE
WHERE GRADE_NO = 100;
--> �ڽ����̺��� 100���� ���� ��(������) ��ü�� �����Ǿ���!

/*
 * DEFAULT 
    : ���������� �ƴ�...
        �÷��� �������� �ʰ� ������ �߰� �� NULL���� �ƴ� �⺻���� ���� �����ϰ��� �� ��
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER(
    
    MEM_NO NUMBER PRIMARY KEY,-- ȸ�� ��ȣ 
    MEM_NAME VARCHAR2(20),
    AGE NUMBER, 
    HOBBY VARCHAR2(20),
    JOIN_DATE DATE DEFAULT SYSDATE
    -- ��� 
    -- ������ 
);

INSERT INTO MEMBER VALUES(1, '¯��',5,'��������','24/0701');
INSERT INTO MEMBER VALUES(2, '�ͱ�',5,'���ϱ�',null);
INSERT INTO MEMBER VALUES(3, '�ƹ߳�',5,null,null);

SELECT *FROM MEMBER;

INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(4,'����');
-- �������� ���� �÷��� ���� ���� �⺻������ NULL���� ����ȴ�. 
--> �� �ش� �÷��� �⺻���� �����Ǿ� ������ NULL�� �ƴ� �⺻������ ����� 
--==============================================================================

-- TABLE ���� 
CREATE TABLE MEMBER_COPY 
AS (SELECT * FROM MEMBER);

SELECT * FROM MEMBER_COpY;
--------------------------------------------------------------------------------
/*
    * ALTER TABLE : ���̺� ��������� �����ϰ��� �� �� ��� 
    
    ALTER TABLE ���̺�� ������ ���� 
    
    - NOT NULL : ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL;
    
    - UNIQUE : ALTER TABLE ���̺�� ADD UNIQUE(�÷���);
    - CHECK : ALTER TABLE ���̺�� ADD CHECK(�÷��� ���� ���ǽ�);
    - PRIMARY KEY : ALTER TABLE ���̺�� ADD PRIMARY KEY(�÷���);
    - FOREIGN KEY : ALTER TABLE ���̺�� ADD FOREIGN KEY(�÷���) REFERNECES ������ ���̺��[������ �÷���]
    
    ---
    - DEFAULT �ɼ� : ALTER TABLE ���̺�� MODIFY �÷��� DEFAULT �⺻��
    
*/
-- MEMBER_COPY ���̺��� ȸ����ȣ(MEM_NO) �÷��� �⺻Ű ���� 

ALTER TABLE MEMBER_COPY ADD PRIMARY KEY(MEM_NO);

-- EMPLOYEE ���̺��� �μ��ڵ�(DEPT_CODE) �÷��� �ܷ�Ű ���� - DEPARTMENT���̺� DEPT_ID 
-- EMPLOYEE ���̺��� �����ڵ�(JOB_CODE) �÷��� �ܷ�Ű ���� - > JOB ���̺��� JOB_CODE (�⺻Ű)


ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT;
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB;
-- PRIMARY KEY : ALTER TABLE ���̺�� ADD PRIMARY KEY(�÷���);
-- FOREIGN KEY : ALTER TABLE ���̺�� ADD FOREIGN KEY(�÷���) REFERNECES ������ ���̺��[������ �÷���]








    