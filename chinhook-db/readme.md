# Chinhook sample database

Chinhook is a sample database I found at [lerocha's github](https://github.com/lerocha/chinook-database)

## Installation

# Docker
The following two steps will create a container running postgres with the chinhook database.

Create the image
```
docker build -t monstarillo-postgres .
```

Create the container
```
docker run --name monstarillo-postgres -e POSTGRES_PASSWORD=<Your Password> -p 5432:5432 -d monstarillo-postgres
```

# Run the DDL
If you already have an instance of postgres running you can run the init.sql to create the tables and insert data.