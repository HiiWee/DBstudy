select * from MEMBER;
select * from NOTICE;
select * from N_COMMENT;
select * from role;
commit;


-- << INNER JOIN >>
-- INNER 생략해도 디폴트가 이너조인
select * from MEMBER INNER JOIN NOTICE ON MEMBER.ID = NOTICE.WRITER_ID;
select * from MEMBER inner join NOTICE on MEMBER.ID = NOTICE.WRITER_id;

-- << OUTER JOIN >>
select * from NOTICE N left outer join MEMBER M on N.WRITER_ID = M.ID;
select * from MEMBER M left outer join NOTICE N on M.ID = N.WRITER_ID;
select * from member M full outer join notice N on M.ID = N.writer_id;

-- ID, NAME, 그리고 회원별 작성한 게시글 수를 조회하시오.
select M.ID, M.NAME, count(N.ID) 게시글수
from MEMBER M left outer join NOTICE N on M.ID = N.WRITER_ID
group by M.ID, M.NAME;





-- << SELF JOIN >>
select M.*, B.NAME BOSS_NAME 
from MEMBER M left outer join MEMBER B ON B.ID = M.BOSS_ID;

commit;



-- << OLD JOIN >>
select N.*, M.name writer_name
from notice N join MEMBER M on M.ID = N.writer_id;

select N.*, M.name writer_name
from notice N, MEMBER M
where M.ID = N.writer_id;

-- old outer join
select N.*, M.name writer_name
from notice N left join MEMBER M on M.ID = N.writer_id;

select N.*, M.name writer_name
from notice N, MEMBER M
where M.ID(+) = N.writer_id;

-- CROSS JOIN
select N.*, M.name wrtier_name
from member M cross join NOTICE N;



-- << UNION >>
select ID, NAME from MEMBER
    union all
select writer_id, title from notice;


-- << VIEW >>
select N.ID, N.TITLE, N.writer_id, M.name, count(C.id) cnt
from MEMBER M
right outer join NOTICE N on M.id = N.writer_id
left outer join N_COMMENT C on N.id = C.notice_id
group by N.id, N.title, N.writer_id, M.name;
-- 위의 구문들을 하나의 뷰로 만들면 간편하게 이용가능

create or replace view NOTICEVIEW as
select N.ID, N.TITLE, N.writer_id, M.name, count(C.id) cnt
from MEMBER M
right outer join NOTICE N on M.id = N.writer_id
left outer join N_COMMENT C on N.id = C.notice_id
group by N.id, N.title, N.writer_id, M.name;

select * from NOTICEVIEW;


-- << 데이터 딕셔너리 >>
select * from DICT;
-- 사용자 테이블을 보기
select * from USER_TABLES;
-- 사용자 테이블의 컬럼 보기
select * from USER_TAB_COLUMNS;
select * from USER_TAB_COLUMNS where TABLE_NAME='MEMBER';

-- << 정규식 이용한 체크제약조건 >>

-- 기존 체크제약조건 드랍
alter table member drop constraint MEMBER_PHONE_CHK1;

-- 삭제된 제약조건 확인
select * from user_constraints where TABLE_NAME = 'MEMBER';

-- 제약조건 추가
alter table MEMBER
add constraint MEMBER_PHONE_CHK1 check(REGEXP_LIKE(PHONE, '^01[01234567]-\d{3,4}-\d{4}'));

-- << SEQUENCE >>
insert into notice(ID, TITLE, WRITER_ID)
values(NOTICE_ID_SEQ.NEXTVAL, '시퀀스 예제', 'hoseok'); -- 시퀀스 초기값을 마지막 ID+1로 변경해야함

select NOTICE_ID_SEQ.NEXTVAL from Dual; --실행할때마다 값이 1씩증가 > 시퀀스

-- ID값을 넣지 않고도 ID를 자동적으로 삽입하는 방법
-- NOTICE 테이블정보 수정 버튼 > ID열 > 만든 시퀀스 선택
-- 하지만 초기 ID값을 설정해야 거기서부터 하나씩 증가하며 삽입함
-- 설정 완료하면
insert into notice(TITLE, WRITER_ID)
values('시퀀스 예제', 'hoseok');