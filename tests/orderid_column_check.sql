select orderid from {{ ref('stg_orders') }}
where orderid < 10000 or orderid>16935