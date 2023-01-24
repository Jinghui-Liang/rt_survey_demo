prompt_position <- "Are you running local test or uploading your platform to a server? (local/server)"
prompt_conf <- "Do you want R to read .env file to get data or manually setting the config (only more than 1 survey are conducted)? (env/man)"

cat(prompt_position)
position <- readLines("stdin", n = 1)

readRenviron(".env")

if (position == "local") {
  env_server <- '127.0.0.1'
} else if (position == "server") {
  env_server <- Sys.getenv ('SERVER_NAME')
} else {
  stop ('arguments must be either "local" or "server"')
}

library(DBI)
library(tidyverse)

con_t <- DBI::dbConnect(
                RMariaDB::MariaDB(),
                host = env_server,
                port = Sys.getenv('SQL_PORT'),
                user = Sys.getenv('USR_NAME'),
                password = Sys.getenv('DB_PASS'),
                dbname = Sys.getenv('DB_NAME'))


con_t <- DBI::dbConnect(
  RMariaDB::MariaDB(),
  host = 127.0.0.1,
  port = 3306,
  user = 'root',
  password = "example",
  dbname = "test")


response <- tbl (con_t, "response") %>% collect()
frequency <- tbl (con_t, "frequency_counter") %>% collect ()
order <- tbl (con_t, "order_list") %>% collect ()
match <- tbl (con_t, "order_match") %>% collect ()

DBI::dbDisconnect(con_t)
head (response)
head (frequency)
head (order)
head (match)
