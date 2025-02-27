-- 회원 정보를 저장할 테이블 : MEMBER 
/*
    -- 추상화 작업, 
    -회원번호        :숫자(NUMBER) 
    -회원아이디       :문자 (VARCHAR2(20))
    -회원비밀번호     :문자 (VARCHAR2(20))
    -회원이름         :문자 문자 (VARCHAR2(20))
    -성별            : 문자 (CHAR(3)) 남/여 
    -연락처          : 문자 - CHAR(13)
    -이메일          : 문자 - (VARCHAR2(50))
    -가입일           : 날짜- (DATE)
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

-- MEMBER 테이블 정보 조회 
SELECT * FROM MEMBER;
--------------------------------------------------------------------------------
/*
    컬럼에 설명 추가하기 
    
    COMMENT ON COLUMN 테이블명.컬럼명 IS '설명내용';
    * 잘못 작성했을 경우 다시 작성 후 실해 = > 덮어씌어짐

*/
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.GENDER IS '성별';
COMMENT ON COLUMN MEMBER.PHONE IS '연락처';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.JOIN_DATE IS '가입일';

-- 테이블 삭제하기 : DROP TABLE 테이블명; 
--DROP TABLE MEMBER;


-- 테이블에 데이터 추가하기 : INSERT IN TO 테이블명 VALUSE(값,값,값, .....)
INSERT INTO MEMBER VALUES(1, 'whdrns','1234','최종군','남','010-2725-0780','whdrns456@naver.com',sysdate);
SELECT * FROM member;
INSERT INTO MEMBER VALUES(2, 'DAWUN','1234','기다운','남','NULL','NULL',sysdate);
INSERT INTO MEMBER VALUES(NULL, 'DAWUN','NULL','NULL','NULL','NULL','NULL',NULL);

COMMIT;
--------------------------------------------------------------------------------

/*
    제약조건 : 원하는 데이터값만 유지하기 위해서 특정 컬럼에 설정하는 제약
             데이터 무결성을 보장하기 위한 목적!
             
    * 설정 방식 : 컬럼레벨방식/ 테이블레벨방식
    
    * 종류 : NOT NULL, UNIAUE, CHECK, PRIMARY KEY, FOREIGN KEY     
    
    
*/


/*
    * NOT NULL 제약 조건
    : 해당 컬럼에 반드시 값이 존재해야하는 경우 설정하는 제약 
        = > 절대로 NULL값이 저장되면 안되는 경우 
    
    * 데이터 추가(삽입)/수정 시 NULL값을 허용하지 않음! 
    => 컬럼 레벨 방식으로만 설정 가능 
*/

-- NOT NULL 조건을 추가한 회원 테이블 : MEMBER_NOTNULL 

-- 회원 번호, 아이디, 비밀번호, 이름에 대한 데이터는 NULL값을 저장하지 않겠다!
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
    VALUES(1, 'DAWUN','1234','기다운','남','010-1234-1234','DAWUNI@GMAIL.COM',sysdate);
    
INSERT INTO MEMBER_NOTNULL
    VALUES(2, 'QWER','1234','QWER','여','NULL','NULL',NULL);

INSERT INTO MEMBER_NOTNULL
    VALUES(3, NULL,'1234','QQQ','남','NULL','NULL',NULL);
--> 설정한 대로 회원아이디 부분에 데이터가 NULL값이라서 오류가 발생! (제약조건이 위배됨)

INSERT INTO MEMBER_NOTNULL
    VALUES(1, 'DAWUN','1234','기다운','남','010-1234-1234','DAWUNI@GMAIL.COM',sysdate);

-- 중복되는 데이터가 있음에도 추가가 잘 되었다....(곤란하다)

