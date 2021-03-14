--https://sjy1218vv.tistory.com/136


drop table ebd_report_cmt;
drop table ebd_report_heart;
drop table ebd_report;
drop table ebd_episode_cmt;
drop table ebd_episode_heart;
drop table ebd_episode;
drop table ebd_wording_heart;
drop table ebd_wording;
drop table ebd_market_cmt;
drop table ebd_market_heart;
drop table ebd_market;
drop table ebd_file_cmt;
drop table ebd_file_heart;
drop table ebd_file;
drop table ebd_users;

drop sequence ebd_report_seq;
drop sequence ebd_report_cmt_seq;
drop sequence ebd_episode_seq;
drop sequence ebd_episode_cmt_seq;
drop sequence ebd_wording_seq;
drop sequence ebd_market_seq;
drop sequence ebd_market_cmt_seq;
drop sequence ebd_file_seq;
drop sequence ebd_file_cmt_seq;
drop sequence ebd_report_heart_seq;
drop sequence ebd_episode_heart_seq;
drop sequence ebd_wording_heart_seq;
drop sequence ebd_file_heart_seq;
drop sequence ebd_market_heart_seq;

-- 도서리뷰 회원 테이블
CREATE TABLE ebd_users(
	id VARCHAR2(100) PRIMARY KEY, --아이디
	pwd VARCHAR2(100) NOT NULL, --비밀번호
	name VARCHAR2(100),  --이름
	nick VARCHAR2(100) NOT NULL, --닉네임
	gender VARCHAR2(10), --성별
	birth_year VARCHAR2(10), --생년
	birth_month VARCHAR2(10), --월
	birth_day VARCHAR2(10), --일 
	email VARCHAR2(100), --이메일
	phone VARCHAR2(100), --핸드폰 
	profile VARCHAR2(2000), --프로필 이미지
	regdate DATE, --등록일
	CONSTRAINT users_nick_uk UNIQUE(nick), -- 닉네임은 유일해야한다. 
	CONSTRAINT users_gender_ck CHECK(gender IN('male','female')) --남자일 경우 'm', 여자일 경우 'f'가 들어간다.
);


-- 독후감 테이블 
CREATE TABLE ebd_report(  
	num NUMBER PRIMARY KEY, --글 번호
	booktitle VARCHAR2(2000), --책 제목
	title VARCHAR2(2000), --글 제목 
	writer VARCHAR2(100), --작성자(닉네임) / join 연결고리
	author VARCHAR2(2000), --책 저자
	link VARCHAR2(2000), -- 구매처 링크
	genre VARCHAR2(100), --책 장르
	stars VARCHAR2(50), --평점
	imgpath VARCHAR2(2000), --이미지
	content CLOB, --내용
	publicck VARCHAR2(50) DEFAULT 'private', --공개/비공개 여부 / DEFAULT 'private'
	viewcnt NUMBER, --조회수
	regdate DATE, --등록일
	CONSTRAINT r_writer_fk FOREIGN KEY(writer) REFERENCES ebd_users(nick) ON DELETE CASCADE --지우지마세영~
);

-- 독후감 테이블 시퀀스
CREATE SEQUENCE ebd_report_seq;

-- 독후감 댓글 테이블
CREATE TABLE ebd_report_cmt(
	num NUMBER PRIMARY KEY, --글 번호
	writer VARCHAR2(100), --작성자
	content VARCHAR2(500), --댓글 내용
	target_nick VARCHAR2(100), --답댓글 달 대상자 아이디
	ref_group NUMBER, -- 원글(거래 글)의 글 번호 
	cmt_group NUMBER, -- 댓글의 그룹번호
	deleted CHAR(3) DEFAULT 'no', --삭제된 댓글인지의 여부
	regdate DATE, --댓글 작성일
	CONSTRAINT rc_ref_group_fk FOREIGN KEY(ref_group) REFERENCES ebd_report(num) ON DELETE CASCADE
);

-- 독후감 댓글의 글번호를 얻어낼 시퀀스
CREATE SEQUENCE ebd_report_cmt_seq;

