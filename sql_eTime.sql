use HumanResources;


select *,ISNUMERIC(prempaid)
from (
select 
APPLYDATE
,[PAY CODE]
,case when [PAY CODE]='OT1' then Hrs*1.5 else Hrs end as premPaid

 from eTimeHours where [PAY CODE] in ('reg1','ot1')) x
 where ISNUMERIC(prempaid) <>1