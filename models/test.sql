select 
*
from {{ source('samp_data', 'customers') }}
limit 2