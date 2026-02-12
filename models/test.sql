select 
*
from {{ source('bike_data', 'bike_tbl') }}
limit 2