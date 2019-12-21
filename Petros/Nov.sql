Select Count(R) from RHAData rd where
 (rd.ArrId=448 )
and not exists(select r  from  RHAData rd2  where
SUBSTRING(rd.r from 1 for 21)=SUBSTRING(rd2.r from 1 for 21)
 and rd.AnID!=rd2.ANID and not 
(rd2.arrid=448)
)
