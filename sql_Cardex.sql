
select 
j.DateValue as OpsDate
,c.WORKCENTER
,c.WORKORDER
,c.SHORTID
,c.LONGID
,c.UNITCOST
,c.EXTENDEDCOST
,c.DOCUMENTTYPE
,c.QUANTITY



 from Operations.dbo.Cardex c left join ReportingDimensions.dbo.dimjuliandate j on j.JulianValue=c.OPSDATEINT