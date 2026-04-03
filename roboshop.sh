#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-04e34764ba27cbbde"
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "Payment" "dispatch" "frontend")
DOMAIN_NAME="swaroopdevops.store"
ZONE_ID="Z00799019QP1HRUTADDS"

for instance in ${INSTANCES[@]}
do

  #INSTANCE_ID=$(aws ec2 run-instances --image-id ami-0220d79f3f480ecf5 --instance-type t3.micro --security-group-ids sg-04e34764ba27cbbde --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=testSRS}]' --query Instances[0].InstanceId --output text)
  INSTANCE_ID=$(aws ec2 run-instances \
  --image-id ami-0220d79f3f480ecf5 \
  --instance-type t3.micro \
  --security-group-ids sg-04e34764ba27cbbde \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
  --query Instances[0].InstanceId \
  --output text)
  
if [ $instance != "frontend" ]
    then
    IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
    else
    IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
fi

  echo "$instance Ip Address: $IP"
done