CREATE TABLE ebd_report_heart(
	num NUMBER PRIMARY KEY,
	target_num NUMBER,
	writer VARCHAR2(100),
	CONSTRAINT rh_writer_fk FOREIGN KEY(writer) REFERENCES ebd_users(nick) ON DELETE CASCADE, --지우지마세영~
	CONSTRAINT rh_num_fk FOREIGN KEY(target_num) REFERENCES ebd_report(num) ON DELETE CASCADE
);

CREATE SEQUENCE ebd_report_heart_seq;

-- 도서 에피소드 테이블
CREATE TABLE ebd_episode(
	num NUMBER PRIMARY KEY, --글 번호
	writer VARCHAR2(100), --작성자(로그인 된 아이디)
	title VARCHAR2(2000), --제목
	imgpath VARCHAR2(2000), --이미지
	content CLOB, --내용
	viewcnt NUMBER, --조회수
	regdate DATE, --등록일
	heartcnt INT, --좋아요 수 
	CONSTRAINT e_writer_fk FOREIGN KEY(writer) REFERENCES ebd_users(nick) ON DELETE CASCADE --지우지마세영~
);

-- 도서 에피소드 테이블 시퀀스
CREATE SEQUENCE ebd_episode_seq;

-- 독후감 댓글 테이블
CREATE TABLE ebd_episode_cmt(
	num NUMBER PRIMARY KEY, --글 번호
	writer VARCHAR2(100), --작성자
	content VARCHAR2(500), --댓글 내용
	target_nick VARCHAR2(100), --답댓글 달 대상자 아이디
	ref_group NUMBER, -- 원글(거래 글)의 글 번호 
	cmt_group NUMBER, -- 댓글의 그룹번호
	deleted CHAR(3) DEFAULT 'no', --삭제된 댓글인지의 여부
	regdate DATE, --댓글 작성일 
	CONSTRAINT ec_ref_group_fk FOREIGN KEY(ref_group) REFERENCES ebd_episode(num) ON DELETE CASCADE	
);

-- 독후감 댓글의 글번호를 얻어낼 시퀀스
CREATE SEQUENCE ebd_episode_cmt_seq;

CREATE TABLE ebd_episode_heart(
	num NUMBER PRIMARY KEY,
	target_num NUMBER,
	writer VARCHAR2(100),
	CONSTRAINT eh_writer_fk FOREIGN KEY(writer) REFERENCES ebd_users(nick) ON DELETE CASCADE, --지우지마세영~
	CONSTRAINT eh_num_fk FOREIGN KEY(target_num) REFERENCES ebd_episode(num) ON DELETE CASCADE
);

CREATE SEQUENCE ebd_episode_heart_seq;

-- 명언 테이블 
CREATE TABLE ebd_wording(
	num NUMBER PRIMARY KEY, --글 번호
	writer VARCHAR2(100), --작성자(로그인 된 아이디)
	title VARCHAR2(2000), --책 제목
	content CLOB, -- 내용(명언)
	author VARCHAR2(2000), --책의 작가 
	viewcnt NUMBER, --조회수
	regdate DATE, --등록일
	CONSTRAINT w_writer_fk FOREIGN KEY(writer) REFERENCES ebd_users(nick) ON DELETE CASCADE --지우지마세영~
);

-- 명언 테이블 시퀀스
CREATE SEQUENCE ebd_wording_seq;


CREATE TABLE ebd_wording_heart(
	num NUMBER PRIMARY KEY,
	target_num NUMBER, --글의 번호
	writer VARCHAR2(100), --좋아요 누른 사람
	CONSTRAINT wh_writer_fk FOREIGN KEY(writer) REFERENCES ebd_users(nick) ON DELETE CASCADE, --지우지마세영~
	CONSTRAINT wh_num_fk FOREIGN KEY(target_num) REFERENCES ebd_wording(num) ON DELETE CASCADE --지우지마세영~
);

CREATE SEQUENCE ebd_wording_heart_seq;