/*
    * UNIQUE 제약 조건 
    : 해당 컬럼에 중복된 값이 있을 경우 제한하는 제약 조건 
    
    * 데이터 추가(삽입)/수정 시 기존에 있는 데이터 값 중에 중복되는 값이 있을 경우 오류 발생!    
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

    -- , UNIQUE(MEM_ID) -- 테이블 레벨 방식
  , CONSTRAINT MEMID_UQ UNIQUE (MEM_ID)  
);




INSERT INTO MEMBER 


SELECT * FROM member_unique;

INSERT INTO MEMBER_UNIQUE
    VALUES(1, 'KIDAWUN','1234','기다운','남','010-1234-1234','DAWUNI@GMAIL.COM',sysdate);

INSERT INTO MEMBER_UNIQUE
    VALUES(2, 'KIDAWUN','9999','다우니','여',NULL,NULL,NULL);
--UNIQUE 제약 조건에 위배되어 데이터 추가 실패! 
-- 오류 내용에 제약조건명으로 알려줌(알아보기가 어렵다...)
-- 제약 조건 설정 시 제약조건명을 지정하지 않으면 시스템에서 알아서 이름을 부여함 

/*
    제약 조건명 설정하기 
    
    * 컬럼 레벨 방식 
        CREATE TABLE 테이블명(
        컬럼명 자료형 [CONSTRAINT 제약조건명] 제약조건
        );
        
    * 테이블 레벨 방식 
        
        CREATE TABLE 테이블명(
        
        컬럼명 자료형,
        컬럼명 자료형,
       
       
        ex)  -- , UNIQUE(MEM_ID) 
        [CONSTRAINT 제약조건명] 제약조건(컬럼명)
        
        );     
*/

-- MEMBER_UNIQUE 테이블 삭제 
DROP TABLE MEMBER_UNIQUE;


INSERT INTO member_unique
    VALUES(1, 'DAWUNI', '1234', '기다운','남','010-1234-1234','KIDAWUN@GMAIL.COM', sysdate);

INSERT INTO MEMBER
    VALUES(2, 'QWER', '1234', 'QWER','여',NULL,NULL, NULL);

SELECT * FROM member_unique;

INSERT INTO MEMBER
    VALUES(3, NULL, NULL, NULL,NULL,NULL,NULL, NULL);

INSERT INTO MEMBER
    VALUES(4, 'DAWUNI', '1234', '다우니','여',NULL,NULL, NULL);

------------------------------------------------------------------------------

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
SELECT * FROM MEMBER_CHECK;


INSERT INTO MEMBER_CHECK
    VALUES(1, 'HONG','1234','홍길동','남',NULL,NULL,SYSDATE);
    
    
INSERT INTO MEMBER_CHECK
    VALUES(2, 'wan00','1234','허완','qqq',NULL,NULL,null);
-- CHECK 조건에 위배 성별 

INSERT INTO MEMBER_CHECK
    VALUES(2, 'wan00','1234','허완','남',NULL,NULL,null);
    
INSERT INTO MEMBER_CHECK
    VALUES(3, 'seoun','1234','최서은',NULL,NULL,NULL,SYSDATE);
    
--> 성별 컬럼에 NULL값을 저장했음 
--> NULL 값이 없다는 뜻이기 때문에 저장이 가능!
--> NULL값을 허용하지 않고자 한다면 NOT NULL 제약 조건을 추가해야함!

/*
    * PRIMARY KEY(기본키)
    : 테이블에서 각 행을 식별하기 위해 사용되는 컬럼에 부여하는 제약조건 
    
    ex) 회원번호, 학원, 제품코드, 주문번호, 예약번호, 군번, ......
    
    
    PRIMARY KEY = > NOT NULL + UNIQUE 
    
    * 주의할 점 : 테이블 당 오직 한 개만 설정 가능!
*/

CREATE TABLE MEMBER_PRI(
    
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    JOIN_DATE DATE,
    
    UNIQUE(MEM_ID)
);
INSERT INTO MEMBER_PRI
    VALUES(1, 'jy999','1234','최재영','남',NULL,NULL,sysdate);
    
    
INSERT INTO MEMBER_PRI
    VALUES(2, 'ys333','1234','이요셉','남',NULL,NULL,sysdate);
