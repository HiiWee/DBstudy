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
