

select p.OpsDate,
p.DepartmentID,
p.OpHour,
case
	when p.PayCode = 'reg1' then sum(p.paidduration) else 0 end as RegHours,
case 
	when p.PayCode = 'ot1' then sum(p.paidduration) else 0 end as OT_Hours
 from vHourByHour_PaidHours p 
 group by 
 p.OpsDate,
p.DepartmentID,
p.OpHour,
PayCode