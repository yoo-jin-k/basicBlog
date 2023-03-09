--테이블 삭제
drop table comments;
drop table post;
drop table category;
drop table blog;
drop table users;

--시퀀스 삭제
drop sequence seq_users_no;
drop sequence seq_category_no;
drop sequence seq_post_no;
drop sequence seq_comments_no;

--시퀀스 생성
CREATE SEQUENCE seq_users_no
INCREMENT BY 1
START WITH 1 
NOCACHE ;


CREATE SEQUENCE seq_category_no
INCREMENT BY 1
START WITH 1 
NOCACHE ;


CREATE SEQUENCE seq_post_no 
INCREMENT BY 1
START WITH 1 
NOCACHE ;


CREATE SEQUENCE seq_comments_no
INCREMENT BY 1
START WITH 1 
NOCACHE ;


--테이블 생성
CREATE TABLE users (
  userNo    NUMBER,
  id        VARCHAR2(50)  NOT NULL Unique,
  userName  VARCHAR2(100) NOT NULL,
  password  VARCHAR2(50)  NOT NULL,
  joinDate  DATE          NOT NULL,
  PRIMARY KEY(userNo)
);

CREATE TABLE blog (
  userNo    NUMBER,
  blogTitle VARCHAR2(200)   NOT NULL,
  logoFile  VARCHAR2(200),
  PRIMARY KEY(userNo),
  CONSTRAINT c_blog_fk FOREIGN KEY (userNo)
  REFERENCES users(userNo)
);

CREATE TABLE category (
  cateNo        NUMBER,
  userNo        NUMBER, 
  cateName      VARCHAR2(200)   NOT NULL,
  description   VARCHAR2(500),
  regDate       DATE            NOT NULL,
  PRIMARY KEY(cateNo),
  CONSTRAINT c_category_fk FOREIGN KEY (userNo)
  REFERENCES blog(userNo)
);


CREATE TABLE post (
  postNo        NUMBER,
  cateNo        NUMBER,  
  postTitle     VARCHAR2(300)   NOT NULL,
  postContent   VARCHAR2(4000),
  regDate       DATE            NOT NULL,
  PRIMARY KEY(postNo),
  CONSTRAINT c_post_fk FOREIGN KEY (cateNo)
  REFERENCES category(cateNo)
);


CREATE TABLE comments (
  cmtNo         NUMBER,
  postNo        NUMBER,
  cmtContent    VARCHAR2(300)   NOT NULL,
  regDate       DATE            NOT NULL,
  PRIMARY KEY(cmtNo),
  CONSTRAINT c_comment_fk FOREIGN KEY (postNo)
  REFERENCES post(postNo)
);