-- 도서 거래 테이블
CREATE TABLE ebd_market(
	num NUMBER PRIMARY KEY, --글 번호
	writer VARCHAR2(100), --작성자(로그인 된 아이디)
	title VARCHAR2(2000), --제목
	salestype VARCHAR2(50), --판매유형 나눔/교환/판매
	salesstatus VARCHAR2(50), --판매상태 판매중/완료
	imgpath VARCHAR2(2000), --이미지 파일
	content CLOB, --내용
	viewcnt NUMBER, --조회수
	regdate DATE, --등록일
	CONSTRAINT m_writer_fk FOREIGN KEY(writer) REFERENCES ebd_users(nick) ON DELETE CASCADE --지우지마세영~
);

-- 도서 거래 테이블 시퀀스
CREATE SEQUENCE ebd_market_seq;

--도서 거래 하트 테이블
CREATE TABLE ebd_market_heart(
	num NUMBER PRIMARY KEY,
	target_num NUMBER,
	writer VARCHAR2(100),
	CONSTRAINT mh_writer_fk FOREIGN KEY(writer) REFERENCES ebd_users(nick) ON DELETE CASCADE, --지우지마세영~
	CONSTRAINT mh_num_fk FOREIGN KEY(target_num) REFERENCES ebd_market(num) ON DELETE CASCADE
);

--도서 거래 하트 시퀀스 
CREATE SEQUENCE ebd_market_heart_seq;


-- 도서 거래 댓글 테이블
CREATE TABLE ebd_market_cmt(
	num NUMBER PRIMARY KEY, --글 번호
	writer VARCHAR2(100), --작성자
	content VARCHAR2(500), --댓글 내용
	target_nick VARCHAR2(100), --답댓글 달 대상자 아이디
	ref_group NUMBER, -- 원글(거래 글)의 글 번호 
	cmt_group NUMBER, -- 댓글의 그룹번호
	deleted CHAR(3) DEFAULT 'no', --삭제된 댓글인지의 여부
	regdate DATE, --댓글 작성일
	CONSTRAINT mc_ref_group_fk FOREIGN KEY(ref_group) REFERENCES ebd_market(num) ON DELETE CASCADE
);

-- 도서 거래 댓글의 글번호를 얻어낼 시퀀스
CREATE SEQUENCE ebd_market_cmt_seq;

-- 독후감 양식 파일 업로드 테이블
CREATE TABLE ebd_file(
	num NUMBER PRIMARY KEY, --글 번호
	writer VARCHAR2(100), --작성자(로그인 된 아이디의 닉네임)
	title VARCHAR2(2000), --제목
	orgfname VARCHAR2(2000), --파일명
	savefname VARCHAR2(2000), --파일명
	filesize NUMBER,--파일 사이즈
	imgpath VARCHAR2(2000), --이미지 파일
	content CLOB, --내용
	viewcnt NUMBER, --조회수
	regdate DATE, --등록일
	CONSTRAINT f_writer_fk FOREIGN KEY(writer) REFERENCES ebd_users(nick) ON DELETE CASCADE 
);

-- 독후감 양식 파일 업로드 테이블 시퀀스
CREATE SEQUENCE ebd_file_seq;

-- 독후감 양식 파일 업로드 댓글 테이블
CREATE TABLE ebd_file_cmt(
	num NUMBER PRIMARY KEY, --글 번호
	writer VARCHAR2(100), --작성자
	content VARCHAR2(500), --댓글 내용
	target_nick VARCHAR2(100), --답댓글 달 대상자 아이디
	ref_group NUMBER, -- 원글(거래 글)의 글 번호 
	cmt_group NUMBER, -- 댓글의 그룹번호
	deleted CHAR(3) DEFAULT 'no', --삭제된 댓글인지의 여부
	regdate DATE, --댓글 작성일 
	CONSTRAINT fc_ref_group_fk FOREIGN KEY(ref_group) REFERENCES ebd_file(num) ON DELETE CASCADE
);

-- 독후감 양식 파일 업로드 댓글의 글번호를 얻어낼 시퀀스
CREATE SEQUENCE ebd_file_cmt_seq;


