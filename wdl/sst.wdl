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
        Array[Array[File]] output_h5ad = single_sample.output_h5ad
        

    }
}

task single_sample {
    input {
        File transcriptome_file
    }
    
    command <<<
        sst_genentech sst_workflow ~{transcriptome_file}
    >>>

    output{
        Array[File] output_h5ad = glob("./output_h5/*h5ad")
        Array[File] output_umap = glob("./figures/umap*png")
        Array[File] output_gene_rank = glob("./figures/rank*png")
    }
}