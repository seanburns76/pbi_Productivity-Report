



select f.*,
f.Mach+f.Lab as StandardHours
from 
(
select 
b.CrewSize*.1 as CrewSize
,b.BaseAddDate
,b.UPMJ
,b.RoutingType
,b.ShortItem
,b.PartNumber
,b.WorkCenter
,b.OpSeq/100 as OpSeq
,b.UnitOfMeasure


,t.TimeBasisValue*(b.MachineStandard*.01)*(b.CrewSize*.1) as Mach
,t.TimeBasisValue*(b.LaborStandard*.01)*(b.CrewSize*.1) as Lab
--,(t.TimeBasisValue*b.SetUpStandard)*.01) as Setup


from (
select * from
(
select 
b.*,
(select max(c.UPMJ) from Item_BaseFile c where c.WorkCenter=b.WorkCenter and c.ShortItem=b.ShortItem and c.OpSeq=b.OpSeq) as cU
from Item_BaseFile b
) x
where x.cU=x.UPMJ 

)
b left join ReportingDimensions.dbo.TimeBasisCalc t on t.TimeBasis=b.TimeBasis 

) f

where f.ShortItem in (
select distinct shortid from Operations.dbo.Cardex)
and f.ShortItem = 200770
