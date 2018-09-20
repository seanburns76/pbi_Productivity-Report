select 
[pay code]
,Payroll_Status
,Hrs*
(case
	when [PAY CODE]='Reg1' then 1 else 1.5 end) as TotalPaidHours
from eTimeHours
where APPLYDATE >='20180319' and APPLYDATE <='20180325'
and [PAY CODE] in ('reg1','ot1')
and Payroll_Status = 'Ameristar Non Exempt'

