required_packages <- c(
  "plyr",      # Data manipulation
  "quantmod",  # Financial data and technical analysis
  "TTR",       # Technical Trading Rules
  "ggplot2",   # Data visualization
  "scales"     # Scaling and formatting axes in ggplot2
)

install_if_missing <- function(package) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}

sapply(required_packages, install_if_missing)

cat("All required packages are installed and loaded successfully.\n")