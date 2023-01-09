UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
	CONDA_SRC := https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
endif
ifeq ($(UNAME_S), Linux)
	CONDA_SRC := https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
endif

CONDA_LOCATION = $(CURDIR)/.conda

conda_install:
	curl -s $(CONDA_SRC) --fail --show-error -L -o miniconda.sh ; \
	bash miniconda.sh -b -p ./.conda; \
	rm miniconda.sh ; \
	./.conda/bin/conda clean -a -y ; \

conda_env_create:
	$(CONDA_LOCATION)/bin/conda env create -p ./.sst_py --file environment.yaml
