select 
h.OpsDate,
h.WorkCenter,
h.OpsHour,
sum(h.Duration) as ProdHours


from vHourByHour_ProdHours h
group by 
h.OpsDate,
h.WorkCenter,
h.OpsHour