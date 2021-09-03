#!/bin/bash

ROSA_CLUSTER_NAME=''
ROSA_AWS_TAGS=''

[[ -z ${ROSA_CLUSTER_NAME} ]] && { echo "Error: Missing ROSA cluster name (ROSA_CLUSTER_NAME)"; exit; }
[[ -z ${ROSA_AWS_TAGS} ]] && { echo "Error: Must define at least one AWS tag (ROSA_AWS_TAGS)"; exit; }

# Get AWS ARN
AWS_RESOURCES_ARNS=$(
  aws resourcegroupstaggingapi get-resources \
    --tag-filters Key="kubernetes.io/cluster/${ROSA_CLUSTER_NAME}",Values="owned" \
    --query "ResourceTagMappingList[].ResourceARN" \
    --output text
  )


# Tag resources
i=0
for arn in ${AWS_RESOURCES_ARNS}; do
  echo "Taggin resource: $(basename $arn)"

  output=$(
    aws resourcegroupstaggingapi tag-resources \
      --resource-arn-list $arn \
      --tags ${ROSA_AWS_TAGS}
  )

  [[ $? -ne 0 ]] && { echo -e "Warning: Can't tag resource: $arn\n$output"; } || { i=$(($i+1)); }

done

echo "Tagged $i resources"
