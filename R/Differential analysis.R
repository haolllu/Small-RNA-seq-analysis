# This R script is for performing miRNA or tRNA differential expression analysis by DESeq2 packages;
# And generate Volcano plot based on results.

# For packages needed later, please install them in advance using 'install.packages()' or 'BiocManager::install()'.
# And load them.
library(DESeq2)
library(dplyr)
library(ggplot2)

# Choose and load the read counts matrix file that previously generated in Linux.
counts <- read.table(file.choose(),
                     header = TRUE,
                     row.names = 1,
                     sep = "\t")

# Choose and load the group information file (contains condition and sample number).
group <- read.table(file.choose(),
                    header = FALSE,
                    sep = "\t")

# Convert the read counts values to integers.
counts <- round(counts, digits = 0)

# Create metadata for subsequent DESeq2 analysis.
coldata <- data.frame(
  row.names = group[ , 2],
  condition = group[ , 1]
)

#Create the DESeq2 dataset object.
dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = coldata,
                              design = ~ condition)

#Choose a condition for setting the factor as reference level.
dds$condition <- relevel(dds$condition, ref = 'ConditionX')

#Query the number of rows, which is equal to the number of genes
nrow(dds)

#Filter out genes with a total read count of less than 10 across all samples.
dds <- dds[rowSums(counts(dds)) >= 10]

#Query the number of remained genes
nrow(dds)

#Perform differential expression analysis via DESeq2.
dds <- DESeq(dds)


#Extract DESeq2 analysis results
DESeq2_result <- results(dds, contrast = c("condition", "Condition1", "Condition2")) 

#Perform an initial query of differentially expressed genes;
#Set the significance threshold (p-adjusted value) to less than 0.05.
summary(DESeq2_result, alpha= 0.05)


#Convert Deseq2 result in a data frame format.
DE_results <- as.data.frame(DESeq2_result)

#Output data frame result in a CSV file.
write.csv(DE_results, file= 'DE_results.csv')

#Filter the candidate genes which are statistically significant differentially expressed genes;
#And output them as a CSV file.
DE_Genes <- 
  filter(DE_results, abs(log2FoldChange) > 1 & padj <0.05) %>%
  select(log2FoldChange, padj) %>%
  arrange(desc(abs(log2FoldChange)), padj)
write.csv(DE_Genes, file= 'DE_Genes.csv')

#Omit NA values.
DE_results <- na.omit(DE_results)

#Assign gene expression change labels based on the p-adjusted value and log2FoldChange.
#The threshold of p-adj and log2FC is 0.05 and 1.
DE_results$significance <- 
  ifelse(DE_results$padj < 0.05 &
           DE_results$log2FoldChange > 1,
         "Upregulated",
         ifelse(DE_results$padj < 0.05 &
                  DE_results$log2FoldChange < -1,
                "Downregulated", "Not Significant"))

#Add a column with the gene names as the values.
DE_results$gene <- rownames(DE_results)

#Set ggplot2 parameters to plot a volcano plot based on differential expression analysis result.
Volcano_plot <- 
  ggplot(DE_results, 
         aes(x = log2FoldChange, y = -log10(padj),
             color = significance)) +
  geom_point(shape = 16, size = 1.5) +
  scale_color_manual(
    values = c("Upregulated" = "red", "Downregulated" = "blue", "Not Significant" = "grey")) +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "black") +
  geom_vline(xintercept = 1, linetype = "dashed", color = "black") +
  geom_vline(xintercept = -1, linetype = "dashed", color = "black") +
  labs(title = "Condition1 vs Condition2", x = "Log2 Fold Change", y = "-Log10 P-Value") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        plot.background = element_blank(),
        legend.title = element_blank(),
        axis.line = element_line(color = "black", linewidth = 0.7),
        axis.title = element_text(size = 14),
        plot.title = element_text(size = 16, hjust = 0.5, face = 'bold'))

#Output the volcano plot.
print(Volcano_plot)