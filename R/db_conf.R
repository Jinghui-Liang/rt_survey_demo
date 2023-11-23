template <- "[database]\ndriver = mysql\nport = %s\ndbname = %s\nusername = %s\npassword = %s"
conf <- sprintf(template, env_port, sql_dbname, env_usr, env_password)

writeLines(conf, 'server/www/private/conf.ini')
