/*
    *시퀀스(SEQUENCE) 
    : 자동으로 번호를 발생 시켜주는 역할을 하는 객체 
      정수를 순차적으로 일정한 값마다 증가 시키면서 생성 
    
    EX) 사원번호, 회원번호, 도서번호, .... 
*/

/*
    *시퀀스 생성하기*
    
    CREAT SEQUENCE 시퀀스명 
    [START WITH 숫자] --> 처음 발생시킬 시작값 지정 : [생략 시 기본값은 1]
    INCREMENT BY 숫자 --> 얼마만큼씩 증가시킬 것인지에 대한 값 지정 [기본값 : 1]
    MAXVALUE 숫자 --> 최대값 기본값 [100..엄청큼]
    MINVALUE -- 최소값[기본값 : 1]
    CYCLE | NOCYCLE : 값의 순환여부 [기본값 : NOCYCLE]
    -->  CUCLE : 시퀀스 값이 최대값에 도달하면 최소값으로 다시 순환하도록 설정
    --> NOCYCLE : 시퀀스 값이 최대값에 도달하면 더이상 증가 증가시키지 않도록 설정 
    
    NOCACHE | CACHE --> 캐시메모리 할당 여부 [기본값 : CACHE 20]
                    --> 캐시메모리 : 미리 발생될 값들을 생성해서 저장해두는 공간 
                            매번 호출할 때마다 새로 생성하는 것이 아니라 
                            캐시메로리라는 공간에 미리 생성된 값들을 가져다가 사용 
                            (속도가 빠름)
                            
                            
       [참고]
       * 테이블 : TB_
       * 뷰    : VW_
       * 스퀀스 : SEQ_
       * 트리거 : TRG_
*/
-- SEQ_TEST라는 이름의 시퀀스 생성 

CREATE SEQUENCE SEQ_TEST;

SELECT * FROM user_sequences;

-- SEQ_EMPNO라는 이름의 시퀀스 생성 
-- 시작 번호를 300번, 증가값은 5, 최대값은 310, 순환x 캐시메모리x
CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
    * 시퀀스 사용하기 *

    - 시퀀스명.CURRVAL : 현재 시퀀스 값(마지막으로 성공한 NEXTVAL의 수행한 값)
    - 시퀀스명.NEXTVAL : 시퀀스 값에 일정 값을 증가시켜 발생한 결과값 
                        현재 시퀀스 값에서 INCREMENT BY 설정된 값 만큼 증가된 값     
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 오류 발생 ! NEXTVAL를 한번도 수행하지 않은 이상
-- CURRVAL는 사용할 수 없다. 

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
-- 생성 후 처음 수행 시 시작값 : 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
-- 315 ==> 오류 발생! 최대값이 310으로 설정되어 있어 그 이상의 값이 조회되므로 오류 
SELECT * FROM user_sequences;

/*
    *시퀀스 구조 변경하기*
    
    ALTER SEQUENCE 시퀀스명 
    (INCREMENT BY 숫자) -- > 증가값 (기본)
    MAXVALUE           --> 최대값 (기본값 : 엄청큼..)
    MINVALUE --< 최소값 1
    [CYCLE | NOCYCLE ] -- > 값 순환여부 (기본값 : NICYCLE)
    [NOCACHE | CACHE] --> 캐시메모리 사용여부. 숫자 여부(바이트 단위)(기본값 : CACHE)
    
    => START WITH 변경 불가!  
*/
-- SEQ_EMPNO 시퀀스의 증가값을 10, 최대값을 400으로 변경 

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10 
MAXVALUE 100000;



SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 

-- 시퀀스 삭제 : DROP 
DROP SEQUENCE SEQ_EMPNO;

-- 시퀀스 정보 확인 : 
SELECT * FROM USER_SEQUENCES;
--------------------------------------------------------------------------------

/*
    * EMPLOYEE 테이블에 시퀀스 적용
    -> 시퀀스 적용 컬럼 : 사원번호(EMP_ID)
*/
--> 시퀀스 생성하기 : 
CREATE SEQUENCE SEQ_EID 
START WITH 300

NOCACHE; -- 캐시메모리 사용 X

-- 시작값 : 300, 증가값 1 .. 순환여부 : NOCYCLE, 최댓값 : 엄청큰값 

-- * 시퀀스 사용하기 : EMPLOYEE 테이블에 데이터 추가될 때 
INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,HIRE_DATE)
    VALUES (SEQ_EID.NEXTVAL, '조건웅', '990928-1111111', 'J4',SYSDATE);

SELECT * FROM employee;


INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,HIRE_DATE)
    VALUES (SEQ_EID.NEXTVAL, '조건순', '990928-2111111', 'J4',SYSDATE);

INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,HIRE_DATE)
    VALUES (SEQ_EID.NEXTVAL, '전두광', '990928-2111111', 'J4',SYSDATE);


INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,HIRE_DATE)
    VALUES (SEQ_EID.NEXTVAL, '전두협', '990928-2111111', 'J4',SYSDATE);


ROLLBACK;
-- DELETE TABLE EMPLOYEE  

DROP SEQUENCE SEQ_EID;












