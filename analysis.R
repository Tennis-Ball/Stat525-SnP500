clean_data <- read.csv("cleaned_sp500_data.csv")


# lm model
# EPS and market cap is the predictor, controlled for dividend, P/S and P/B
model <- lm(Price.Earnings ~ Earnings.Share + Market.Cap + Dividend.Yield + Price.Sales + Price.Book, data = clean_data)
summary(model)

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