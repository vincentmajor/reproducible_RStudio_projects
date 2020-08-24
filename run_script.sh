#!/bin/bash

## Vincent Major
## August 2020

## default R version to 3.4.1
RVERSION=${RVERSION:-3.4.1} 
## to use a specific version, run:
# bash run_script.sh --RVERSION 3.5.3

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

## if using standard rocker image:
docker run -d -e USERID=$UID -e PASSWORD=fake -v $(pwd):/work rocker/rstudio:$RVERSION
## if adding packrat to the rocker image:
# bash pull_and_build.sh
# docker run -d -e USERID=$UID -e PASSWORD=fake -v $(pwd):/work rstudio_packrat:$RVERSION


## OPTIONS
## 1. USERID can be manually set, GROUPID can also be set.
## 2. Password needs to be set. USERID doesn't work if omitted (default: rstudio).
## 3. To mount additional volumnes, repeat the argument:
# -v <local_path>:<container_path>
## useful to add data from one place but source code from another
## note that these paths must be absolute, e.g. "/home/user/project" rather than "project"
## 4. To label the container for auto-deletion when stopped, add this flag:
# --rm
## 5. To change the port used (default: 8787), replace <port> with your selection>:
# -p <port>:8787
## Docker will error if you launch a second container with the same port.
## to minimize potential security risks, should specify localhost or loopback IP address:
# -p 127.0.0.1:<port>:8787
## 6. To name the container, add optional argument:
# --name <container_name>
## Docker will error if you try to launch a second container with the same name
