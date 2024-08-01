create database inlaze_db;

use inlaze_db;

drop table if exists inlaze_data;
create table if not exists inlaze_data (
	periodo		datetime,
    clicks		text,
    registros_in	text,
    1er_deposito_in	text,
    to_depositado_in	text,
    per_apostaron_in	text,
    total_apostado_in	text,
    net_revenue_in	text
    )engine=innodb default charset=utf8mb4 collate=utf8mb4_0900_ai_ci;
    
load data infile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\assetment-bookmaker (3).csv"
into table inlaze_data
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines
set 
    clicks = nullif(clicks, ''),
    registros_in = nullif(registros_in, ''),
    1er_deposito_in = nullif(1er_deposito_in, ''),
    to_depositado_in = nullif(to_depositado_in, ''),
    per_apostaron_in = nullif(per_apostaron_in, ''),
    total_apostado_in = nullif(total_apostado_in, ''),
    net_revenue_in = nullif(net_revenue_in, '');

select * from inlaze_data;

# Correcting data type.
ALTER TABLE inlaze_data	MODIFY clicks int,
						MODIFY registros_in int,
                        MODIFY 1er_deposito_in int,
                        MODIFY to_depositado_in int,
                        MODIFY per_apostaron_in int,
                        MODIFY total_apostado_in int,
                        MODIFY net_revenue_in int;

## EDA

-- Rows
select count(periodo)
from inlaze_data;

# For these steps procedure were not created as they would not improve the performance of the query.

-- Null and not null values in the data base nn: Not null, n:null
create view datos_nulos as
select 'periodo' as column_name, count(periodo) as not_null, sum(if(periodo is null, 1,0)) as null_value
from inlaze_data
union all
select 'clicks' as column_name, count(clicks) as not_null, sum(if(clicks is null, 1,0)) as null_value
from inlaze_data
union all
select 'registros_in' as column_name, count(registros_in) as not_null, sum(if(registros_in is null, 1,0)) as null_value
from inlaze_data
union all
select '1er_deposito_in' as column_name,  count(1er_deposito_in) as not_null, sum(if(1er_deposito_in is null, 1,0)) as null_value
from inlaze_data
union all
select 'to_depositado_in' as column_name,  count(to_depositado_in) as not_null, sum(if(to_depositado_in is null, 1,0)) as null_value
from inlaze_data
union all
select 'per_apostaron_in' as column_name,  count(per_apostaron_in) as not_null, sum(if(per_apostaron_in is null, 1,0)) as null_value
from inlaze_data
union all
select 'total_apostado_in' as column_name,  count(total_apostado_in) as not_null, sum(if(total_apostado_in is null, 1,0)) as null_value
from inlaze_data
union all
select 'net_revenue_in' as column_name,  count(net_revenue_in) as not_null, sum(if(net_revenue_in is null, 1,0)) as null_value
from inlaze_data;


-- Descriptive Statistics
create view estadistica_descrirptiva as
select 'clicks' as column_name, count(clicks) as nn_count, round(avg(clicks),2) as mean, round(stddev(clicks),2) as std_dev, max(clicks) as max_value, min(clicks) as min_value
from inlaze_data
union all
select 'registros_in' as column_name, count(registros_in) as nn_count, round(avg(registros_in),2) as mean, round(stddev(registros_in),2) as std_dev, max(registros_in) as max_value, min(registros_in) as min_value
from inlaze_data
union all
select '1er_deposito_in' as column_name, count(1er_deposito_in) as nn_count, round(avg(1er_deposito_in),2) as mean, round(stddev(1er_deposito_in),2) as std_dev, max(1er_deposito_in) as max_value, min(1er_deposito_in) as min_value
from inlaze_data
union all
select 'to_depositado_in' as column_name, count(to_depositado_in) as nn_count, round(avg(to_depositado_in),2) as mean, round(stddev(to_depositado_in),2) as std_dev, max(to_depositado_in) as max_value, min(to_depositado_in) as min_value
from inlaze_data
union all
select 'per_apostaron_in' as column_name, count(per_apostaron_in) as nn_count, round(avg(per_apostaron_in),2) as mean, round(stddev(per_apostaron_in),2) as std_dev, max(per_apostaron_in) as max_value, min(per_apostaron_in) as min_value
from inlaze_data
union all
select 'total_apostado_in' as column_name, count(total_apostado_in) as nn_count, round(avg(total_apostado_in),2) as mean, round(stddev(total_apostado_in),2) as std_dev, max(total_apostado_in) as max_value, min(total_apostado_in) as min_value
from inlaze_data
union all
select 'net_revenue_in' as column_name, count(net_revenue_in) as nn_count, round(avg(net_revenue_in),2) as mean, round(stddev(net_revenue_in),2) as std_dev, max(net_revenue_in) as max_value, min(net_revenue_in) as min_value
from inlaze_data;

select * from datos_nulos;

select * from estadistica_descrirptiva;
   






    