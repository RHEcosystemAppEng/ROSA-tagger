# ROSA-tagger
This repository contains a script for add AWS tags to all the resources
associated to a ROSA (Red Hat Openshift Service on AWS) deployment.


## Context
ROSA provides a CLI to manage Openshift as a Service on AWS.  However, this CLI
doesn't allow add custom tags on the AWS resources associated to de deployment.
That's the reason for this script


## Usage
The `rosa_tagger.sh` performs two main operations: Find all the resources with
a specific tag and get their AWS:ARN, and add the specified tags to all of
them.

### Requisites
* Have a AWS account
* Have installed AWS CLI
* Login with AWS CLI
* Get the default tag 'kubernetes.io/cluster/<cluster-name>'

### Example
```sh
export ROSA_CLUSTER_NAME=<CLUSTER_NAME>
export ROSA_AWS_TAGS='Pourpose="laboratory",Partner="partner1'

./rosa_tagger.sh
```



## Useful Links
* [AWS TAGS](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)(V2 recommended)
* [ROSA CLI](https://cloud.redhat.com/products/amazon-openshift/download)
* [Architecture Models](https://docs.openshift.com/rosa/rosa_architecture/rosa-architecture-models.html)
