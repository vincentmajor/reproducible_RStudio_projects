#!/bin/bash

## Vincent Major
## August 2020

## launch docker
docker run -d --rm -e USERID=$UID -e PASSWORD=fake -v $(pwd):/work -p 7009:8787 --name my_rproject rocker/rstudio:3.4.1


## go to port 7009 and login with rstudio/fake
## run:
# > setwd('/work')
# > install.packages('packrat')
# > packrat::restore('/work')
# and then run the example_code.R

