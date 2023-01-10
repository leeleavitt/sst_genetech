import numpy as np
import pandas as pd
import scanpy as sc


sc.settings.verbosity = 3             # verbosity: errors (0), warnings (1), info (2), hints (3)
sc.logging.print_header()
sc.settings.set_figure_params(dpi=80, facecolor='white')


import numpy as np
import pandas as pd
import scanpy as sc
import os


sc.settings.verbosity = 3             # verbosity: errors (0), warnings (1), info (2), hints (3)
sc.logging.print_header()
sc.settings.set_figure_params(dpi=80, facecolor='white')


class sst_toolset:
    def __init__(self, fn: str):
        """Initialize the class with a filename and smaple name to referene throughout"""
        self.fn = fn
        self.sample_name = os.path.basename(os.path.dirname(fn))
        self.adata =  sc.read_10x_h5(fn)


    def filter_function(self):
        """ Load data and Filter the transcriptomic data with predefined settings

        Args:
            fn (str): name of file to perform filtering
        Returns: AnnData object
        
        """

        self.adata.var_names_make_unique()

        # affect self.adata in place
        sc.pp.filter_cells(self.adata, min_genes=500) 

        self.adata.var['mt'] = self.adata.var_names.str.startswith('MT-')  # annotate the group of mitochondrial genes as 'mt'

        # create qc metrics on adata in place and filter based on these calcuatled metrics
        sc.pp.calculate_qc_metrics(self.adata, qc_vars=['mt'], percent_top=None, log1p=False, inplace=True)
        self.adata = self.adata[self.adata.obs.n_genes_by_counts < 6000, :]
        self.adata = self.adata[self.adata.obs.pct_counts_mt < 10, :]

        # total count normalize the data
        sc.pp.normalize_total(self.adata, target_sum=100000)

        # idneitfy highly variable genes
        sc.pp.log1p(self.adata)
        sc.pp.highly_variable_genes(self.adata, min_mean=0.0125, max_mean=3, min_disp=0.5)
        sc.pl.highly_variable_genes(self.adata, show= False)

        # keep top 2000 variable genes
        sc.pp.filter_genes_dispersion(self.adata, n_top_genes=2000)

    def umap_plotter(self):
        """Function to create a umap plot with leiden coloring"""
        sc.tl.pca(self.adata, svd_solver='arpack')
        sc.pl.pca(self.adata, color='CST3', show = False)
        sc.pl.pca_variance_ratio(self.adata, log=True, show=False)

        sc.pp.neighbors(self.adata, n_neighbors=100)

        sc.tl.leiden(self.adata, 1.3)

        sc.tl.paga(self.adata)
        sc.pl.paga(self.adata, plot=False)  # remove `plot=False` if you want to see the coarse-grained graph
        sc.tl.umap(self.adata, init_pos='paga')

        sc.tl.umap(self.adata)
        sc.pl.umap(self.adata, color=['leiden'], save=f"{self.sample_name}.png", show=False)

    def gene_rank_plotter(self):
        # gene rank plot
        sc.tl.rank_genes_groups(self.adata, 'leiden', method='wilcoxon')

        sc.pl.rank_genes_groups(self.adata, n_genes=25, sharey=False, save=f"_{self.sample_name}.png", show=False)

    def saver(self):
        os.makedirs("./output_h5", exist_ok=True)
        self.adata.write_h5ad(f"./output_h5/{self.sample_name}.h5ad")


def sst_workflow(fn: str):

    obj = sst_toolset(fn)

    obj.filter_function()
    obj.umap_plotter()
    obj.saver()




