# TGIP mixomic analysis 

## Background
Analysing expression of bumblebee mRNA, miRNA, and other sRNA within an individual to explain how immune memory may be produced.

These analyses can (should?) be executed in a Docker container. To do so, ensure you have Docker installed, download this repository, and execute the following commands to first produce the docker image and then run the analysis:

```powershell or bash
docker build -t mixomic .
```

On Windows, the following command only works on powershell. It should behave better on bash on an 'nix system. If this isn't cooperating, you may need to replace `$(pwd)` with the full path. 

```powershell
docker run --rm -it -p 8787:8787/tcp -v $(pwd):/home/rstudio mixomic:latest
```

Once this is running, you can navigate to [http://localhost:8787/](http://localhost:8787/) to access Rstudio. Ensure working directory is set to `/home/rstudio` and can work through the `tgipmixomics.Rmd` script. Login default username is `rstudio` and password is `rstudio`.

Input data can be found in the `./data/` directory and all intermediate and output files (includes figures, output dataframes and plots) are stored in the `./output/` directory.) 

---- 

I did need to add gene names at the end. See `getGeneNames.Rmd` for that. The output files that end with 'withNames.csv' are the ones that are probably easiest to interpret. 