# Load necessary libraries
library(ggplot2)  # For creating plots
library(reshape2) # For reshaping data

# Load the data from a TSV (tab-separated values) file
data <- read.csv('output.tsv', sep='\t')

# Melt the data to a long format
# 'melt' converts data from a wide format to a long format
data_long <- melt(data, id.vars = 'Gen_Num', 
                  measure.vars = c('All_1', 'At_Least_1'))

# Calculate median values for trend lines==
# 'aggregate' calculates the median value for each combination of Gen_Num and variable
medians <- aggregate(value ~ Gen_Num + variable, data_long, median)

# Create the combined box plot with trend lines connecting the start points
combined_plot <- ggplot(data_long, aes(x=factor(Gen_Num), y=value, fill=variable)) +
  geom_boxplot(alpha=0.5) + # Box plot with transparent colors
  geom_line(data=medians, 
            aes(x=as.numeric(as.character(Gen_Num)), y=value, 
                group=variable, color=variable), size=1) + # Trend lines
  geom_point(data=medians, 
             aes(x=as.numeric(as.character(Gen_Num)), y=value, 
                 group=variable, color=variable), size=2) + # Points on trend lines
  labs(title="Box plots of All_1 and At_Least_1 by Gen_Num with Trend Lines", 
       x="Gen_Num", y="Value") + # Plot labels
  theme_minimal() + # Minimal theme for clean appearance
  scale_fill_manual(values=c("All_1"=adjustcolor("blue", alpha.f=0.5), 
                             "At_Least_1"=adjustcolor("green", alpha.f=0.5))) + # Box plot colors
  scale_color_manual(values=c("All_1"="blue", "At_Least_1"="green")) # Trend line colors

# Save the plot to a PDF
pdf("C_P_d.pdf", width=10, height=6)
print(combined_plot) # Print the plot to the PDF device
dev.off() # Close the PDF device
