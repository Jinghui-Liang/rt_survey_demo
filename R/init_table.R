con_t <- DBI::dbConnect(
                RMariaDB::MariaDB(),
                host = env_server,
                port = env_port,
                user = env_usr,
                password = env_password,
                dbname = env_dbname)

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

rs <- DBI::dbSendQuery(con_t, query)
DBI::dbClearResult (rs)

cat ("response table generated successfully")
