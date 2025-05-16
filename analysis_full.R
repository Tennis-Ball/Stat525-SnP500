# According to the written report rubric we need additional plots so this file makes them

# Load required packages
if (!require(car)) install.packages("car", dependencies=TRUE)
if (!require(broom)) install.packages("broom", dependencies=TRUE)
library(car)
library(broom)

# Read cleaned data
data_path <- "cleaned_sp500_data.csv"
clean_data <- read.csv(data_path)

# Example of pre and post log transformation on variable
pre <- (clean_data$Price.Book)
pre[is.infinite(pre)] <- NA # drop zero/negative
png("Histogram_RawPB.png", width = 800, height = 600)
hist(
  pre,
  breaks = 30,
  main = "Histogram of P/B Ratio (Raw)",
  xlab = "log(Price/Book)",
  col = "tomato1",
  border = "black"
)
dev.off()

post <- log(clean_data$Price.Book)
post[is.infinite(post)] <- NA # drop zero/negative
png("Histogram_LogPB.png", width = 800, height = 600)
hist(
  post,
  breaks = 30,
  main = "Histogram of P/B Ratio (Log)",
  xlab = "log(Price/Book)",
  col = "forestgreen",
  border = "black"
)
dev.off()

# Log-transformed histogram
g <- log(clean_data$Price.Earnings)
g[is.infinite(g)] <- NA # drop zero/negative
png("Histogram_LogPE.png", width = 800, height = 600)
hist(
  g,
  breaks = 30,
  main = "Histogram of Log(P/E) Ratio",
  xlab = "log(Price/Earnings)",
  col = "tomato1",
  border = "black"
)
dev.off()

# Fit linear model on log-transformed variables
model <- lm(
  log(Price.Earnings) ~
    log(Earnings.Share) +
    log(Market.Cap) +
    log(Dividend.Yield) +
    log(Price.Sales) +
    log(Price.Book),
  data = clean_data
)

# Compute 99th percentile of P/E for axis limits
pe99 <- quantile(clean_data$Price.Earnings, 0.99, na.rm = TRUE)

# 1. Histograms of outcome
# Raw P/E histogram (focus on central 99%)
png("Histogram_PE.png", width = 800, height = 600)
hist(
  clean_data$Price.Earnings,
  breaks = 100,
  xlim = c(0, pe99),
  main = "Histogram of P/E Ratio (0–99th percentile)",
  xlab = "Price/Earnings",
  col = "forestgreen",
  border = "black"
)
dev.off()

# Log-transformed histogram
g <- log(clean_data$Price.Earnings)
g[is.infinite(g)] <- NA  # drop zero/negative
png("Histogram_LogPE.png", width = 800, height = 600)
hist(
  g,
  breaks = 30,
  main = "Histogram of Log(P/E) Ratio",
  xlab = "log(Price/Earnings)",
  col = "tomato1",
  border = "black"
)
dev.off()

# 2. Descriptive statistics for each variable
vars <- c(
  "Price.Earnings", "Earnings.Share", "Market.Cap",
  "Dividend.Yield", "Price.Sales", "Price.Book"
)
stats <- data.frame(
  Variable = vars,
  Mean = sapply(clean_data[vars], mean, na.rm = TRUE),
  Median = sapply(clean_data[vars], median, na.rm = TRUE),
  SD = sapply(clean_data[vars], sd, na.rm = TRUE),
  Q1 = sapply(clean_data[vars], function(x) quantile(x, .25, na.rm = TRUE)),
  Q3 = sapply(clean_data[vars], function(x) quantile(x, .75, na.rm = TRUE))
)
print(stats)


# 3. Scatterplot matrix and correlation matrix (log-transformed)
png("Scatterplot_Matrix.png", width = 1000, height = 1000)
pairs(
  log(clean_data[vars] + 1),  # offset zeros
  main = "Scatterplot Matrix (Log-Transformed)"
)
dev.off()

# Print correlation matrix
corr_mat <- cor(log(clean_data[vars] + 1), use = "pairwise.complete.obs")
print(corr_mat)

# 4. Residual diagnostics
res <- residuals(model)
fitted_vals <- fitted(model)

# Histogram of residuals
png("Residuals_Histogram.png", width = 800, height = 600)
hist(
  res,
  breaks = 30,
  main = "Histogram of Residuals",
  xlab = "Residuals",
  col = "royalblue",
  border = "black"
)
dev.off()

# Boxplot of residuals
png("Residuals_Boxplot.png", width = 800, height = 600)
boxplot(
  res,
  main = "Boxplot of Residuals",
  ylab = "Residuals",
  col = "lightgray"
)
dev.off()

# Q-Q plot of residuals
png("Residuals_QQ.png", width = 800, height = 600)
qqnorm(res, main = "Normal Q-Q Plot")
qqline(res, col='red2', lwd=2)
dev.off()

# Residuals vs Fitted with reference line
png("Residuals_vs_Fitted.png", width = 800, height = 600)
plot(
  fitted_vals, res,
  main = "Residuals vs Fitted Values",
  xlab = "Fitted Values",
  ylab = "Residuals"
)
abline(h = 0, lty = 2)
dev.off()

# 5. Regression coefficients, standard errors, and p-values
coef_table <- broom::tidy(model)
print(coef_table)

# 6. Model fit statistics (R-squared, Adjusted R-squared, etc.)
glance_stats <- broom::glance(model)
print(glance_stats)

# 7. Variance Inflation Factors for multicollinearity check
vif_values <- vif(model)
print(vif_values)
