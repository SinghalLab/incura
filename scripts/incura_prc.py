import pandas as pd
import numpy as np
from scipy.spatial.distance import pdist, squareform
from sklearn.metrics import silhouette_score, pairwise_distances
from sklearn.metrics import adjusted_rand_score, normalized_mutual_info_score
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.cluster import AgglomerativeClustering
from sklearn.cluster import KMeans
from matplotlib import pyplot as plt
from sklearn.manifold import TSNE
from umap import UMAP
import seaborn as sns
import scanpy as sc
import scipy.cluster.hierarchy as sch
import re
import os
from pathlib import Path
import argparse


# Plotting options, change to your liking
sc.settings.set_figure_params(dpi=200, frameon=False)
sc.set_figure_params(dpi=200)
sc.set_figure_params(figsize=(4, 4))


# Init args
parser = argparse.ArgumentParser()
parser.add_argument('-a','--path_fimo', nargs='+', required=True)
parser.add_argument('-b','--path_summary_out', required=True)
parser.add_argument('-c','--path_jaccard_out', required=True)
parser.add_argument('-d','--path_cosine_out', required=True)
parser.add_argument('-e','--path_jaccardUMAP', required=True)
parser.add_argument('-f','--path_cosineUMAP', required=True)
parser.add_argument('-g','--path_clusters', required=True)
args = vars(parser.parse_args())

path_gex = args['path_fimo']
path_peaks = args['path_summary_out']
path_annot = args['path_jaccard_out']
path_geneids = args['path_cosine_out']
organism = args['path_jaccardUMAP']
path_output = args['path_cosineUMAP']
path_clusters = args['path_clusters']