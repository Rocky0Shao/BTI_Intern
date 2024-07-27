# Load necessary libraries
library(ggplot2)
library(dplyr)
library(gridExtra)

# Read the TSV file
data <- read.csv("wild.tsv", sep="\t", header=TRUE)

# Categorize frequencies
data$Category <- cut(data$Normalized_Gene_Count, 
                     breaks = c(-Inf, 0.05, 0.95, 0.99, Inf),
                     labels = c("Cloud", "Shell", "SoftCore", "Core"),
                     right = FALSE)

# Count occurrences for each category
category_count <- data %>% 
  group_by(Category) %>% 
  summarise(Count = n())

# Define a function to determine the fill color based on the normalized gene count
fill_color <- function(count) {
  if (count == 1) {
    return("#FFD700")
  } else if (count > 0.95 && count < 1) {
    return("#FF69B4")
  } else if (count > 0.05 && count <= 0.95) {
    return("#D3D3D3")
  } else {
    return("#A9A9A9")
  }
}

# Apply the fill color function
data$Fill <- sapply(data$Normalized_Gene_Count, fill_color)

# Plot bar graph with correct colors
bar_plot <- ggplot(data, aes(x=Normalized_Gene_Count, fill=Fill)) +
  geom_histogram(binwidth = 0.1, color="black") +
  scale_fill_identity() +
  scale_y_log10(breaks = scales::trans_breaks("log10", function(x) 10^x),
                labels = scales::trans_format("log10", scales::math_format(10^.x))) +
  labs(x = "Frequency", y = "No. of genes") +
  theme_minimal()

# Plot pie chart
pie_plot <- ggplot(category_count, aes(x="", y=Count, fill=Category)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  theme_void() +
  scale_fill_manual(values=c("Core"="#FFD700", "SoftCore"="#FF69B4", "Shell"="#D3D3D3", "Cloud"="#A9A9A9")) +
  theme(legend.position = "right")

# Combine plots and save to file
pdf("PAV_wild.pdf", width = 15, height = 6)
grid.arrange(bar_plot, pie_plot, ncol=2)
dev.off()
