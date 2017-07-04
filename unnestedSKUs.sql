with test AS (SELECT
 concat(fullVisitorId, cast(visitId AS string)) AS sid, 
 ARRAY_CONCAT_AGG(ARRAY(SELECT productSku FROM UNNEST(product))) AS productSKU, 
 transaction.transactionId AS transactionId
FROM
 `dataset_id.ga_sessions_YYYYMMDD`, UNNEST(hits)
 WHERE transaction.transactionId IS NOT NULL
GROUP BY 1,3)
SELECT sid, productSKU, transactionId FROM test, unnest(productSKU) AS productSKU
