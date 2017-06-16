create database $DBNAME@

connect to $DBNAME@
grant DBADM on database to user $DBUSER@


--table spaces: execute once
CREATE BUFFERPOOL BP32 PAGESIZE 32K@
create tablespace USERSPACE32 pagesize 32k BUFFERPOOL BP32@
create system temporary tablespace TEMPSPACE32 pagesize 32k BUFFERPOOL BP32@
create temporary tablespace USERTMPSPACE32 pagesize 32k BUFFERPOOL BP32@

grant use of tablespace USERSPACE32 to user $DBUSER@


