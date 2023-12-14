if(!interactive()) {
  prompt_position <- "Are you running local test or uploading your platform to a server? (local/server)"
  prompt_conf <- "Do you want R to read .env file to get data or manually setting the config (only more than 1 survey are conducted)? (env/man)"
}


cat(prompt_position)
position <- readLines("stdin", n = 1)

readRenviron("../.env")

if (position == "local") {
  env_server <- '127.0.0.1'
} else if (position == "server") {
  env_server <- Sys.getenv ('SERVER_NAME')
} else {
  stop ('arguments must be either "local" or "server"')
}

library(tidyverse)

con_t <- DBI::dbConnect(
                RMariaDB::MariaDB(),
                host = env_server,
                port = Sys.getenv('SQL_PORT'),
                user = Sys.getenv('USR_NAME'),
                password = Sys.getenv('DB_PASS'),
                dbname = "fullScale")

response <- tbl (con_t, "response") |> dplyr::collect ()
demo <- tbl (con_t, "demo") |> dplyr::collect () |> 
  dplyr::mutate (property = substr (property, 2, nchar(property) - 1)) |> 
  tidyr::pivot_wider(names_from = property,
                     values_from = value)
frequency <- tbl (con_t, "frequency_counter") |> dplyr::collect ()
order <- tbl (con_t, "order_list") |> dplyr::collect ()
match <- tbl (con_t, "order_match") |> dplyr::collect ()

if (!interactive()) {
  dir.create(paste0("./raw_data/results-", Sys.Date()))
} else {
  dir.create(paste0("../raw_data/results-", Sys.Date()))
}
  
DBI::dbDisconnect(con_t)