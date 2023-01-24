source ("R/generate_order.R")

DBI::dbWriteTable (con_t, "order_list", o.record, overwrite = TRUE)
DBI::dbWriteTable (con_t, "frequency_counter", f.record, overwrite = TRUE)
DBI::dbWriteTable (con_t, "order_match", match.record, overwrite = TRUE)

query <- paste ("ALTER TABLE", "order_match", "MODIFY order_label VARCHAR(999)", sep = " ")

rs <- DBI::dbSendStatement (con_t, query)
DBI::dbClearResult (rs)

query <- paste ("ALTER TABLE", "order_match", "MODIFY p_id VARCHAR(999)", sep = " ")

rs <- DBI::dbSendStatement (con_t, query)
DBI::dbClearResult (rs)


query <- paste ("CREATE OR REPLACE TABLE", "demo", "(
    p_id VARCHAR(999),
    age VARCHAR (999), 
    gender VARCHAR(999) 
    )")

rs <- DBI::dbSendStatement (con_t, query)
DBI::dbClearResult (rs)
