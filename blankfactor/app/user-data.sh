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