
# Here is an example of how you can create an AWS CodeBuild project using the AWS CLI:
# 1. Install the AWS CLI and configure it with your AWS access keys. You can do this by running pip install awscli and then running aws configure.
# 2. Create a CodeBuild project using the create-project command. Here is an example of how to do this:


aws codebuild create-project \
  --name MyProject \
  --source { "type": "GITHUB", "location": "https://github.com/my-username/my-repository" } \
  --secondary-sources [ { "type": "S3", "location": "s3://my-s3-bucket/source.zip" } ] \
  --artifacts { "type": "S3", "location": "my-s3-bucket", "path": "build" } \
  --secondary-artifacts [ { "type": "NO_ARTIFACTS" } ] \
  --environment { "type": "LINUX_CONTAINER", "image": "aws/codebuild/standard:4.0", "computeType": "BUILD_GENERAL1_SMALL" } \
  --service-role "arn:aws:iam::123456789012:role/CodeBuildServiceRole"

#   This will create a CodeBuild project with the following properties:

# A source repository hosted on GitHub
# A secondary source artifact in an S3 bucket
# An output artifact in an S3 bucket
# No secondary output artifacts
# A build environment using the standard CodeBuild image with a small compute type
# An IAM role with permissions to access CodeBuild services

# You can also specify build commands and
#  other configuration options in a buildspec.yml file in your source repository. For example:

version: 0.2

phases:
  install:
    commands:
      - echo "Installing dependencies..."
      - npm install
  build:
    commands:
      - echo "Building application..."
      - npm run build
  post_build:
    commands:
      - echo "Uploading build artifact to S3..."
      - aws s3 cp build s3://my-s3-bucket/build --recursive

# This buildspec.yml file defines three phases: 
#   install, 
#   build, 
#   and post_build. 
#     In the install phase, the build agent will run the npm install command to install the project's dependencies.
#     In the build phase, it will run the npm run build command to build the application. 
#     In the post_build phase, it will upload the build artifact to an S3 bucket.

#     You can then start a build by running the start-build command:

aws codebuild start-build --project-name MyProject

# This will trigger a build of your CodeBuild project, 
# using the commands and configuration specified in your buildspec.yml file.
