Take into account the following points:

- Please create an nginx web service that utilizes multi-AZ in AWS. This Web service must only be accessible from NAB's public IPs (using your current public IP is also fine).
    
    - create instnace
    - create AMI
    - create template Launch
    - create ASG
    - create route 53 record for the instnace
    - route 53
- Create an RDS server that's accessible to the web servers.
- All configurations must be as secure as possible (think of what you need to do to make everything secure).
- The web server needs to scale on-demand; when CPU load hits 65% or higher it needs to scale up, when it's 40% or lower it needs to scale down.






--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"

#!/bin/bash
set -xe
echo "Hello World" >> /tmp/testfile.txt
echo "Installing and Starting Nginx"
yum update -y
yum install nginx postgresql15 -y
systemctl enable nginx


echo "Adding hostname to nginx html"
TOKEN=`curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
export AVAILABILITY_ZONE=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone)
export INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
export NEW_HOSTNAME="${hostname_prefix}-$INSTANCE_ID-$AVAILABILITY_ZONE"
sed -i -e "s/Welcome to nginx\!/Welcome to nginx\! from $NEW_HOSTNAME/g" /usr/share/nginx/html/index.html
systemctl start nginx
--//--

psql postgresql://postgres:postgres1234@database-1-nginx-post.cwqxj6gguo0r.us-east-1.rds.amazonaws.com:5432/-

postgres
postgres1234


psql \
   --host=database-1-nginx-post.cwqxj6gguo0r.us-east-1.rds.amazonaws.com \
   --port=5432 \
   --username=postgres \
   --password
   
   
   \
   --dbname=<database name> 