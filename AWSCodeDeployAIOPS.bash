# Here is an example of how you can use the AWS CodeDeploy command-line interface (CLI) to deploy an application
# revision from a local directory to an Amazon EC2/On-Premises compute platform:
#
#First, install the AWS CLI and the AWS CodeDeploy CLI plugin.

# Next, create an AWS CodeDeploy application and a deployment group in the desired AWS region using the following
# commands:

aws deploy create-application --application-name my-application
aws deploy create-deployment-group --application-name my-application --deployment-group-name my-deployment-group --service-role-arn arn:aws:iam::123456789012:role/CodeDeployServiceRole --ec2-tag-filters Key=Environment,Value=Prod Key=Stack,Value=Frontend --on-premises-instance-tag-filters Key=Environment,Value=Prod Key=Stack,Value=Frontend

# Then, create a file named appspec.yml in the root directory of your application revision with the following 
# content:

version: 0.0
os: linux
files:
  - source: /
    destination: /var/www/html
hooks:
  BeforeInstall:
    - location: scripts/install_dependencies.sh
      timeout: 300
      runas: root
  AfterInstall:
    - location: scripts/start_server.sh
      timeout: 300
      runas: root
  ApplicationStop:
    - location: scripts/stop_server.sh
      timeout: 300
      runas: root
# Finally, use the following command to deploy the revision to your deployment group

aws deploy push --application-name my-application --s3-location s3://my-bucket/my-application.zip --ignore-hidden-files
aws deploy create-deployment --application-name my-application --deployment-group-name my-deployment-group --s3-location bucket=my-bucket,key=my-application.zip,bundleType=zip

# This will package your application revision as a zip file and upload it to the specified S3 bucket, 
# and then deploy it to the instances in your deployment group.


