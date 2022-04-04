arg <- as.numeric (commandArgs (TRUE))

re.name <- paste0 ("que_rd_test", arg)
r.name <- paste0 ("order_list_", arg)
f.name <- paste0 ("frequency_counter_", arg)
o.name <- paste0 ("order_match_", arg)


library(DBI)
library(tidyverse)
    
con <- DBI::dbConnect(
              RMariaDB::MariaDB(),
              host = '127.0.0.1',
              port = '3306',
              user = 'root',
              password = 'example',
              dbname = 'rt_survey_test'
            )
    
response <- tbl (con, re.name) %>%
  collect()

frequency <- tbl (con, f.name) %>% 
  collect ()

order <- tbl (con, o.name) %>% 
  collect ()

match <- tbl (con, m.name) %>%
  collect ()


dbDisconnect(con)
head (response)
head (frequency)
head (order)
head (match)
