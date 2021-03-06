WITH data
AS (SELECT
  s.seq,
  s.row_id,
  s.employee_id,
  s.workorder_id,
  s.workcenter,
  s.operation,
  s.start,
  s.stop,
  s.stop_reason,
  s.stop_comment,
  m.topSeq,
  s.crew_size
FROM dbo.vWorkOrderSeq AS s
LEFT OUTER JOIN dbo.vWO_MaxSeq AS m
  ON m.workorder_id = s.workorder_id
WHERE (s.workcenter NOT IN ('52005C', '53001C', '52004C', '52003C', '53002C', '53003C'))
OR ({ FN CONCAT(s.workcenter, s.stop_reason) } IN (SELECT DISTINCT
  { FN CONCAT(workcenter, 'Change Over') } AS Expr1
FROM dbo.vSeamlessToHour
WHERE (workcenter IN ('52005', '53001', '52004', '52003', '53002', '53003')))
))
SELECT
  workorder_id,
  begSeq,
  endSeq,
  topSeq,
  begEmp,
  endEmp,
  begWC,
  endWC,
  begOp,
  endOp,
  begID,
  endID,
  begDT,
  endDT,
  Reason,
  Comments,
  crew_size * (DATEDIFF(SECOND, begDT, endDT) / 60.0 / 60.0) AS duration
FROM (SELECT
  b.workorder_id,
  b.seq AS begSeq,
  CASE
    WHEN b.topSeq = b.seq THEN b.seq
    ELSE e.seq
  END AS endSeq,
  b.topSeq,
  b.employee_id AS begEmp,
  CASE
    WHEN b.topSeq = b.seq THEN b.employee_id
    ELSE e.employee_id
  END AS endEmp,
  b.workcenter AS begWC,
  CASE
    WHEN b.topSeq = b.seq THEN b.workcenter
    ELSE e.workcenter
  END AS endWC,
  b.operation AS begOp,
  CASE
    WHEN b.topSeq = b.seq THEN b.operation
    ELSE e.operation
  END AS endOp,
  b.row_id AS begID,
  CASE
    WHEN b.topSeq = b.seq THEN b.row_id
    ELSE e.row_id
  END AS endID,
  b.stop AS begDT,
  CASE
    WHEN b.topSeq = b.seq THEN b.stop
    ELSE e.start
  END AS endDT,
  b.stop_reason AS Reason,
  b.stop_comment AS Comments,
  b.crew_size
FROM data AS b
LEFT OUTER JOIN data AS e
  ON e.workorder_id = b.workorder_id
  AND e.seq = b.seq + 1
  AND CAST(e.start AS date) = CAST(b.stop AS date)) AS x
WHERE (begDT <= endDT)