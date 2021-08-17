Notes
Getting Docker to behave is tough.

I made a dockerfile using ```liftr``` in my ```.Rmd``` file. 

from this dir. make the docker w/ (had to mess about heaps to get this to run)
```bash
docker build -t mixomic .
```

Running the docker image worked like this , but didn't have the data files.

```bash
docker run --rm -it -p 8787:8787/tcp mixomic:latest
```

Getting it to actually connect to the data directory was a pain. 

launching it while specifying a directory with the ```-v``` flag didn't work and I had all sorts of errors with permissions. But running from powershell instead of git bash seemed to run it and connect with the necessary files. This should be much easier with 'nix

```powershell
PS C:\Users\Seth\Desktop\tgip_mixomic> docker run --rm -it -p 8789:8789/tcp -v /c/Users/Seth/Desktop/tgip_mixomic:/home/rstudio mixomic:latest
```

Haven't managed to get it to connect to the web server though. This port a problem?
......
yes, that

```powershell
PS C:\Users\Seth\Desktop\tgip_mixomic> docker run --rm -it -p 8787:8787/tcp -v C:/Users/Seth/Desktop/tgip_mixomic:/home/rstudio mixomic:latest
```

Works!