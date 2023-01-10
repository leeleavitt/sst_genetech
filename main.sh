mkdir patient_files
gsutil cp -r gs://terra-featured-workspaces/Cumulus/cellranger_output -I ./patient_files


# create an environment to install cromwell from conda
.conda/bin/conda create -p .wdl -c bioconda cromwell womtool=38


# Docker instructions
docker build -t sst:latest .
docker save -o docker_image.tar sst

# running
conda create -p .cromwell cromwell

.cromwell/bin/cromwell run wdl/sst.wdl -i input.json

java -Dconfig.file=custom.conf -jar ~/cromwell/cromwell-84.jar run wdl/sst.wdl -i input.json