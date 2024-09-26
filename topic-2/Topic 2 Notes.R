####  TOPIC 2: BASIC PROBABILITY & STATISTICS

setwd("/Users/yizhong/School/Y2S1/DSA1101/Data") # student needs to change it accordingly

sales <- read.csv("yearly_sales.csv")

head(sales)
total <- round(sales$sales_total, digits = 2)

n <- length(total)
n
summary(total)

range(total)
var(total)
sd(total)
IQR(total)
total[order(total)[1:5]] # The 5 smallest observations
total[order(total)[(n - 4):n]] # The 5 largest observations





# HISTOGRAM in FREQUENCY
hist(total,
     freq = TRUE, main = paste("Histogram of Total Sales"),
     xlab = "total", ylab = "Frequency", col = "blue"
)

# HISTOGRAM WITH DENSITY LINE
hist(total,
     freq = FALSE, main = paste("Histogram of total sales"),
     xlab = "total", ylab = "Probability",
     col = "blue", ylim = c(0, 0.005)
)
lines(density(total), col = "red") # this is the density curve of "total"

hist(total,
     freq = FALSE, main = paste("Histogram of total sales"),
     xlab = "total", ylab = "Probability",
     col = "blue"
)
lines(density(total), col = "red")
# this is the density curve of "total", however it is cut off at the top part
# since the shown y-axis is not long enough
# therefore, need to use the ylim argument to scale the y-axis

# HISTOGRAM WITH NORMAL DENSITY
hist(total,
     freq = FALSE, main = paste("Histogram of Total Sales"),
     xlab = "total sales", ylab = "Probability",
     col = "grey", ylim = c(0, 0.002)
)

# Creates a sequence of n evenly spaced values from
# 0 to the maximum value in total.
x <- seq(0, max(total), length.out = n)

# Computes the normal density values for the sequence x
# using the mean and standard deviation of total.
y <- dnorm(x, mean(total), sd(total))


lines(x, y, col = "red") # this is the normal density curve






# BOX PLOTS
boxplot(total, xlab = "Total Sales", col = "blue")

# get the values that are outliers
outlier <- boxplot(total)$out
outlier

# count the number of outliers:
length(outlier) # 772 points that are outliers

# get the indexes of the outlier points
index <- which(total %in% outlier)
index

# information of all the outliers:
sales[c(index), ]





# QQ plot
qqnorm(total, main = "QQ Plot", pch = 20) # QQ plot of total
qqline(total, col = "red") # reference line for given the QQ plot.




# CORRELATION COEFFICIENT
order <- sales$num_of_orders
cor(total, order) # 0.75




# SCATTER PLOT
plot(order, total, pch = 20, col = "darkblue")




# BOX PLOTS OF MULTIPLE GROUP
boxplot(total ~ sales$gender, col = "blue")



# 3 VARIABLES = SCATTER PLOT ADDING LEGEND
order <- sales$num_of_orders

attach(sales)

plot(order, total, type = "n") # a scatter plot with no point added
points(order[gender == "M"], total[gender == "M"], pch = 2, col = "blue") # MALE
points(order[gender == "F"], total[gender == "F"], pch = 20, col = "red") # FEMALE
legend(1, 7500, legend = c("Female", "Male"), col = c("red", "blue"), pch = c(20, 2))
# (x = 1, y =7500) tells R the place where you want to put the legend box in the plot
# do note on the size of the points since the points added latter will overlay on the points added earlier
# hence, the points added latter should be chosen with smaller size so that they will not cover the points earlier


# BARPLOT FOR CATEGORICAL VARIABLE
count <- table(data1$Gender)
count # frequency table
barplot(count)

# PIE CHART
pie(count)



# CATEGORIZING "ORDER"
order <- sales$num_of_orders
order.size <- ifelse(order <= 5, "small", "large")
table(order.size)

numbers <- c(1, 2, 3, 4, 5)
result <- ifelse(numbers %% 2 == 0, "Even", "Odd")
# [1] "Odd"  "Even" "Odd"  "Even" "Odd"


sales$gender <- factor(sales$gender)

# CONTINGENCY TABLE
table <- table(sales$gender, order.size)
table
# 1st argument for independent variable, 2nd for response

tab <- prop.table(table, "gender") # proportion by gender (does not really work)
tab <- prop.table(table, margin = 1) # proportion across rows
tab <- prop.table(table, margin = 1) # proportion across columns
tab

tab[1] / (1 - tab[1]) # the odds of large order among FEMALES

tab[2] / (1 - tab[2]) # the odds of large order among MALES

OR <- (tab[1] / (1 - tab[1])) / (tab[2] / (1 - tab[2]))
OR # 0.76
# it means: the odds of larger orders among females is 0.76 times the odds of large orders among males.
