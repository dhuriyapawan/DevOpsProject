#!/bin/bash
yum update -y
yum install -y java-17-amazon-corretto

aws s3 cp s3://cloud-bucket-1770975946/app.jar /home/ec2-user/app.jar

nohup java -jar /home/ec2-user/app.jar > app.log 2>&1 &