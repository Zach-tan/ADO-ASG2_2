
WITH Orders AS (
    SELECT * FROM {{ ref('raw_orders') }}
)

SELECT
    OrderID
FROM
    Orders
WHERE
    RequiredDate < OrderDate