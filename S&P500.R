data <- read.csv("S&P500data.csv")

cat("Column names:\n")
print(names(data))
cat("\nFirst few rows:\n")
print(head(data))


# These are the predictors and response variable for your regression model
selected_data <- data[, c("Price.Earnings", 
                          "Earnings.Share", 
                          "Market.Cap", 
                          "Dividend.Yield", 
                          "Price.Sales", 
                          "Price.Book")]


cat("\nMissing values in each column:\n")
print(colSums(is.na(selected_data)))

clean_data <- na.omit(selected_data)

cat("\nNumber of rows before cleaning:", nrow(selected_data), "\n")
cat("Number of rows after cleaning:", nrow(clean_data), "\n")

cat("\nPreview of cleaned data:\n")
print(head(clean_data))

