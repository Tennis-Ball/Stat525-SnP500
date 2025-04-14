data <- read.csv("S&P500data.csv", na.strings = "null")

selected_data <- data[, c("Price.Earnings", 
                          "Earnings.Share", 
                          "Market.Cap", 
                          "Dividend.Yield", 
                          "Price.Sales", 
                          "Price.Book")]

selected_data <- as.data.frame(lapply(selected_data, function(x) as.numeric(as.character(x))))

cat("Missing values per column:\n")
print(colSums(is.na(selected_data)))

clean_data <- na.omit(selected_data)

cat("Rows before cleaning:", nrow(selected_data), "\n")
cat("Rows after cleaning:", nrow(clean_data), "\n")

head(clean_data)

