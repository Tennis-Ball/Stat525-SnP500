if (!require(car)) install.packages("car", dependencies = TRUE)
if (!require(broom)) install.packages("broom", dependencies = TRUE)
library(car)
library(broom)
if (!require(corrplot)) install.packages("corrplot", dependencies = TRUE)
library(corrplot)

# read cleaned data
data_path <- "cleaned_sp500_data.csv"
clean_data <- read.csv(data_path)

vars <- c(
    "Price.Earnings", "Earnings.Share", "Market.Cap",
    "Dividend.Yield", "Price.Sales", "Price.Book"
)

# get the correlations on the log-transformed data
corr_mat <- cor(log(clean_data[vars] + 1),
    use = "pairwise.complete.obs"
)

# plot
corrplot(
    corr_mat,
    method = "color", # colored squares
    type   = "full",
    order = "hclust", # cluster variables for a nicer layout
    tl.col = "black", # axis label color
    addCoef.col = "white", # show correlation coefficients
    number.cex = 0.7, # size of coefficient text
    diag = TRUE
)