with test as (SELECT
 concat(fullVisitorId, cast(visitId as string)) as sid, 
 ARRAY_CONCAT_AGG(ARRAY(select productSku from UNNEST(product))) as productSKU, 
 transaction.transactionId as transactionId
FROM
 `dataset_id.ga_sessions_YYYYMMDD`, UNNEST(hits)
 where transaction.transactionId is not null
group by 1,3)
-- SELECT * from test
select sid, productSKU, transactionId from test, unnest(productSKU) as productSKU
