{%  snapshot shipments_snapshot- %}

{{
    config
    (
        target_database = 'qwt',
        target_schema = 'snapshots',
        unique_key = "orderid || lineno",
        strategy = 'timestamp',
        updated_at = 'ShipmentDate'
    )
}}

select * from {{ ref('stg_shipments') }}

{% endsnapshot %}