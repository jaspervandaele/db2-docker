# db2-docker
An empty DB2 database, initialized with my typical customizations

build example:
docker build --build-arg DBNAME=MYDB --build-arg DBUSER=john --build-arg DBPWD=supersecret -t john/mydb .

