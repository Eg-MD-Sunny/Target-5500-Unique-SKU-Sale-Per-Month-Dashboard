-- New Product Added

select month(cast(dbo.tobdt(pv.CreatedOnUtc) as date)) Months, count(*) NewProductEntry
from productvariant pv
where pv.Deleted=0
and cast(dbo.tobdt(pv.CreatedOnUtc) as date)>='2022-08-01'
and cast(dbo.tobdt(pv.CreatedOnUtc) as date)<'2022-09-01'
and pv.DistributionNetworkId=1

group by  month(cast(dbo.tobdt(pv.CreatedOnUtc) as date))
--order by 1 asc



-- Ordered Products

select  month(cast(dbo.tobdt(ReconciledOn) as date)) Months, count(distinct tr.productvariantid) UniqueProductSold

from ThingRequest tr
join shipment s on tr.ShipmentId=s.id
join productvariant pv on tr.productvariantid=pv.id

where ReconciledOn is not null
and s.ShipmentStatus not in (1,9,10)
and IsReturned=0
and IsMissingAfterDispatch=0
and HasFailedBeforeDispatch=0
and IsCancelled=0
and ReconciledOn>='2022-08-01 00:00 +06:00'
and ReconciledOn<'2022-09-01 00:00 +06:00'
and cast(dbo.tobdt(pv.CreatedOnUtc) as date)>='2022-08-01'
and cast(dbo.tobdt(pv.CreatedOnUtc) as date)<'2022-09-01'
and pv.DistributionNetworkId=1

group by month(cast(dbo.tobdt(ReconciledOn) as date))
--order by 1 asc


---Total Unique Products Sold So Far

select  year(cast(dbo.tobdt(ReconciledOn) as date)) Years,month(cast(dbo.tobdt(ReconciledOn) as date)) Months, 
count(distinct tr.productvariantid) UniqueProductSold

from ThingRequest tr
join shipment s on tr.ShipmentId=s.id
join productvariant pv on tr.productvariantid=pv.id

where ReconciledOn is not null
and s.ShipmentStatus not in (1,9,10)
and IsReturned=0
and IsMissingAfterDispatch=0
and HasFailedBeforeDispatch=0
and IsCancelled=0
and ReconciledOn>='2022-08-01 00:00 +06:00'
and ReconciledOn<'2022-09-01 00:00 +06:00'
and pv.DistributionNetworkId=1

group by year(cast(dbo.tobdt(ReconciledOn) as date)),month(cast(dbo.tobdt(ReconciledOn) as date))
--order by 1 desc, 2 desc
