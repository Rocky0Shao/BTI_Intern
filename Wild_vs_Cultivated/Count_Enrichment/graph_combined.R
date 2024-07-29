# Load necessary libraries
library(ggplot2)
library(dplyr)

# Read the data
data <- read.table("C:/Users/Rocky/Desktop/BTI_Git/BTI_Intern/Wild_vs_Cultivated/Count_Enrichment/w_c_total_results.txt", header = TRUE, sep = "\t")

# Create0+ subsets for each GO Category
molecular_function <- data %>% filter(GO.Category == "MOLECULAR_FUNCTION")
biological_process <- data %>% filter(GO.Category == "BIOLOGICAL_PROCESS")
cellular_component <- data %>% filter(GO.Category == "CELLULAR_COMPONENT")

# Combine the subsets into one total set in the specified order
combined_data <- rbind(molecular_function, biological_process, cellular_component)

# Sort the combined data by GO.Name
combined_data <- combined_data %>% arrange(GO.Name)

# Function to create the combined plot
create_combined_plot <- function(data) {
  ggplot(data, aes(x = Nr.Reference, y = reorder(GO.Name, GO.Category), fill = `Adj..P.value`)) +
    geom_bar(stat = "identity") +
    scale_fill_gradient(low = "darkgreen", high = "lightgreen", name = "FDR") +
    labs(title = "GO Categories", x = "Gene count", y = NULL) +
    theme_minimal() +
    theme(axis.text.y = element_text(size = 8))
}

# Create the combined plot
combined_plot <- create_combined_plot(combined_data)

# Save the plot to a PDF
pdf("Wild_vs_Cultivated/Count_Enrichment/combined.pdf", height = 10, width = 8.5)
print(combined_plot)
dev.off()
