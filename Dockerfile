FROM ibmcom/db2express-c:10.5.0.5-3.10.0


ENV DB2INST1_PASSWORD plsdontuseme
ENV LICENSE=accept

#override these with --build-arg in your docker build command. 
#example docker build --build-arg DBNAME=MYDB --build-arg DBUSER=john --build-arg DBPWD=supersecret -t john/mydb .
ARG DBNAME=DOCKER
ARG DBUSER=docker
ARG DBPWD=docker
ARG TIMEZONE=CET



COPY setup.db2 /setup.db2

#set timezone
#create the user, expand the 3 ARG variables in the setup.db2 script and execute it with db2.
#This will create an empty database in which user $DBUSER is ADM
RUN \
unlink /etc/localtime &&\
ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime &&\
useradd $DBUSER &&\
echo "$DBUSER:$DBPWD" | chpasswd &&\
chmod 755 /setup.db2 && \
while read line; do eval echo \"$line\"; done < /setup.db2 > /setup.eval.db2 &&\
su - db2inst1 -c "db2start && echo creating db && db2 -td@ -f /setup.eval.db2 && db2 -tvf /home/db2inst1/sqllib/misc/EXPLAIN.DDL"

CMD ["db2start"]