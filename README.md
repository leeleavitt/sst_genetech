# SST screening Lee Leavitt

The design of this project has a python package `sst_py` this contains all the code that runs in the docker container. This python package is installed inside of a conda virtual environment. Poetry manages the python dependencies for this package within the conda environment.



This package is accessible to the command line via `defopt`.

I did not have enough time to transform all manually steps into make targets. The general manual steps are contained within the `main.sh`. I added a small ammount of make targets for manual installtion of conda and the software into a local virtual environment.

The workflow takes advantage of of multiprocessing using the `scatter` method. The `scatter` method is contained within a workflow that calls on a task that wraps up the pythn CLI i developed for this project.

For the CLI i decided to contain the software inside of a class. My reasoning behind this was that the function calls were becoming too long and too complex. I used classes to preserve the filename and sample name. I will admit This could be completed without a class.

The naming of my files are not very good. I ran out of time troubleshooting running the workflow locally, and i had to eventually abandadon using `cromwell` and instead use `miniwdl`. With more time i would create better file names.

I also did not have time to develop unit test or establish continuous integration workflows. Both of which I am capable.

The requested output are within `./20230110_121237_sst_all/`