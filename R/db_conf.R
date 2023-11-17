template <- "[database]\ndriver = mysql\nhost = %s\nport = %s\ndbname = %s\nusername = %s\npassword = %s"
conf <- sprintf(template, "127.0.0.1", env_port, env_dbname, env_usr, env_password)

writeLines(conf, 'server/www/private/conf.ini')
