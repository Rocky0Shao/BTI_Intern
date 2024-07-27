# 银笙圆滚滚🐰:
install.packages("clusterProfiler")
install.packages("AnnotationHub")
install.packages("biomaRt")
# 银笙圆滚滚🐰:
# Load the packages from the specific directory
library(clusterProfiler, lib.loc = "/data/rocky/R_libs")
library(AnnotationHub, lib.loc = "/data/rocky/R_libs")
library(biomaRt, lib.loc = "/data/rocky/R_libs")


source("https://bioconductor.org/biocLite.R")
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("clusterProfiler")
# 银笙圆滚滚🐰:
# biocLite("clusterProfiler")

# term2gene <- read.table("/Users/xuebozhao/Library/CloudStorage/OneDrive-Personal/FeiLab/Bottle_gourd/pan-genome/selection/pangene_GO_all.txt",header=F,sep="\t")
# term2name <- read.table("/Users/xuebozhao/Library/CloudStorage/OneDrive-Personal/FeiLab/Bottle_gourd/pan-genome/selection/pangene_anno_all.txt",header=F,sep="\t")
# AF_EA_gene = read.table("/Users/xuebozhao/Library/CloudStorage/OneDrive-Personal/FeiLab/Bottle_gourd/pan-genome/selection/fisher_selection_AF_EA.txt",header = T)
# #color_vector <- ifelse(x$qvalue < 0.05, "red", "yellow")
# x <- enricher(AF_EA_gene$GeneID,TERM2GENE=term2gene,TERM2NAME=term2name,pvalueCutoff = 0.05, pAdjustMethod = "BH", qvalueCutoff = 0.1)
# p = dotplot(x)
# p + scale_color_continuous(low='#FDB462', high='#5e534a')

# 银笙圆滚滚🐰:
# [File]
