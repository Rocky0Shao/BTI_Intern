# Load necessary libraries
library(ggplot2)  # For creating plots
library(reshape2) # For reshaping data

# Load the data from a TSV (tab-separated values) file
data <- read.csv('C_P/output_d.tsv', sep='\t')

# Melt the data to a long format
# 'melt' converts data from a wide format to a long format
data_long <- melt(data, id.vars = 'Gen_Num', 
                  measure.vars = c('All_1', 'At_Least_1'))

# Calculate median values for trend lines
# 'aggregate' calculates the median value for each combination of Gen_Num and variable
medians <- aggregate(value ~ Gen_Num + variable, data_long, median)

# Create the combined box plot with smooth trend lines connecting the start points
combined_plot <- ggplot(data_long, aes(x=factor(Gen_Num), y=value, fill=variable)) +
  geom_boxplot(alpha=0.5) + # Box plot with transparent colors
  geom_smooth(data=medians, 
              aes(x=as.numeric(as.character(Gen_Num)), y=value, 
                  group=variable, color=variable), 
              method='loess', size=1, se=FALSE) + # Smooth trend lines
  geom_point(data=medians, 
             aes(x=as.numeric(as.character(Gen_Num)), y=value, 
                 group=variable, color=variable), size=2) + # Points on trend lines
  labs(title="Proteinotho Pan- and Core-Genome size", 
       x="Number of genomes", y="Number of orthogroups") + # Plot labels
  theme_minimal() + # Minimal theme for clean appearance
  theme(axis.text.x = element_text(size=14), # Increase x-axis text size
        axis.text.y = element_text(size=14), # Increase y-axis text size
        axis.title.x = element_text(size=16), # Increase x-axis title size
        axis.title.y = element_text(size=16), # Increase y-axis title size
        plot.title = element_text(size=18)) + # Increase plot title size
  scale_fill_manual(values=c("All_1"=adjustcolor("blue", alpha.f=0.5), 
                             "At_Least_1"=adjustcolor("green", alpha.f=0.5))) + # Box plot colors
  scale_color_manual(values=c("All_1"="blue", "At_Least_1"="green")) # Trend line colors

# Save the plot to a PDF
pdf("C_P/C_P_d.pdf", width=11, height=6)
print(combined_plot) # Print the plot to the PDF device
dev.off() # Close the PDF device
