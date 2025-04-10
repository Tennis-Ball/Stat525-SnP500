# -------------------------------------
# STEP 1: Read the CSV file
# -------------------------------------
# Make sure the CSV file is in your working directory
# You can also provide a full path like "C:/Users/YourName/Documents/S&P500data.csv"
data <- read.csv("S&P500data.csv")

# -------------------------------------
# STEP 2: View column names and data preview (optional)
cat("Column names:\n")
print(names(data))
cat("\nFirst few rows:\n")
print(head(data))

# -------------------------------------
# STEP 3: Select relevant columns
# These are the predictors and response variable for your regression model
selected_data <- data[, c("Price.Earnings", 
                          "Earnings.Share", 
                          "Market.Cap", 
                          "Dividend.Yield", 
                          "Price.Sales", 
                          "Price.Book")]

# -------------------------------------
# STEP 4: Check for missing values
cat("\nMissing values in each column:\n")
print(colSums(is.na(selected_data)))

# -------------------------------------
# STEP 5: Remove rows with missing data
clean_data <- na.omit(selected_data)

# -------------------------------------
# STEP 6: Compare rows before and after cleaning
cat("\nNumber of rows before cleaning:", nrow(selected_data), "\n")
cat("Number of rows after cleaning:", nrow(clean_data), "\n")

# -------------------------------------
# STEP 7: Preview the cleaned data
cat("\nPreview of cleaned data:\n")
print(head(clean_data))

