cat ("reading generate_order.R")
options (tidyverse.quiet = TRUE)
library (tidyverse)
set.seed (666) ## since it would be sourced by other scripts it should be reproducible.

## Method to generate a Latin-Square

latin_template <- function(n){
  lat_sq <- array (rep (seq_len (n), each = n), c (n, n))
  lat_sq <- apply (lat_sq - 1, 2, function (x) (x + 0:(n-1)) 
                   %% n) + 1
  return(lat_sq)
}

## Generate a table including all the presentation order we want, and make it suitable for JavaScript.
p_order_table <- function (qlen, rd.size = qlen) {
  if (isTRUE (rd.size >= factorial(qlen))) {
    stop ("number of expected randomzied order exceeded the maximum possible arrangments")
  } else {
    fx <- as_tibble (t ((1 : qlen)))
    ls <- as_tibble (latin_template (qlen))
    rd <- as_tibble (t (replicate (rd.size, sample (1: qlen, qlen, FALSE), TRUE)))

    ls_label <- paste0 (rep ("ls", length (ls)), 1:length (ls))
    rd_label <- paste0 (rep ("rd", rd.size), 1: rd.size)
    order_label <- c ("fx", ls_label, rd_label)
    position_label <- paste0 ("p", 1: qlen)

    dat <- (bind_rows (fx, ls) %>% bind_rows (rd) - 1)

    order_table <- tibble (order_label = order_label) %>% bind_cols (dat)
    colnames (order_table) [2: (qlen + 1)] <- position_label
    return (order_table)
  }
}

o.record <- p_order_table (qlen)

f.record <- tibble (
  order_label = o.record$order_label,
  n = rep (0)
)

match.record <- tibble (p_id = "0",
                        order_label = "0")
match.record <- match.record[-1, ]
