Database application of employees in car factory
==========================

## Requirements
- Git Maven
- Java openJDK 11 or newer
- PostgreSQL

## How to run this app
- open cmd in folder where you want to have this app
<h3>Clone project</h3>
  
- `git clone https://github.com/stroyec/bds_project_3.git` 
- `cd bds_project_3` 
<h3>Create database for project</h3>

- ` psql -U postgres` 
- type your password for postgres
- ` CREATE DATABASE car_factory;` 
- `exit` 
- ` psql -U postgres car_factory < car_factory_backup.sql` 

<h3>Run app</h3>

- in cmd type `mvn clean install`
- `cd target`
- `java -jar car_factory-1.0.0.jar`

<h3>Log in</h3>

user name: **hladky.miroslav@automotive.cz**
Password: **batman**


```
Or look into database to table bds.manager and choose whatever email you like - every password is "batman" 
```

## Setup Automatic backups

If you want to setup automatic backups (on Windows) use Task scheduler, choose "Create Basic Task", 
setup time you want to backup database and as program to run choose backup_cmd.bat in backups folder.
If something doesnt work, edit backup_cmd.bat to make it works.
