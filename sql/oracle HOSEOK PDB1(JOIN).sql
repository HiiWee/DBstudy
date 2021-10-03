select * from MEMBER;
select * from NOTICE;
select * from role;

-- << INNER JOIN >>
-- INNER 생략해도 디폴트가 이너조인
select * from MEMBER INNER JOIN NOTICE ON MEMBER.ID = NOTICE.WRITER_ID;

-- << OUTER JOIN >>
select * from NOTICE N left outer join MEMBER M on N.WRITER_ID = M.ID;

-- ID, NAME, 그리고 회원별 작성한 게시글 수를 조회하시오.
select M.ID, M.NAME, count(N.WRITER_ID) COUNT 
from MEMBER M left outer join NOTICE N on M.ID = N.WRITER_ID 
group by M.ID, M.name;