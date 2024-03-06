
# Setting my personal dataset
set.seed(7540) #Insert last 4 digits of SUID

#Importing Dataset
Redwine <- read.csv("C:\\Users\\shubham\\Documents\\Syracuse_ADS_Study\\Quants\\Final Exam\\Redwine.csv")
summary(Redwine)

myWine<-Redwine[sample(1:nrow(Redwine), 150, replace=FALSE),]

# 1.
summary(myWine)

hist(myWine$density)

hist(myWine$alcohol)

hist(myWine$chlorides)




# Frequentist 
  
model <- lm(density~ alcohol + chlorides,data = myWine)
summary(model)

# Bayesian

lmOut<-lmBF(formula = density ~ alcohol+chlorides,data = myWine,posterior = TRUE,iterations=10000)
summary(lmOut)

# Bayes Factor

lmOutBF<-lmBF(formula = density~alcohol+chlorides,data = myWine)
lmOutBF


# 2.

boxplot(alcohol~quality, data = myWine)

tapply(myWine$alcohol,myWine$quality,summary) 


myWine$quality <- factor(myWine$quality) # Convert variable into factors, used for categorical data

WOut <- aov(alcohol ~ quality, data = myWine) # ANOVA model

summary(WOut)

Tukey_result <- TukeyHSD(WOut) # Tukey test for HSD

print(Tukey_result)







anovaOut<-anovaBF(alcohol~quality, data = myWine)

anovaOut

mcmcmyWine<-posterior(anovaOut,iterations = 10000)
plot(mcmcExca[,"mu"])


# 3.

summary(mcmcExca)

boxplot(density~acidity, data = myWine)

tapply(myWine$density,myWine$acidity,summary) 
 

ExOut<-aov(density~acidity, data = myWine)
summary(ExOut)

TukeyHSD(ExOut)


myWine$acidity <- factor(myWine$acidity) # Convert variable into factors, used for categorical data

W_acidityOut <- aov(density ~ acidity, data = myWine) # ANOVA model

summary(W_acidityOut)

Tukey_result <- TukeyHSD(W_acidityOut) # Tukey test for HSD

print(Tukey_result)

anovaOut<-anovaBF(density~acidity, data = myWine)
anovaOut


# Install and load the MCMCpack package
install.packages("MCMCpack")
library(MCMCpack)


bayesOut <- MCMClogit(formula= acidity   ~  density, data = myWine)
summary(bayesOut) 

# Assuming 'myWine' is your data frame
cor(myWine$acidity, myWine$density)

# Print the correlation coefficient
print(correlation)




 
# 4. Time Series
 
Energy <- read.csv("C:\\Users\\shubham\\Documents\\Syracuse_ADS_Study\\Quants\\Final Exam\\Energy.csv")
summary(Energy)

TSbond<-as.data.frame(Energy)  # Saved to dataframe
View(TSbond)

summary(TSbond) #Summary statistics displayed for datafram TSbond

Series <- ts(TSbond[,2:3], start=c(2001,01), frequency=12) #timeseries created from mentioned start date with 12 frequency
plot(Series) 

decWind <- decompose(Series[,"wind"])
plot(decWind)

decOther <- decompose(Series[,"other"])
plot(decOther)


install.packages("tseries")
library(tseries)


adf.test(diff(Series[,"wind"]))
adf.test(diff(Series[,"other"]))

#Both are stationary


install.packages("changepoint")
library(changepoint)


diff(Series[,"wind"])
plot(diff(Series[,"wind"]))

diff(Series[,"other"])
plot(diff(Series[,"other"]))


bonds2 <- data.frame(decWind$random, decOther$random)
bonds2 <- bonds2[complete.cases(bonds2),]
bonds2 <- ts(bonds2,start=c(1993,12),frequency=12) 
summary(bonds2)
str(bonds2)
plot(bonds2)


# Calculate the standard deviation for both wind and other
volatility_wind <- sd(bonds2[, 1])  
volatility_other <- sd(bonds2[, 2])

# Display the calculated volatilities
print(paste("Volatility for Developing Asia: ", volatility_wind))
print(paste("Volatility for Latin America: ", volatility_other))

# Identify the region with the greatest overall volatility
greatest_volatility_energySource_production <- which.max(c(volatility_wind, volatility_other))

# Print the result
print(paste("Source with the greatest overall volatility: ", c("Wind", "other")[greatest_volatility_energySource_production]))


#number of changepoints in variance
cp1<-cpt.var(diff(Series[,"wind"]),method="PELT")
cp1
plot(cp1,cpt.col="Yellow",cpt.width=5)
cp1_dates <- time_points[cp1$method$estimates]

cp2<-cpt.var(diff(Series[,"other"]),method="PELT")
cp2
plot(cp2,cpt.col="Green",cpt.width=5)


------
  
  # Assuming 'Series' has a time column, adjust accordingly
  time_points <- Series$

# Changepoints for "wind" series
cp1 <- cpt.var(diff(Series[,"wind"]), method = "PELT")
plot(cp1, cpt.col = "Yellow", cpt.width = 5)
cp1_dates <- time_points[cp1$method$estimates]

# Changepoints for "other" series
cp2 <- cpt.var(diff(Series[,"other"]), method = "PELT")
plot(cp2, cpt.col = "Green", cpt.width = 5)
cp2_dates <- time_points[cp2$method$estimates]

# Print the years when changepoints occurred
print("Changepoints for 'wind' series:")
print(cp1_dates)
print("Changepoints for 'other' series:")
print(cp2_dates)





