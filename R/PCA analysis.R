# This R script is for performing Principal Component Analysis analysis via 'PCAtools' package.
# Please install the package in advance using 'BiocManager::install()' and load it.
library(PCAtools)

# Choose and load the read counts matrix file that previously generated in Linux.
counts <- read.table(file.choose(),
                     header = TRUE,
                     row.names = 1,
                     sep = "\t")

# Choose and load the group information file for PCA analysis.
#And rename the first column to 'Conditions'.
group_pca <- read.table(file.choose(),
                        header = FALSE,
                        row.names = 2,
                        sep = "\t")
colnames(group_pca)[1] <- "Conditions" 

#Perform dimensionality reduction on the count matrix using PCA, removing the 10% of genes with the least variance.
p <- pca(mat = counts, metadata = group_pca, removeVar = 0.1)

#Plot a scree plot to visualize the proportion of variance explained by each principal component in the PCA.
screeplot(p)

#Plot a biplot of the principal component analysis to visualize the results of PC1 and PC2.
biplot(p,
       x = 'PC1',
       y = 'PC2',
       colby = 'Conditions',
       legendPosition = 'right')