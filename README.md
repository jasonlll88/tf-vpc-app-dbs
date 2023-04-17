Take into account the following points:

- Please create an nginx web service that utilizes multi-AZ in AWS. This Web service must only be accessible from NAB's public IPs (using your current public IP is also fine).
- Create an RDS server that's accessible to the web servers.
- All configurations must be as secure as possible (think of what you need to do to make everything secure).
- The web server needs to scale on-demand; when CPU load hits 65% or higher it needs to scale up, when it's 40% or lower it needs to scale down.


# testing load of CPU to trigger autoscaling

run the follwing command in one of the instances

seq 3 | xargs -P0 -n1 md5sum /dev/zero &

to finish the load test run the follwoing command

killall md5sum


# connecting to the DB

psql \
   --host=jlrm-rds-postgres.ce4bclloh7if.us-east-1.rds.amazonaws.com \
   --port=5432 \
   --username=postgres \
   --password
   
   
   \
   --dbname=<database name> 

   passwor is in secret manager
   jlrm-rds-pass