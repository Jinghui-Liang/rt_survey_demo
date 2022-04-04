con <- DBI::dbConnect(
                RMariaDB::MariaDB(),
                host = '127.0.0.1',
                port = '3306',
                user = 'root',
                password = 'example',
                dbname = 'rt_survey_test'
)

## query <- "update frequency_counter_6 set n = 0"

query <- "update frequency_counter_3 set n = 0"

rs <- DBI::dbSendStatement (con, query)
DBI::dbClearResult (rs)
DBI::dbDisconnect (con)
