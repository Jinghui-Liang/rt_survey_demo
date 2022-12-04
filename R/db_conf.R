readRenviron(".env")

template <- "[database]\ndriver = mysql\nhost = %s\nport = %s\ndbname = %s\nusername = root\npassword = %s"

conf <- sprintf(template, env_server, env_port, env_dbname, env_password)

writeLines(conf, 'server/www/private/conf.ini')
