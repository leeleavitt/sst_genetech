mkdir patient_files
gsutil cp -r gs://terra-featured-workspaces/Cumulus/cellranger_output -I ./patient_files


# create an environment to install cromwell from conda
.conda/bin/conda create -p .wdl -c bioconda cromwell womtool


# Docker instructions
docker build -t sst:latest .
docker save -o docker_image.tar