/* with cte as (
    select starttime,
    TO_TIMESTAMP_NTZ(starttime, 'YYYY-MM-DD MM:SS') as trip_start_time
    from {{ source('bike_data', 'bike_tbl') }}
    limit 30
)

select * from cte */

with cte as (
    select TO_TIMESTAMP(start_time) as trip_start_time,
    DATE(trip_start_time),
    HOUR(trip_start_time),
    CASE 
    WHEN DAYNAME(trip_start_time) IN ('Sat', 'Sun')
        THEN 'Weekend'
    ELSE 'Business Day'
    END AS Day_Type,

    CASE
    WHEN MONTH(trip_start_time) IN (11,12,1,2)
        THEN 'WINTER'
    WHEN MONTH(trip_start_time) in (3,4,5,6)
        THEN 'SUMMER'
    ELSE 'RAINY'
    END AS Season

    from {{ source('bike_data', 'bike_tbl') }}
    limit 300
)

select * from cte