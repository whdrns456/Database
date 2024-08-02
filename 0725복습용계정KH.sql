-- 다음 사용자 계정 접속 후 아래 내용을 작성해주세요.
-- ID/PW  :  C##TESTUSER / 1234

-- 아래 내용을 추가하기 위한 테이블을 생성해주세요.
-- 각 컬럼별 설명을 추가해주세요.
--=========================================================
/*
	- 학생 정보 테이블 : STUDENT
	- 제약 조건
	  - 학생 이름, 생년월일은 NULL값을 허용하지 않는다.
	  - 이메일은 중복을 허용하지 않는다.
	- 저장 데이터
		+ 학생 번호 ex) 1, 2, 3, ...
		+ 학생 이름 ex) '김말똥', '아무개', ...
		+ 이메일    ex) 'kim12@kh.or.kr', 'dogdog@kh.or.kr', ...
		+ 생년월일  ex) '24/07/25', '00/02/20', '88/12/25', ...
*/

------------------------------------------------------------
/*
	- 도서 정보 테이블 : BOOK
	- 제약 조건
	  - 제목과 저자명은 NULL값을 허용하지 않는다.
	  - ISBN 번호는 중복을 허용하지 않는다.
	- 저장 데이터
	  + 도서 번호 ex) 1, 2, 3, ...
	  + 제목 ex) '삼국지', '어린왕자', '코스모스', ...
	  + 저자 ex) '지연', '생텍쥐페리', '칼 세이건', ...
	  + 출판일 ex) '14/02/14', '22/09/19', ...
	  + ISBN번호 ex) '9780394502946', '9780152048044', ...
*/

------------------------------------------------------------


CREATE TABLE STUDENT(

    ST_NO NUMBER ,
    ST_NAME VARCHAR2(100) NOT NULL,
    ST_EMAIL VARCHAR2(100) UNIQUE ,
    ST_BIRTH DATE NOT NULL   
);

COMMENT ON COLUMN STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN STUDENT.ST_NAME IS '학생 이름';
COMMENT ON COLUMN STUDENT.ST_EMAIL IS '이메일';
COMMENT ON COLUMN STUDENT.ST_BIRTH IS '생년월일';

INSERT INTO STUDENT
     VALUES(1, '기다운', 'KIDAWUN@KH.OR.KR', '95/04/01');
    
INSERT INTO STUDENT
     VALUES(2, NULL, 'INCHANG@.OR.KR', NULL); --> ST_NAME 컬럼에 NOT NULL 제약에 위배됨
     

INSERT INTO STUDENT
     VALUES(3, '조건웅', 'KIDAWUN@.OR.KR', '99/09/28');
--> EMAIL 컬럼이 제약에 위배됨


/*
	- 도서 정보 테이블 : BOOK
	- 제약 조건
	  - 제목과 저자명은 NULL값을 허용하지 않는다.
	  - ISBN 번호는 중복을 허용하지 않는다.
	- 저장 데이터
	  + 도서 번호 ex) 1, 2, 3, ...
	  + 제목 ex) '삼국지', '어린왕자', '코스모스', ...
	  + 저자 ex) '지연', '생텍쥐페리', '칼 세이건', ...
	  + 출판일 ex) '14/02/14', '22/09/19', ...
	  + ISBN번호 ex) '9780394502946', '9780152048044', ...
*/


CREATE TABLE BOOK(
    
    BK_NO NUMBER,
    BK_TITLE VARCHAR2(100) NOT NULL,
    BK_AUSHOR VARCHAR2(15) NOT NULL,
    PUB_DATE DATE,
    ISBN VARCHAR2(20) UNIQUE
    
-- NOT NULL 테이블 레벨 방식: x 
);
COMMENT ON COLUMN BOOK.BK_NO IS '도서 번호';
COMMENT ON COLUMN BOOK.BK_TITLE IS '도서 제목';
COMMENT ON COLUMN BOOK.BK_AUSHOR IS '도서 제목';
COMMENT ON COLUMN BOOK.PUB_DATE IS '출판일';
COMMENT ON COLUMN BOOK.ISBN IS '일련번호';

INSERT INTO BOOK
     VALUES(1, '어린왕자', '생텍쥐페이', '24/07/25', '9780394502946');


INSERT INTO BOOK
     VALUES(2, '어린왕자', '생텍쥐페이', '24/07/25', '9780394502946');

-- COMMIT; 데이터 저장 
-- ROLLBACK; 데이터 저장하지 않음


/*
    *CHECK(조건식) : 해당 컬럼에 저장할 수 있는 값에 대한 조건 제시 
                    조건에 만족하는 값만을 저장할 수 있음 
            = > 정해진 값만을 저장하고자 할떄 사용 
*/
-- 성별에 대한 컬럼에 데이터 저장 시 '남'/'여' 값만을 저장 
CREATE TABLE MEMBER_CHECK (
    
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    JOIN_DATE DATE,
    
    UNIQUE(MEM_ID)
    
    -- CHECK(GENDER IN ('남','여'))
    

);




