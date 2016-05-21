#!/usr/bin/env bash

##create user table
aws dynamodb create-table --table-name todo-user --attribute-definitions AttributeName=uid,AttributeType=S --key-schema AttributeName=uid,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
##check status of table create
aws dynamodb describe-table --table-name todo-user