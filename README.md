# TGIP mixomic analysis 

## Background
Analysing expression of bumblebee mRNA, miRNA, and other sRNA within an individual to explain how immune memory may be produced.

These analyses should be executed in a Docker container. To do so, ensure you have Docker installed, download this repository, and execute the following commands to first produce the docker image and then run the analysis:

```powershell or bash
docker build -t mixomic .
```

On Windows, the following command only works on powershell.
```powershell
docker run --rm -it -p 8787:8787/tcp -v C:/Users/Seth/Desktop/tgip_mixomic:/home/rstudio mixomic:latest

```

Once this is running, you can navigate to [http://localhost:8787/](http://localhost:8787/) to access Rstudio. Ensure working directory is set to `/home/rstudio` and can work through the `tgipmixomics.Rmd` script.

Input data can be found in the `./data/` directory and all intermediate and output files (includes figures, output dataframes and plots) are stored in the `./output/` directory.) 

-----

A [workflowr][] project.

[workflowr]: https://github.com/jdblischak/workflowr
