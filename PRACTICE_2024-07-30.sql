-- * QUIZ1 * --------
/*
	CREATE USER C##TEST IDENTIFIED BY 1234; ����
	User C##TEST��(��) �����Ǿ����ϴ�.
	���� ������ �ϰ� ���� �� ���� (user C##TEST lacks CREATE SESSION privillege; logon denied ����)
*/

-- ���� ?
CREATE USER C##TEST IDENTIFIED BY 1234;
-- �ذ��� ?
-- ��й�ȣ�� ������ �ߴ� ����� �� ������ ������ �ϱ� ���ؼ��� ������ �������� 
-- ������ �־���Ѵ� GRANT CONNECT, RESOURCE TO "TO ������"
-- �ּ����� ���� CONNECT, RESOURCE 

-- CREATE SESSION ������ �ο������ ��

-- ���̺� �����̽� ���� ������ ���־���Ѵ� 
-- ALTER USER "C##KH" DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;


-- * QUIZ2 * --------
CREATE TABLE TB_JOB (
	JOBCODE NUMBER PRIMARY KEY,
    -- ����� �����ϱ� ���� �ĺ��� ������ �� 
	JOBNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE TB_EMP (
	EMPNO NUMBER PRIMARY KEY,
	EMPNAME VARCHAR2(10) NOT NULL,
	JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);
/*
	���� �� ���̺��� �����Ͽ� EMPNO, EMPNAME, JOBNO, JOBNAME �÷��� ��ȸ�ϰ��� �Ѵ�.
	�̶� ������ SQL���� �Ʒ��� ���ٰ� ���� ��,
*/

SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
	JOIN TB_JOB USING(JOBNO);
-- ������ ���� ������ �߻��ߴ�.
-- ORA-00904: "TB_JOB"."JOBNO": invalid identifier

-- ���� ?
-- USING�� ���� �̸��� �÷��� ���ؼ� ������ �ϰ��� �� �� ����ϴ� �����̴�  
-- �����ϰ��� �ϴ� �� ���̺��� ����� �ϴ� ������ �ϴ� �÷����� �ٸ��Ƿ� 
-- using�� ����� �� ���� ON���� ������ ����� �Ѵ�.

-- �ذ��� ?
-- ON�� ���ؼ�( JOBCODE = JOBNO)���� ������ �õ����ش�.
-- �⺻Ű ����Ű 

 



