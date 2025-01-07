# Employees sample database

Employees is a sample database I found at [mysql.com](https://dev.mysql.com/doc/employee/en/employees-installation.html)

## Installation

# Docker
The following two steps will create a container running mysql with the examples database.

Create the image
```
docker build -t monstarillo-mysql .
```

Create the container
```
docker run --name monstarillo-mysql -e MYSQL_USER=admin -e MYSQL_PASSWORD=admin -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 -d monstarillo-mysql
```