-- 기본키(mem_no)에 중복된 값을 저장하려고 할 때 제약 조건 위배됨(UNOQUE)

INSERT INTO MEMBER_PRI
    VALUES(null, 'ey777','1234','정은유','남',NULL,NULL,sysdate);
-- 기본키(MEM_NO)에 NULL값을 저장하려고 할 때 제약 조건 위배됨!(=> NOT NULL 제약조전 위배)
SELECT * FROM MEMBER_PRI;

--------------------------------------------------------------------------------

-- 회원번호(MEM_NO), 회원아이디(MEM_ID)를 기본키로 가지는 테이블 생성

    
    CREATE TABLE MEMBER_PRI2(
    
    MEM_NO NUMBER ,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    JOIN_DATE DATE,
    
    UNIQUE(MEM_ID),
    CONSTRAINT  MEMPRI2_PK PRIMARY KEY(MEM_NO, MEM_ID)    
);

--> 복합키 : 두개의 컬럼을 동시에 하나의 기본키로 지정하는 것 


INSERT INTO MEMBER_PRI2 VALUES(1, 'JG555','1234','최종군','남',NULL,NULL,SYSDATE );
INSERT INTO MEMBER_PRI2 VALUES(1, 'HY666','1234','엄희윤','남',NULL,NULL,SYSDATE );
--> 회원번호는 동일 하난 회원아이디 값이 다르기 때문에 추가가 됨!

SELECT * FROM MEMBER_PRI2;

DROP TABLE MEMBER_PRI2




-- 어떤 회원이 제품을 장바구니에 담는 정보를 저장하는 테이블 
CREATE TABLE MEMBER_LIKE(
    
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(50),
    LIKE_DATE DATE, 
    
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);

INSERT INTO MEMBER_LIKE
    VALUES(1, '라디오', '24/07/24');
    
INSERT INTO MEMBER_LIKE
    VALUES(1, '아메리카노', '24/07/25');
        
INSERT INTO MEMBER_LIKE
    VALUES(2, '고양이 사료', '24/07/14');
    
INSERT INTO MEMBER_LIKE
    VALUES(2, '고양이 모래', '24/07/14');

INSERT INTO MEMBER_LIKE
    VALUES(2, '아메리카노', '24/07/25'); 


INSERT INTO MEMBER_LIKE
    VALUES(3, '삼계탕', '24/07/25');     
    
SELECT * FROM  MEMBER_LIKE;



SELECT MEM_NAME, PRODUCT_NAME
FROM MEMBER_PRI2 M
    JOIN MEMBER_LIKE L USING (MEM_NO);
    
/*
    * FOREIGN KEY (외래키) *
    : 다른 테이블에 존재하는 값을 저장하고자 할 때 사용되는 제약조건 
    - > 다른 테이블을 참조한다. 
    - > 주로 외래키를 통해 테이블간의 관계가 형성된다. 
    
    - 컬럼 레벨 방식 : 
    * 컬럼명 자료형 REPERENCES 참조할 테이블명(참조할 컬럼명)
      생략 시 기본키 
    
    - 테이블 레벨 방식 
      FOREIGN KEY (컬럼명) REPERRENCES 참조할 테이블명[참조할 컬럼명]
      
      => 참조할 컬럼명을 생략할 경우 참조하는 테이블의 기본키 컬럼이 매칭됨
*/
-- MEMBER 테이블 삭제 
DROP TABLE MEMBER;

-- 회원 등급 정보를 저장할 테이블 
CREATE TABLE MEMBER_GRADE(
    GRADE_NO NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO MEMBER_GRADE VALUES(100, '일반회원');
INSERT INTO MEMBER_GRADE VALUES(200, 'VIP회원');
INSERT INTO MEMBER_GRADE VALUES(300, 'VVIP회원');

SELECT * FROM MEMBER_GRADE;

CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    JOIN_DATE DATE,
    MEM_GRADEID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) -- 컬럼 레벨 방식 
    
   --  , FOREIGN KEY(MEM_GRADEID)  REFERENCES MEMBER_GRADE(GRADE_NO) 테이블 레벨 방식         
);

