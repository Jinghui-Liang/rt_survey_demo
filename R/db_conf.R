template <- "[database]\ndriver = mysql\nhost = %s\nport = %s\ndbname = %s\nusername = %s\npassword = %s"
conf <- sprintf(template, "db", env_port, sql_dbname, env_usr, env_password)

writeLines(conf, 'server/www/private/conf.ini')
