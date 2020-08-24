# Reproducible RStudio Projects

Code to accompany talk at [R/Medicine 2020](https://events.linuxfoundation.org/r-medicine/).

Slides at: https://vincentmajor.github.io/reproducible_RStudio_projects/

## RStudio Projects with Docker

Building on the fantastic work by the [rocker group](https://github.com/rocker-org), particularly their [version stable images on Docker Hub](https://hub.docker.com/r/rocker/r-ver) for any recent R version (e.g. 3.4.1).
These versioned images contain a RStudio version that enables you to use RStudio in the browser. 

These rocker images also update the CRAN repo to a MRAN snapshot when that R version was last current.

### Additions to rocker

To simplify everything I recommend:

1. mounting a folder of source code,
2. adding your UID to ease permissions issues
3. initializing a `packrat` project within the mounted source directory

Launch Docker with:
```
$ docker run -d -e USERID=$UID -e PASSWORD=fake -v $(pwd):/work -p 7009:8787 rocker/rstudio:3.4.1
```
Within R:
```
> install.packages("packrat")
> packrat::init("/work")
> packrat::on("/work")
```

## Example setup:

Run:
```
$ bash run_example.sh
```
In a browser, go to localhost:7009 and login with rstudio/fake. 
Run:
```
> setwd('/work')
> install.packages('packrat')
> packrat::restore('/work')
```
and then run the example_code.R

## Optional: install packrat to versioned image

Each new Docker container won't have anything installed and will need `packrat` to be installed before resuming work. To prevent this you can install `packrat` into the Docker image you use. 
The [pull_and_build.sh](pull_and_build.sh) script does exactly this by taking an argument `RVERSION`, pulling that rocker/rstudio image, installing `packrat`, and creating a new image: `rstudio_packrat:RVERSION`.
 
