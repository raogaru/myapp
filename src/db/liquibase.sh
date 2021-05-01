V_DB=${1}

liquibase \
  --driver=org.postgresql.Driver \
  --classpath=/Users/rao/.jenkins/war/WEB-INF/lib/postgresql-42.2.20.jar \
  --url="jdbc:postgresql://localhost:5432/${V_DB}" \
  --changeLogFile=src/db/liquibase.xml \
  --username=rao \
  --password=rao \
  --logLevel info \
update