INSERT INTO MEMBER
    VALUES(1, 'whdrns456', '0780', '최종군','남',sysdate, 100);
INSERT INTO MEMBER
    VALUES(2, 'jgw0928', '1234', '조건웅','남',sysdate, 200);    
INSERT INTO MEMBER
    VALUES(3, 'HH00', 'QWER', '임현호','남',sysdate, null);    
--> 외래키로 설정된 컬럼에는 기본적으로 NULL값은 저장 가능!


INSERT INTO MEMBER
    VALUES(4, 'jw33', '0987', '이주원','남',sysdate, 400);    
-- 오류 발생! "부모키를 찾을 수 없다 " --> 회원등급 테이블에 저장되지 않은 값을 사용 
-- MEMBER_GRADE (부모테이블) -|----------------------<- MEMBER(자식테이블)
-- 1 : N 관계 1 (부모테이블 - MEMBER_GRADE), N (자식테이블 : MEMBER)


  

INSERT INTO MEMBER
    VALUES(4, 'jw33', '0987', '이주원','남',sysdate, 100);   

select * from memBER_GRADE;
select * from memBER;


--> 부모테이블에서 데이터를 하나 삭제해본다면...?
-- 데이터 삭제 : DELETE FROM 테이블명 WHERE 조건; 

-- MEMBER_GRADE 테이블에서 100번에 해당하는 등급데이터 삭제 


DELETE FROM MEMBER_GRADE 
WHERE GRADE_NO = 100;
-- ORA-02292: 무결성 제약조건(C##KH.SYS_C008466)이 위배되었습니다- 자식 레코드가 발견되었습니다
--> 자식테이블(MEMBER)에서 100이라는 값을 사용하고 있기 때문에 삭제 불가! 

DELETE FROM MEMBER_GRADE
WHERE GRADE_NO = 300;
--> 자식테이블(MEMBER)에서 300이라는 값은 사용하지 않았기 때문에 삭제 가능! 

-- * 자식테이블에서 이미 사용하고 있는 값이 있을 경우 
--      부모테이블로부터 무조건 삭제가 되지 않는 "삭제옵션"이 있음!

ROLLBACK; -- 데이터 변경사항을 원래대로 돌려놓는 거 
--------------------------------------------------------------------------------

/*
    * 외래키 제약 조건 삭제 옵션 
    : 부모테이블의 데이터 삭제 시 해당 데이터를 사용하고 있는 자식테이블의 값을 
        어떻게 할 것인지에 대한 옵션 
        
        -(기본값) ON DELETE RESTRICTED : 자식데이터로부터 사용중인 값이 있으면 
        부모테이블에서 데이터 삭제 불가
    
    - ON DELETE SET NULL : 부모테이블에 있는 데이터 삭제 시 해당 데이터를 사용 중인 
    자식 테이블의 값을 NULL로 바꿔준다. 
    
    - ON DELETE CASCADE : 부모테이블에 있는 데이터 삭제 시 해당 데이터를 사용 중인 
    자식 테이블의 값도 삭제 
*/
-- MEMBER 테이블 삭제 
DROP TABLE MEMBER;


CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    JOIN_DATE DATE,
    MEM_GRADEID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE SET NULL-- 컬럼 레벨 방식     
);


INSERT INTO MEMBER VALUES(1, 'whdrns456', '0780', '최종군','남',sysdate, 100);
INSERT INTO MEMBER VALUES(2, 'jgw0928', '1234', '조건웅','남',sysdate, 200);    
INSERT INTO MEMBER VALUES(3, 'HH00', 'QWER', '임현호','남',sysdate, null);    

SELECT * FROM MEMBER; 

-- 100번 등급에 대한 데이터 삭제(MEMBER_GRADE)
DELETE FROM MEMBER_GRADE
WHERE GRADE_NO = 100;

