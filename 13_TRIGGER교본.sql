/*
    * 트리거 (TRIGGER)
    : 지정한 테이블에 DML(INSERT, UPDATE, DELETE)문에 의해 변경사항이 있을 때 
    (테이블에 이벤트가 발생했을 때)
    자동으로 매번 실행할 내용을 미리 정의해두는 것 
    
    ex) 회원 탈퇴 시 기존 회원테이블에서 데이터 삭제(DELETE)하고 
        탈퇴 회원 테이블에 데이터 추가(INSERT)해야 할 때 자동으로 실행 
        
    ex) 신고 횟수가 특정 값을 넘어갔을 때 해당 회원을 블랙리스트 처리 
    
    ex) 입출고에 대한 데이터를 기록할 때 해당 상품이 재고 수량을 갱신해야 할 때
*/


/*
    * 트리거의 종류 *
    
    -SQL문의 실행 시기에 따른 분류
     *BEFORE TRIGGER : 지정한 테이블에 이벤트가 발생하기 전에 트리거 실행 
     * AFTER TRIGGER : 지정한 테이블에 이벤트가 발생하기 후에 트리거실행 
    
    -SQL문의 의해 영향을 받는 각 행에 따른 분류 
    
    + 문장 트리거  : 이벤트가 발생한 SQL문 대해 딱 한번만 실행 
    + 행 트리거 : 해당 SQL문이 실행될 때마다 매번 트리거 실행 
                FOR EACH ROW 옵션 설정 필요 
                
                : OLD ~ DEFORE UPDATE (수정 전 자료), BEFORE DELETE(삭제 전 자료) 
                : NEW ~ AFTER INSERT(추가된 자료), AFTER UPDATE(수정 후 자료)
*/

/*
    * 트리거 생성하기 
    CREATE [OR REPLACE] TRIGGER                         -- 트리거 이름  
    BEFORE | AFTER INSERT | UPDATE | DELETE ON 테이블명 -- 이벤트 관련 정보 
    [FOR EACH ROW]                                     -- 매번 트리거를 실행할 것인지에 대한 옵션
    
    [DECLARE] -- 변수/상수 선언 및 초기화
    BEGIN -- 실행부 (SQL문, 조건문, 반복문,...)
                이벤트 발생 시 자동으로 처리할 구문 
                
    
   [EXCEPTION] -- 예외처리부 
   END;
*/
-- EMPLOYEE 테이블에 추가될 때마다 '신입사원님 환영합니다 ^^ 출력'


CREATE TRIGGER TRG_01
AFTER INSERT
ON EMPLOYEE
BEGIN
DBMS_OUTPUT.PUT_LINE('신입 사원님 환영합니다');
END;
 /
 INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,DEPT_CODE, JOB_CODE, HIRE_DATE)
    VALUES (500, '양준혁','000501-3000000','D4','J4',sysdate);
    
 INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,DEPT_CODE, JOB_CODE, HIRE_DATE)
    VALUES (501, '김인창','950704-100000','D6','J5',sysdate);
--------------------------------------------------------------------------------
-- 상품 입고 및 출고 관련 
-- *테이블, 시퀀스 생성
-- 상품을 저장하기 위한 테이블 

CREATE TABLE TB_PRODUCT(
    PNO NUMBER PRIMARY KEY, -- 상품 번호 
    PNAME VARCHAR2(30) NOT NULL, -- 상품명
    BRAND VARCHAR2(30) NOT NULL, -- 브랜드 
    PRICE NUMBER DEFAULT 0,-- 가격
    STOCK NUMBER DEFAULT 0-- 재고수량 
);
 
-- 상품번호로 사용할 시퀀스 시작번호 200, 증가값 5 캐시메모리 x

CREATE SEQUENCE SEQ_PNO
START WITH 200
INCREMENT BY 5 
NOCACHE;

-- SAMPLE 데이터 추가 
INSERT INTO TB_PRODUCT (PNO,PNAME, BRAND) VALUES(SEQ_PNO.NEXTVAL, '아이폰15','사과' );
INSERT INTO TB_PRODUCT VALUES(SEQ_PNO.NEXTVAL, '갤럭시 폴드6','샘송',2000000,500);
INSERT INTO TB_PRODUCT VALUES(SEQ_PNO.NEXTVAL, '샤오미','샤우미',80000,500);

COMMIT; -- DB에 반영하기 

-- 상품 입출고 내역을 저장하기 위한 테이블 
CREATE TABLE TB_PDETAIL(
        DNO NUMBER PRIMARY KEY,
        PNO NUMBER REFERENCES TB_PRODUCT(PNO), -- 상품번호 
        DDATE DATE DEFAULT SYSDATE,
        AMOUNT NUMBER NOT NULL,
        TYPE CHAR(6) CHECK(TYPE IN('입고','출고')) -- 입출고 상태 
        
        
);
-- 입출고 내역에 대한 시퀀스 (내역 번호)
CREATE SEQUENCE SEQ_DNO
NOCACHE;

-- 205번 상품 오늘 날짜 5개 출고 
INSERT INTO TB_PDETAIL VALUES(SEQ_DNO.NEXTVAL, 205, DEFAULT, 5, '출고');

-- * TB_PRODUCT 
UPDATE tb_product
SET STOCK = STOCK - 5
WHERE PNO = 205;

COMMIT;
SELECT * FROM tb_pdetail;
SELECT * FROM tb_product;

--200번 상품의 재고를 10 입고 
INSERT INTO tb_pdetail VALUES(SEQ_DNO.NEXTVAL, 200, DEFAULT, 10, '입고');
ROLLBACK;

UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PNO = 205;

COMMIT;
--------------------------------------------------------------------------------
/*
    * TB_PDETAIL(입출고입력) 테이블에 데이터 추가(INSERT)이벤트 발생 시 
    TB_PRODUCT(상품) 테이블에 재고 수량이 갱신(UPDATE)되어야 함! => 자동으로 처리할 수 있도록 트리거 생성 
    
    - UPDATE 조건 
        * 상품이 입고된 경우 => 해당 상품을 찾아서 재고 수량 증가 
        UPDATE TB_PRODUCT
        SET STOCK = STOCK + 입고수량(TB_PDETAIL.AMOUNT) --> NEW.AMOUNT
        WHERE PNO = 입고된 상품번호(TB_PDETAIL.PNO) --> new.PNO
        
        * 상품이 출고된 경우 => 해당 상품을 찾아서 재고수량 감소 
       UPDATE 조건 
        UPDATE TB_PRODUCT
        SET STOCK = STOCK - 입고수량(TB_PDETAIL.AMOUNT) --> NEW.AMOUNT
        WHERE PNO = 입고된 상품번호(TB_PDETAIL.PNO) --> new.PNO
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
DBMS_OUTPUT.PUT_LINE('제품 수량 증가');
END;
/



INSERT INTO tb_pdetail VALUES(SEQ_DNO.NEXTVAL, 200, DEFAULT, 10, '입고');



 
    
 





