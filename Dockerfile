FROM rocker/verse:4.1.0

MAINTAINER Seth Barribeau <seth.barribeau@gmail.com>

# from this dir. make the docker w/ (had to mess about heaps to get this to run)
# docker build -t mixomic .

# how to produce the output files? 
# docker run --rm -it -p 8787:8787/tcp mixomic:latest 


# to run the docker and specify local data directory for the input files
# docker run --rm -it -p 8787:8787/tcp -v /home/seth/data:/home/rstudio mixomic:latest



# docker run --rm -it -v $(pwd):/home/rstudio -p 8787:8787/tcp mixomic:latest R # http://localhost:8787/ rstudio rstudio 
# docker run --rm -it --user docker -v $(pwd):/home/docker/foo -w /home/docker/foo rocker/r-base R
# docker run -v $(pwd):/home/rstudio/$USER -p 8787:8787 bioconductor/devel_base


# System dependencies for required R packages
# RUN  rm -f /var/lib/dpkg/available \ # this seems to cause an error.
RUN rm -rf  /var/cache/apt/* \
  && apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    apt-utils \
    ca-certificates \
    libssl-dev 
    

RUN apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libxml2-dev 
    # \
    # git # prob with git install in docker

# RUN apt-get update -qq && apt-get install -y --no-install-recommends apt-utils
RUN apt-get update -qq && apt-get install -y --no-install-recommends gfortran

RUN apt-get install -y --no-install-recommends \
  git



# Pre-compiled pandoc required by rmarkdown
# Version from: https://github.com/metacran/r-builder/blob/master/pkg-build.sh
# Scripts from: https://github.com/jangorecki/dockerfiles/blob/master/r-pkg/Dockerfile
RUN PANDOC_VER="1.17.2" \
  && PANDOC_DIR="/opt/pandoc" \
  && PANDOC_URL="https://s3.amazonaws.com/rstudio-buildtools/pandoc-${PANDOC_VER}.zip" \
  && mkdir -p "${PANDOC_DIR}" \
  && wget --no-check-certificate -O /tmp/pandoc-${PANDOC_VER}.zip ${PANDOC_URL} \
  && unzip -j /tmp/pandoc-${PANDOC_VER}.zip "pandoc-${PANDOC_VER}/linux/debian/x86_64/pandoc" -d "${PANDOC_DIR}" \
  && chmod +x "${PANDOC_DIR}/pandoc" \
  # && ln -s "${PANDOC_DIR}/pandoc" /usr/local/bin \ # creates an error with existing pandoc symbol link
  && unzip -j /tmp/pandoc-${PANDOC_VER}.zip "pandoc-${PANDOC_VER}/linux/debian/x86_64/pandoc-citeproc" -d "${PANDOC_DIR}" \
  && chmod +x "${PANDOC_DIR}/pandoc-citeproc" \
  # && ln -s "${PANDOC_DIR}/pandoc-citeproc" /usr/local/bin \
  && rm -f /tmp/pandoc-${PANDOC_VER}.zip

RUN Rscript -e "install.packages(c('devtools','BiocManager','knitr','rmarkdown','shiny','RCurl'), repos = 'https://cran.rstudio.com')"

RUN Rscript -e "source('https://cdn.jsdelivr.net/gh/nanxstats/liftrlib@aa132a2deb1c55a781b8ef89881b611a10030c58/install_cran.R');install_cran(c('edgeR','pacman','igraph'))"

RUN Rscript -e "BiocManager::install(c('mixOmics'))" # removed the version number
# RUN Rscript -e "BiocManager::install(c('mixOmics'))" # removed the version number

RUN mkdir /liftrroot/
WORKDIR /liftrroot/
