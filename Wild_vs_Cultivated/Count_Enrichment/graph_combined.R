# Load necessary libraries
library(ggplot2)
library(dplyr)
library(forcats)
library(conflicted)

conflict_prefer("filter", "dplyr")
conflict_prefer("lag", "dplyr")
conflict_prefer("intersect", "base")
conflict_prefer("setdiff", "base")
conflict_prefer("setequal", "base")
conflict_prefer("union", "base")

print("Start Running")

# Read the data
data <- read.table("C:/Users/Rocky/Desktop/BTI_Git/BTI_Intern/Wild_vs_Cultivated/Count_Enrichment/w_c_total_results.tsv", header = TRUE, sep = "\t")

# Convert GO.Category to a factor with a specified order
data$GO.Category <- factor(data$GO.Category, levels = c("MOLECULAR_FUNCTION", "BIOLOGICAL_PROCESS", "CELLULAR_COMPONENT"))
# Determine the range of Adj..P.value for color scaling
min_p_value <- min(data$`Adj..P.value`, na.rm = TRUE)
max_p_value <- max(data$`Adj..P.value`, na.rm = TRUE)
# Function to create the combined plot
create_combined_plot <- function(data) {
  ggplot(data, aes(x = Nr.Reference, y = reorder(GO.Name, as.numeric(GO.Category)), fill = `Adj..P.value`), limits = c(min_p_value,max_p_value)) +
    geom_bar(stat = "identity") +
    scale_fill_gradientn(
      colours = c("darkgreen", "lightgreen"),
      values = scales::rescale(c(min_p_value, max_p_value)),
      name = "P Value"
    )  +
    labs(title = "PAV Selection Analysis", x = "Gene count", y = "GO Categories") +
    theme_minimal() +
    theme(axis.text.y = element_text(size = 8 , hjust = 1),panel.border = element_rect(colour = "black", fill = NA, size = 1))
        # theme(axis.text.y = element_text(size = 8 ))

}


# Create the combined plot
combined_plot <- create_combined_plot(data)

# Save the plot to a PDF
pdf("Wild_vs_Cultivated/Count_Enrichment/combined.pdf", height = 5, width = 8.5)
print(combined_plot)
dev.off()

print("DONE")
