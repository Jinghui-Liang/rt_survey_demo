con <- DBI::dbConnect(
                RMariaDB::MariaDB(),
                host = '127.0.0.1',
                port = '3306',
                user = 'root',
                password = 'example',
                dbname = 'rt_survey_test'
)

query <- "CREATE OR REPLACE TABLE response (
p_id VARCHAR(999), 
rt VARCHAR(999), 
response VARCHAR(999), 
Q_num VARCHAR(999), 
trial_type VARCHAR(999), 
trial_index VARCHAR(999), 
order_index VARCHAR(999),
time_elapsed VARCHAR(999), 
internal_node_id VARCHAR(999)
)"

DBI::dbSendQuery(con, query)
DBI::dbDisconnect(con)
