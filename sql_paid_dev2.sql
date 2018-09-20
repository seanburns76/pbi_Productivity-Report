select  
APPLYDATE as OpsDate
,departmentid
,case
	when [PAY CODE]='reg1' then sum(hrs) else 0 end as [Actual Hours]
,case 
	when [PAY CODE]='OT1' then sum(hrs) else 0 end as [OT Hours]
,case 
	when [PAY CODE]='OT1' then sum(hrs)*.5 else 0 end as [OT Premium]

from 
HumanResources.dbo.eTimeHours where 
Payroll_Status in ( 
'Ameristar Hourly 8Hr OK'
,'Ameristar OK Temp'
,'Ameristar Non Exempt') 

and [PAY CODE] in ('reg1','ot1')

group by APPLYDATE,DepartmentID,[PAY CODE]
order by 1
