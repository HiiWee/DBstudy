select * from MEMBER;
select * from NOTICE;
select * from role;



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
    intersect
select writer_id, title from notice;


-- << VIEW >>
select N.ID, N.TITLE, N.writer_id, M.name, count(C.id) cnt
from MEMBER M
right outer join NOTICE N on M.id = N.writer_id
left outer join "COMMENT" C on N.id = C.notice_id
group by N.id, N.title, N.writer_id, M.name;
-- 위의 구문들을 하나의 뷰로 만들면 간편하게 이용가능

create view NOTICEVIEW as
select N.ID, N.TITLE, N.writer_id, M.name, count(C.id) cnt
from MEMBER M
right outer join NOTICE N on M.id = N.writer_id
left outer join "COMMENT" C on N.id = C.notice_id
group by N.id, N.title, N.writer_id, M.name;

select * from NOTICEVIEW;


-- << 데이터 딕셔너리 >>
select * from DICT;
-- 사용자 테이블을 보기
select * from USER_TABLES;
-- 사용자 테이블의 컬럼 보기
select * from USER_TAB_COLUMNS;
select * from USER_TAB_COLUMNS where TABLE_NAME='MEMBER';
