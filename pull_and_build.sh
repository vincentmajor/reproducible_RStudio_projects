#!/bin/bash

## Vincent Major
## August 2020

## default R version to 3.4.1
RVERSION=${RVERSION:-3.4.1} 
# to use a specific version, run:
# bash pull_and_build.sh --RVERSION 3.5.3

## parse named args, from https://brianchildress.co/named-parameters-in-bash/
while [ $# -gt 0 ]; do
   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
        # echo $1 $2 // Optional to see the parameter:value result
   fi
  shift
done

echo "Using R: "$RVERSION

## 0. pull rstudio version
#docker pull rocker/rstudio:$RVERSION
## no need, run will pull if needed

## 1. launch container
docker run -d --rm --name delete_me rocker/rstudio:$RVERSION 

## 2. install packrat
docker exec -it delete_me R -e "install.packages('packrat')"
# should be visibly successful

## 3. commit to new image with same version tag
docker commit delete_me rstudio_packrat:$RVERSION

## 4. clean up container
docker stop delete_me
# should be removed since its run with --rm

echo "created image: rstudio_packrat:"$RVERSION