--> 자식테이블(MEMBER)에서 100번 등급이 사용된 데이터가 NULL로 변경되면서 
-- 부모테이블(MEMBER_GRADE)에서는 데이터가 잘 삭제 됨 

ROLLBACK;

DROP TABLE MEMBER;

CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    JOIN_DATE DATE,
    MEM_GRADEID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE CASCADE -- 컬럼 레벨 방식     
);

INSERT INTO MEMBER VALUES(1, 'whdrns456', '0780', '최종군','남',sysdate, 100);
INSERT INTO MEMBER VALUES(2, 'jgw0928', '1234', '조건웅','남',sysdate, 200);    
INSERT INTO MEMBER VALUES(3, 'HH00', 'QWER', '임현호','남',sysdate, null);    

SELECT * FROM MEMBER; 

DELETE FROM MEMBER_GRADE
WHERE GRADE_NO = 100;
--> 자식테이블에서 100번이 사용된 행(데이터) 자체가 삭제되었음!

/*
 * DEFAULT 
    : 제약조건은 아님...
        컬럼을 선정하지 않고 데이터 추가 시 NULL값이 아닌 기본적인 값을 저장하고자 할 때
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER(
    
    MEM_NO NUMBER PRIMARY KEY,-- 회원 번호 
    MEM_NAME VARCHAR2(20),
    AGE NUMBER, 
    HOBBY VARCHAR2(20),
    JOIN_DATE DATE DEFAULT SYSDATE
    -- 취미 
    -- 가입일 
);

INSERT INTO MEMBER VALUES(1, '짱구',5,'엉덩이춤','24/0701');
INSERT INTO MEMBER VALUES(2, '맹구',5,'코하기',null);
INSERT INTO MEMBER VALUES(3, '훈발놈',5,null,null);

SELECT *FROM MEMBER;

INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(4,'유리');
-- 지정하지 않은 컬럼에 대한 값은 기본적으로 NULL값이 저장된다. 
--> 단 해당 컬럼에 기본값이 설정되어 있으면 NULL이 아닌 기본값으로 저장됨 
--==============================================================================

-- TABLE 복제 
CREATE TABLE MEMBER_COPY 
AS (SELECT * FROM MEMBER);

SELECT * FROM MEMBER_COpY;
--------------------------------------------------------------------------------
/*
    * ALTER TABLE : 테이블에 변경사항을 적용하고자 할 때 사용 
    
    ALTER TABLE 테이블명 변경할 내용 
    
    - NOT NULL : ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL;
    
    - UNIQUE : ALTER TABLE 테이블명 ADD UNIQUE(컬럼명);
    - CHECK : ALTER TABLE 테이블명 ADD CHECK(컬럼에 대한 조건식);
    - PRIMARY KEY : ALTER TABLE 테이블명 ADD PRIMARY KEY(컬럼명);
    - FOREIGN KEY : ALTER TABLE 테이블명 ADD FOREIGN KEY(컬럼명) REFERNECES 참조할 테이블명[참조할 컬럼명]
    
    ---
    - DEFAULT 옵션 : ALTER TABLE 테이블명 MODIFY 컬럼명 DEFAULT 기본값
    
*/
-- MEMBER_COPY 테이블의 회원번호(MEM_NO) 컬럼에 기본키 설정 

ALTER TABLE MEMBER_COPY ADD PRIMARY KEY(MEM_NO);

-- EMPLOYEE 테이블에서 부서코드(DEPT_CODE) 컬럼에 외래키 지정 - DEPARTMENT테이블 DEPT_ID 
-- EMPLOYEE 테이블에서 직급코드(JOB_CODE) 컬럼에 외래키 지정 - > JOB 테이블의 JOB_CODE (기본키)


ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT;
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB;
-- PRIMARY KEY : ALTER TABLE 테이블명 ADD PRIMARY KEY(컬럼명);
-- FOREIGN KEY : ALTER TABLE 테이블명 ADD FOREIGN KEY(컬럼명) REFERNECES 참조할 테이블명[참조할 컬럼명]








    