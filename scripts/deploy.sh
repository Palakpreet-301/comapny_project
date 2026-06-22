#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H-%M-%S")

echo "Deployment Started $DATE" >> ../logs/deploy.log

echo "Creating Backup..."

rm -rf ../backup/*

cp -r ../website/* ../backup/

echo "Backup Completed" >> ../logs/deploy.log

echo "Pushing to GitHub..."

cd ..

git add .

git commit -m "Deployment $DATE"

git push origin main

echo "Deploying to S3..."

aws s3 sync website/ s3://company-static-website123
echo "Deployment Completed $DATE" >> logs/deploy.log

echo "Done"
