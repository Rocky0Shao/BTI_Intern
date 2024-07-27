#first read the file called w_c_total_results.txt

#I want 3 separet graph for 3 bio processes: MOLECULAR_FUNCTION, BIOLOGICAL_PROCESS, CELLULAR_COMPONENT.They're in the GO Category  header

#graph out the graph like the example graph, I want the 3 separated graph stacked vertically on eachother in pdf format.

#the Gene Count x axix value should be the value under the header Nr Reference

#The y axis should be under the GO Name header

# Load necessary libraries
library(ggplot2)
library(dplyr)

# Read the data
data <- read.table("w_c_total_results.txt", header = TRUE, sep = "\t")

# Create subsets for each GO Category
molecular_function <- data %>% filter(GO.Category == "MOLECULAR_FUNCTION")
biological_process <- data %>% filter(GO.Category == "BIOLOGICAL_PROCESS")
cellular_component <- data %>% filter(GO.Category == "CELLULAR_COMPONENT")

# Function to create the plot
create_plot <- function(data, title) {
  ggplot(data, aes(x = Nr.Reference, y = GO.Name, fill = `Adj..P.value`)) +
    geom_bar(stat = "identity") +
    scale_fill_gradient(low = "darkgreen", high = "lightgreen", name = "FDR") +
    labs(title = title, x = "Gene count", y = NULL) +
    theme_minimal() +
    theme(axis.text.y = element_text(size = 8))
}

# Create the plots
p1 <- create_plot(molecular_function, "Molecular Function")
p2 <- create_plot(biological_process, "Biological Process")
p3 <- create_plot(cellular_component, "Cellular Component")

# Save the plots to a PDF
pdf("GO_category_plots.pdf", height = 14, width = 8.5)
gridExtra::grid.arrange(p1, p2, p3, ncol = 1)
dev.off()
