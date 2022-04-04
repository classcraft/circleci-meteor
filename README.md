# circleci-meteor
This repository is used as a custom docker file to run CircleCI continuous integration testing.

### Command to run to build the image
```
docker image build ./ --tag classcraft/circleci-meteor:[METEOR_VERSION]
docker push classcraft/circleci-meteor:[METEOR_VERSION]
```
