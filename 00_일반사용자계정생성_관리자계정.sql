-- ���� �ּ� 
/*
    ������ �ּ� 
*/

SELECT * FROM DBA_USERS; -- ���� ��� �����鿡 ���Ͽ� ��ɹ� 
-- ��ɹ� ���� : �ʷϻ� �����ư Ŭ�� �Ǵ� Ctrl + Enter 

-- �Ϲ� ����� ���� �������� (������ �������θ� ����!)
-- [ǥ����] (DML) CREATE USER ������ IDENTIFIED BY ��й�ȣ;
CREATE USER "C##KH" IDENTIFIED BY KH;

 -- ������ ����� ������ �ּ��� ���� (������ ����, ����)�ο� 
 -- [ǥ����] GRANT ����1, ����2, ....TO ������; 
 GRANT CONNECT, RESOURCE TO "C##KH";
 
 -- ���̺� �����̽� ���� ���� 
 ALTER USER "C##KH" DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

 -- ����� ���� 
 
 
 


