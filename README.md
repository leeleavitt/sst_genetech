# SST screening Lee Leavitt

The design of this project has a python package `sst_py` this contains all the code which runs in the docker container. this python package is installed inside of a conda virtual environment. Poetry manages the python dependencies for this package.

This package is accessible to the command line via `defopt`.

Unfortuneatly I did not hve enough time to transform all work into the makefile. I added just a little bit for manual installtion of conda and the software into a local virtual environment.

The workflow takes advantage of of multiprocessing using the `scatter` method. The `scatter` method is contained within a workflow that calls on a task that wraps up the pythn CLI i developed for this project.

For the CLI i decided to contain the software inside of a class. My reasoning behind this was that the function calls were becoming too long and too complex. I used classes to preserve the filename and sample name. This could be completed without a class.