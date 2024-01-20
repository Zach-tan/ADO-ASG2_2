WITH OrderValues AS (
    SELECT
        OrderID,
        SUM(UnitPrice * Quantity * (1 - Discount)) AS TotalOrderValue
    FROM
        {{ ref('raw_order_detail') }}
    GROUP BY
        OrderID
)

SELECT
    OrderID
FROM
    OrderValues
WHERE
    TotalOrderValue < 0