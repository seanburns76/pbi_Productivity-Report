
select
b4.ShortItem
,b4.PartNumber
,b4.BranchPlant
,b4.WorkCenter
,b4.OpSeq/100 as OpSeq
,b4.UnitOfMeasure

,(((b4.MachineStandard+b4.LaborStandard)*.01)/
(case
	when ltrim(rtrim(b4.TimeBasis))='U' then 1
	when b4.TimeBasis='1' then 10
	when b4.TimeBasis='2' then 100
	when b4.TimeBasis='3' then 1000
	when b4.TimeBasis='4' then 10000
	else 0 end )

)*(b4.CrewSize/10) as StandardHours


from
(
select b3.*,t.TimeBasisValue
from 
(
select b2.*
from
(
select x.*
from
(
select b.*,
(select max(b1.UPMJ)  from Finance.dbo.Item_BaseFile b1 where b1.WorkCenter=b.WorkCenter and b1.ShortItem=b.ShortItem and b1.OpSeq=b.OpSeq) as cUPMJ
from finance.dbo.Item_BaseFile b
) x where x.cUPMJ=x.UPMJ
) b2
) b3 left join ReportingDimensions.dbo.TimeBasisCalc t on t.TimeBasis=b3.TimeBasis
) b4 