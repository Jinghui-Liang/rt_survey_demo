con <- DBI::dbConnect(
              RMariaDB::MariaDB(),
              host = env_server,
              port = env_port,
              user = env_usr,
              password = env_password)

stmt_db <- paste ('CREATE DATABASE', env_dbname)

DBI::dbSendStatement(con, stmt_db)

DBI::dbDisconnect(con)
