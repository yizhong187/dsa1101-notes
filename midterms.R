# TOPIC 1: INTRO TO R
# creating a vector of numbers:
number <- c(2, 4, 6, 8, 10)
# creating a vector of strings/characters:
string <- c("weight", "height", "gender")
# creating a Boolean vector (T/F):
logic <- c(T, T, F, F, T)
# numeric() creates a vector of 0s
number.2 <- numeric(3)

# appending two vectors
c(number, number.2)

# rep(a,b): replicate the item a by b times where a could be a number or a vector
number.3 <- rep(2, 3)
number.3 <- rep(c(1, 2), 3)
rep(string, 2)

# seq(from, to, by): generate a sequence inclusive of starting and ending, incrementing by
seq(from = 2, to = 10, by = 2)
seq(2, 10, 2)

# seq(from, to, length): length specifies number of values, spacing them equally
seq(from = 2, to = 10, length = 5)

# a sequence from 1 up to 10, distance by 1
seq(10)

#---------------------------------------------

# matrix in this format will fill by col, so [[1,3,5],[2,4,6]]
m <- matrix(c(1:6), nrow = 2, ncol = 3)
# to fill the matrix by rows:
m <- matrix(c(1:6), nrow = 2, ncol = 3, byrow = T)

# rbind(vector_a, vector_b) will stack the vectors atop each other to form a matrix
a <- c(1, 2, 3, 4)
b <- c(5, 6, 7, 8)
ab_row <- rbind(a, b)

# cbind(vector_a, vector_b) similar to rbind but col wise
ab_col <- cbind(a, b)
ab_col.try <- cbind(ab_row, c(9, 10))

#-------------------------------------------

# lists can have mixed types
list.1 <- list(10.5, 20, TRUE, "Daisy")

x <- c(2, 4, 6, 8) # length 4
y <- c(T, F, T) # length 3

# assign names to list members and you can access members by index or name
list.2 <- list(A = x, B = y)
list.2[1]
list.2$A

# single square brackets is basically list slicing
# double square brackets is actually retreiving the value
list.1[1]
list.1[1] * 2 # cannot perform multiplication to a list
list.1[[1]] * 2 # works

#-----------------------------------------

# Manually creating a dataframe (rare)
height <- c(1.6, 1.8, 1.7) # height of 3 people in meter
weight <- c(46, 75, 68) # weight of them in kg
HW <- data.frame(height, weight)

## Importing a file (csv usually) as a dataframe
setwd("/Users/yizhong/School/Y2S1/DSA1101/Data")

# read.csv allows for optional args
# sep: field separator; header: whether there is are column names or not
data1 <- read.csv("lung_cancer.csv")

# get the names of the column
names(data1)
head(data1)

# col.names param in read.table for specifying column names
# read.table is a more generalised version of read.csv
varnames <- c("Subject", "Gender", "CA1", "CA2", "HW")
data2 <- read.table("C:/Data/ex_1.txt",
    header = FALSE,
    col.names = varnames
)

# dataframe.name[rows.to.retrieve, cols.to.retrieve]
# syntax similar to slicing in python, but starts from 1 and always inclusive
data1[, 1] # first column
data1[, 2:4] # all columns from 2 up to 4
data1[1:2, ] # row 1 to row 2
data1[3, 3] # value at 3rd row & 3rd column
data1[3, 4] # value at 3rd row & 4th column

data3 <- read.table("ex_1_name.txt", header = TRUE)
head(data3)

# all the rows (observations) whose gender = M:
data3[data3$Gender == "M", ]

# all the rows (observations) whose gender = M and CA2>85
data3[Gender == "M" & CA2 > 85, ]

# indices of all the rows where gender = M
which(data3$Gender == "M")

# indices of rows where gender = M and CA2>85
which(data3$Gender == "M" & data3$CA2 > 85)

# converts the Gender column into a categorical one
data1$Gender <- factor(data1$Gender)


#-----------------------------------------

# while loop
x <- 1
while (x <= 3) {
    print("x is less than 4")
    x <- x + 1
}

# for loop
for (i in 1:10) {
    print(paste("i =", i))
}

for (num in c(1, 2, 3, 4, 5)) {
    print(element)
}

#-----------------------------------------

# if else
grade <- 85
if (grade >= 90) {
    print("Grade: A")
} else if (grade >= 80) {
    print("Grade: B")
} else if (grade >= 70) {
    print("Grade: C")
} else if (grade >= 60) {
    print("Grade: D")
} else {
    print("Grade: F")
}

# ternary operator
x <- c(1:8)
x <- ifelse(x %% 2 == 0, "even", "odd")
x

