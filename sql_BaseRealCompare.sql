

select sum(x.feb1)
from 
(select 
b.[SH ID]
,b.[Part #]
,[Work Center]
,[Work Center DESC]
,[Branch Plant]
,jan+feb+mar+apr+may+jun+Jul as total
,jan
,feb
,mar
,apr
,may
,jun
,jul
,jan1
,Feb1
,mar1
,apr1
,may1
,jun1
,jul1
from basecompare b
) x
where 
x.[SH ID]= 101743
--ltrim(x.[Branch Plant])='100'