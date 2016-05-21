#!/usr/bin/env bash

##create user table
aws dynamodb create-table --table-name todo-user --attribute-definitions AttributeName=uid,AttributeType=S --key-schema AttributeName=uid,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
##check status of table create
aws dynamodb describe-table --table-name todo-user

##create task table
aws dynamodb create-table --table-name todo-task --attribute-definitions AttributeName=uid,AttributeType=S AttributeName=tid,AttributeType=N --key-schema AttributeName=uid,KeyType=HASH AttributeName=tid,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

##update todo-task to have a secondary index
aws dynamodb update-table --table-name todo-task --attribute-definitions AttributeName=uid,AttributeType=S AttributeName=tid,AttributeType=N AttributeName=category,AttributeType=S --global-secondary-index-updates '[{"Create": {"IndexName": "category-index", "KeySchema": [{"AttributeName": "category", "KeyType": "HASH"}, {"AttributeName": "tid", "KeyType": "RANGE"}], "Projection": {"ProjectionType": "ALL"}, "ProvisionedThroughput": {"ReadCapacityUnits": 5, "WriteCapacityUnits": 5}}}]'