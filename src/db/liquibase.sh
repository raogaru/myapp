V_DB=${1}
liquibase \
  --driver=org.postgresql.Driver \
  --url="jdbc:postgresql://localhost:5432/${V_DB}" \
  --changeLogFile=src/db/liquibase.xml \
  --username=rao \
  --password=rao \
  --logLevel info \
update
#  --classpath=/Users/rao/Downloads/postgresql-42.2.20.jar \
#  --classpath=postgresql-42.2.20.jar \
