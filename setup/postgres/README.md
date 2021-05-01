# ######################################################################
# Configure PostgreSQL DB in preparation for CICD pipeline
# ######################################################################

# Download PostgreSQL JDBC Driver from https://jdbc.postgresql.org/download.html

Downloaded file is postgresql-42.2.20.jar

# Copy Jar file to Jenkins lib

mv ~/Downloads/postgresql-42.2.20.jar $HOME/.jenkins/war/WEB-INF/lib/postgresql-42.2.20.jar

# Download PostgreSQL for Mac

https://www.enterprisedb.com/downloads/postgres-postgresql-downloads

Downloaded file is ~/Downloads/postgresql-13.2-2-osx.dmg

# Install PostgreSQL server on Mac

Install PostgreSQL by double clicking ~/Downloads/postgresql-13.2-2-osx.dmg

It will install Postgres.app in Applications

Start PostgreSQL.app server on Mac

# Connect using psql to postgres database

/Applications/Postgres.app/Contents/Versions/13/bin/psql
OR 
/usr/local/bin/psql
OR
double click on postgres database in GUI

# Create databases for CI pipeline

create database mars;

create database venus;

create database pluto;

create database system;

create database release;

# create databases for CD pipeline

create database st;

create database pt;

create database it;

create database at;

create database prod;

# Connect to each database and create myapp schema

\connect mars

create schema myapp;

set search_path to myapp;

repeat above steps for each database created



