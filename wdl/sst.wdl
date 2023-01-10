version 1.0

workflow sst_all {
    input {
        Array[File] transcriptome_files
    }

    scatter(file in transcriptome_files){
        call single_sample{
            input:
                transcriptome_file = file
        }
    }

    output{
        Array[File] count_matrix_h5ad = flatten(single_sample.output_h5ad)
        Array[File] umap_png = flatten(single_sample.output_umap)
        Array[File] gene_rank_png = flatten(single_sample.output_gene_rank)

    }
}

task single_sample {
    input {
        File transcriptome_file
    }
    
    command <<<
        sst-genentech sst-workflow ~{transcriptome_file}
    >>>

    runtime {
        docker : "./docker_image.tar"
    }

    output{
        Array[File] output_h5ad = glob("./output_h5/*h5ad")
        Array[File] output_umap = glob("./figures/umap*png")
        Array[File] output_gene_rank = glob("./figures/rank*png")
    }
}