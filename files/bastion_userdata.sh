#!/bin/bash
sudo yum update -y
sudo yum install telnet python-pip mariadb awslogs -y
sudo pip install awscli
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
monitor_path=/monitor
sudo rm -rf $monitor_path
sudo mkdir -p $monitor_path
cd $monitor_path
sudo yum install -y perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https perl-Digest-SHA.x86_64 unzip
sudo curl https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip -O
sudo unzip CloudWatchMonitoringScripts-1.2.2.zip && \sudo rm -rf CloudWatchMonitoringScripts-1.2.2.zip
cd aws-scripts-mon
sudo cp awscreds.template awscreds.conf
cd $monitor_path
echo "*/5 * * * * $monitor_path/aws-scripts-mon/mon-put-instance-data.pl --mem-used-incl-cache-buff --mem-util --disk-space-util --disk-path=/ --from-cron" |sudo tee aws_cloudwatch
sudo crontab aws_cloudwatch
	
sudo docker build --tag=friendlyhello /tmp
$(aws ecr get-login --no-include-email --region cn-northwest-1)
sudo docker tag friendlyhello:latest 443283900611.dkr.ecr.cn-northwest-1.amazonaws.com.cn/friendlyhello:latest
sudo docker push 443283900611.dkr.ecr.cn-northwest-1.amazonaws.com.cn/friendlyhello:latest