CREATE TABLE ebd_file_heart(
   num NUMBER PRIMARY KEY,
   target_num NUMBER, 
   writer VARCHAR2(100), 
   CONSTRAINT fh_writer_fk FOREIGN KEY(writer) REFERENCES ebd_users(nick) ON DELETE CASCADE, 
   CONSTRAINT fh_num_fk FOREIGN KEY(target_num) REFERENCES ebd_file(num) ON DELETE CASCADE
);

CREATE SEQUENCE ebd_file_heart_seq;

--트리거에서 사용된 테이블 삭제 시 트리거도 같이 삭제됩니다!! 주의하세요!!
--user테이블의 nick이 update 되었을 때 발생하는 trigger
	CREATE TRIGGER tg_user_update
	AFTER UPDATE OF nick ON ebd_users FOR EACH ROW   
	BEGIN
					UPDATE ebd_report  
	        SET writer = :NEW.nick
	        WHERE writer = :OLD.nick;
					
					UPDATE ebd_report_cmt 
	        SET writer = :NEW.nick
	        WHERE writer = :OLD.nick;
					
					UPDATE ebd_report_cmt 
	        SET target_nick = :NEW.nick
	        WHERE target_nick = :OLD.nick;
					
					UPDATE ebd_report_heart 
	        SET writer = :NEW.nick
	        WHERE writer = :OLD.nick;  
					
					UPDATE ebd_wording 
	        SET writer = :NEW.nick
	        WHERE writer = :OLD.nick; 
					
					UPDATE ebd_wording_heart 
	        SET writer = :NEW.nick
	        WHERE writer = :OLD.nick; 
					
					UPDATE ebd_episode 
	        SET writer = :NEW.nick
	        WHERE writer = :OLD.nick;  
					
					UPDATE ebd_episode_cmt 
	        SET writer = :NEW.nick
	        WHERE writer = :OLD.nick;
					
					UPDATE ebd_episode_cmt 
	        SET target_nick = :NEW.nick
	        WHERE target_nick = :OLD.nick; 
					
					UPDATE ebd_episode_heart 
	        SET writer = :NEW.nick
	        WHERE writer = :OLD.nick; 
					
					UPDATE ebd_file 
	        SET writer = :NEW.nick
	        WHERE writer = :OLD.nick;  
					
					UPDATE ebd_file_cmt 
	        SET writer = :NEW.nick
	        WHERE writer = :OLD.nick;
					
					UPDATE ebd_file_cmt 
	        SET target_nick = :NEW.nick
	        WHERE target_nick = :OLD.nick;

					UPDATE ebd_file_heart 
	        SET writer = :NEW.nick
	        WHERE writer = :OLD.nick; 
					
					UPDATE ebd_market 
	        SET writer = :NEW.nick
	        WHERE writer = :OLD.nick;
					
					UPDATE ebd_market_cmt 
	        SET writer = :NEW.nick
	        WHERE writer = :OLD.nick; 
					
					UPDATE ebd_market_cmt 
	        SET target_nick = :NEW.nick
	        WHERE target_nick = :OLD.nick; 
		
					UPDATE ebd_market_heart 
	        SET writer = :NEW.nick
	        WHERE writer = :OLD.nick;             
	    END;
	/


--user테이블의 행이 삭제되었을 때 발생하는 trigger 
CREATE TRIGGER tg_user_delete
    AFTER DELETE ON ebd_users FOR EACH ROW   
    BEGIN
				UPDATE ebd_report_cmt 
        SET deleted = 'yes'
        WHERE deleted = 'no' AND writer= :OLD.nick;  
				
				UPDATE ebd_episode_cmt 
        SET deleted = 'yes'
        WHERE deleted = 'no' AND writer= :OLD.nick;  
				
				UPDATE ebd_file_cmt 
        SET deleted = 'yes'
        WHERE deleted = 'no' AND writer= :OLD.nick;  
				
				UPDATE ebd_market_cmt 
        SET deleted = 'yes'
        WHERE deleted = 'no' AND writer= :OLD.nick;  
    END;
/

