clean_data <- read.csv("cleaned_sp500_data.csv")


# lm model
# EPS and market cap is the predictor, controlled for dividend, P/S and P/B
model <- lm(log(Price.Earnings) ~ log(Earnings.Share) + log(Market.Cap) + log(Dividend.Yield) + log(Price.Sales) + log(Price.Book), data = clean_data)
summary(model)

# The model overall is statistically significant since p-value: < 2.2e-16.
# EPS is a strong predictor. highly significant
# Market capitalization is not statistically significant. 

# log scaling all axis for better visualization (reduce effects of outliers)

# plotting EPS against P/E
png("EPSvsPE.png")
plot(log(clean_data$Earnings.Share), log(clean_data$Price.Earnings), 
     main = "Effect of EPS on P/E Ratio (Logged)",
     xlab = "Earnings Per Share (EPS)", 
     ylab = "Price to Earnings (P/E) Ratio")
abline(lm(log(Price.Earnings) ~ log(Earnings.Share), data = clean_data), col = "royalblue", lwd = 2)
dev.off()

# plotting market cap against P/E
png("MCvsPE.png")
plot(log(clean_data$Market.Cap), log(clean_data$Price.Earnings), 
     main = "Effect of Market Cap on P/E Ratio (Logged)",
     xlab = "Market Capitalization", 
     ylab = "Price to Earnings (P/E) Ratio")
abline(lm(log(Price.Earnings) ~ log(Market.Cap), data = clean_data), col = "plum", lwd = 2)
dev.off()

# Plotting Dividend Yield vs P/E
png("DividendvsPE.png")
plot(log(clean_data$Dividend.Yield), log(clean_data$Price.Earnings),
     main = "Effect of Dividend Yield on P/E Ratio (Logged)",
     xlab = "Dividend Yield",
     ylab = "Price to Earnings (P/E) Ratio")
abline(lm(log(Price.Earnings) ~ log(Dividend.Yield), data = clean_data), col = "forestgreen", lwd = 2)
dev.off()

# Plotting Price to Sales vs P/E
png("PSvsPE.png")
plot(log(clean_data$Price.Sales), log(clean_data$Price.Earnings),
     main = "Effect of Price-to-Sales Ratio on P/E Ratio (Logged)",
     xlab = "Price-to-Sales Ratio",
     ylab = "Price to Earnings (P/E) Ratio")
abline(lm(log(Price.Earnings) ~ log(Price.Sales), data = clean_data), col = "darkorange", lwd = 2)
dev.off()

# Plotting Price to Book vs P/E
png("PBvsPE.png")
plot(log(clean_data$Price.Book), log(clean_data$Price.Earnings),
     main = "Effect of Price-to-Book Ratio on P/E Ratio (Logged)",
     xlab = "Price-to-Book Ratio",
     ylab = "Price to Earnings (P/E) Ratio")
abline(lm(log(Price.Earnings) ~ log(Price.Book), data = clean_data), col = "brown", lwd = 2)
dev.off()

# From simple linear regression
# EPS has a clear negative relationship with P/E, which meet with the mathematical formula of the P/E ratio. 
# Price-to-Sales and Price-to-Book ratios both show strong positive relationship with P/E, indicating that companies valued highly on a sales or book-value also tend to have higher P/E. 
# Dividend Yield shows a mild negative trend. 
# Market Capitalization shows almost no trend, indicating that company size alone does not meaningfully predict valuation as measured by P/E.


