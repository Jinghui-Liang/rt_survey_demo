include ./.env

# Your Makefile targets and rules
.env: ./.env
		echo "The .env file has changed."
		echo $(USR_NAME)
		echo $(DB_NAME)
