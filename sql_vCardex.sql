use Operations;
select 
d.DateValue as OpsDate
,q.ShortItem
,q.LongItem
,q.StockType
,q.UnitMeasure
,q.DocType
,q.BusinessUnit
,q.DocNumber
,q.UnitCost*.001 as UnitCost
,q.EntryUser
,q.SRP1
,q.SRP4
,q.PRP4
,q.SRP5
,q.TotalQuantity


from operations.dbo.cardex_qty q left join ReportingDimensions.dbo.dimJulianDate d on d.JulianValue=q.CreateDateInt
where q.SRP5 in ('FG','CMP','RAW')