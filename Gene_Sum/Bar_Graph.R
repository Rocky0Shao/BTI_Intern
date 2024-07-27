# Load necessary libraries
library(ggplot2)

# Define the function to create a bar plot from a TSV file
create_bar_plot <- function(file_path) {
  # Read the TSV file
  data <- read.table(file_path, header = TRUE, sep = "\t")
  
  # Convert the data to long format for ggplot2
  data_long <- data.frame(Element = names(data), Value = as.numeric(data[1, ]))
  
  # Reorder the elements based on the Value
  data_long$Element <- factor(data_long$Element, levels = data_long$Element[order(data_long$Value)])
  
  # Create the bar plot
  plot <- ggplot(data_long, aes(x = Element, y = Value)) +
    geom_bar(stat = "identity", fill = "skyblue") +
    theme_minimal() +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1),
      # panel.grid.major = element_blank(), 
      # panel.grid.minor = element_blank()
    ) +
    labs(title = basename(file_path), x = "Gene Name", y = "Gene Family Num") +
    coord_cartesian(ylim = c(20000, max(data_long$Value, na.rm = TRUE))) +
    geom_vline(xintercept = 0, color = "black")   
  
  return(plot)
}

# Path to the specific TSV file
file_path <- "Gene_Sum/sum_I_default.tsv"

# Create the plot
plot <- create_bar_plot(file_path)

# Save the plot as a PDF
pdf("Gene_Sum/Gene Family Num.pdf", width = 10, height = 7)
print(plot)
dev.off()

print("Bar graph saved as Gene_Sum/Gene Family Num.pdf")