#-----------------------------------------

# ifelse(cond, yes, no)
x <- c(1:8)
x
x <- ifelse(x %% 2 == 0, "even", "odd")
x

#-----------------------------------------

# sort(vector)
x <- c(1, 4, 4, 6, 3, 2, 7, 5, 4, 8, 5, 9, 10)
sorted.x <- sort(x)
top.3.indices <- which(x <= sorted.x[3])

#-----------------------------------------

# functions
find.sum <- function(x = 1, y) {
    s <- sum(x)
    return(s * y)
}

# To sort a column and preserve the original indices
sorted_indices <- order(vector)
sorted_vector <- vector[sorted_indices]
sorted_df <- data.frame(original_index = sorted_indices, sorted_values = sorted_vector)

# To sort a data frame by a certain column
sorted_df <- df[order(df$column1), ]

# Create new column in DF using another column
df <- data.frame(
    name = c("Alice", "Bob", "Charlie", "David"),
    age = c(23, 35, 28, 15)
)

# Create a new categorical column 'age_group' with default value 1
df$age_group <- "1"

# Use which() to modify rows based on the condition
df$age_group[which(df$age >= 30)] <- "2"
df$age_group[which(df$age < 18)] <- "0"


# TOPIC 2: PROBABILITY & STATISTICS
sales <- read.csv("yearly_sales.csv")

# to get a summary of the data
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

# CONTINGENCY TABLE / CONFUSION MATRIX
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


# TOPIC 3: LINEAR REGRESSION
x <- c(-1, 3, 5)
x1 <- c(2, 4, 7)
x2 <- c(0, 2, 8)
y <- c(-1, 3.5, 3)
model <- lm(y ~ x + x1 + x2)
summary(model)

n <- dim(data)[1] # total number of rows/observations
index <- sample(1:n)[1:(0.8 * n)] # indexes of rows belonging to training data
train_data <- data[index, ]
test_data <- data[-index, ]

data$y <- as.factor(data$y) # if y is a categorical variable

# TOPIC 4: KNN
library("class")
# k = k for KNN, input = the input variables (can be multiple columns),
# response = response variable (should be one col), training_frac = proportion of data used for training (between 0 and 1)
single_knn <- function(k, input, response, training_frac) {
    set.seed(1)
    index <- sample(1:dim(input)[1], training_frac * dim(input)[1])
    train_data <- input[index, ]
    train_response <- response[index]
    test_data <- input[-index, ]
    test_response <- response[-index]

    pred <- knn(train_data, test_data, train_response, k)
    confusion.matrix <- table(pred, test_response)
    print(confusion.matrix)
    # modify according to the actual confusion matrix, this assumes that it is of the form 0,1
    accuracy <- sum(diag(confusion.matrix)) / sum(confusion.matrix)
    TPR <- confusion.matrix[2, 2] / sum(confusion.matrix[, 2])
    FPR <- confusion.matrix[2, 1] / sum(confusion.matrix[, 1])
    FNR <- confusion.matrix[1, 2] / sum(confusion.matrix[, 2])
    precision <- confusion.matrix[2, 2] / sum(confusion.matrix[2, ])

    return(cbind(c("acc", "TPR", "FPR", "FNR", "precision"), c(accuracy, TPR, FPR, FNR, precision)))
}

# Performs n_fold knn and returns the array of err & acc
n_fold_knn <- function(n_folds, inputs, response, k) {
    folds_j <- sample(rep(1:n_folds, length.out = dim(inputs)[1]))
    err <- numeric(n_folds)
    acc <- numeric(n_folds)
    for (j in 1:n_folds) {
        test_j <- which(folds_j == j) # vector of indices corresponding to the fold

        train.x <- inputs[-test_j, ] # item 1
        test.x <- inputs[test_j, ] # item 2
        train.y <- response[-test_j] # item 3

        # KNN with k = 1, 5, 10, etc
        pred <- knn(train.x, test.x, train.y, k)

        # Y[test_j] == pred returns a logical vector (TRUE == 1, FALSE == 0)
        err[j] <- mean(response[test_j] != pred)
        acc[j] <- mean(response[test_j] == pred)
    }
    return(rbind(err, acc))
}

# TOPIC 5: DECISION TREE
library("rpart")
library("rpart.plot")
# Decision Tree
decision <- rpart( # y ~ x1 + x2,
    method = "class",
    data = df, # change to the data frame used
    control = rpart.control(minsplit = 1), # max depth=4
    parms = list(split = "information")
)

# To view the plotted decision tree
rpart.plot(decision, type = 4, extra = 2, clip.right.labs = FALSE, varlen = 0, faclen = 0)
