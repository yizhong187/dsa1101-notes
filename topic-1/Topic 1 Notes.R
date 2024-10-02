##############  TOPIC 1 - INTRODUCTION TO R

# creating a vector of numbers:
number<-c(2,4,6,8,10);

# creating a vector of strings/characters:
string<-c("weight", "height", "gender");

# creating a Boolean vector (T/F):
logic<- c(T, T, F, F, T);

# numeric() creates a vector of 0s
number.2<-numeric(3)

# appending two vectors
c(number, number.2)

# rep(a,b): replicate the item a by b times where a could be a number or a vector
number.3<-rep(2,3);
number.3<-rep(c(1,2),3)
rep(string,2)

# seq(from, to, by): generate a sequence inclusive of starting and ending, incrementing by
seq(from=2, to=10, by=2)
seq(2,10,2)

# seq(from, to, length): length specifies number of values, spacing them equally
seq(from=2, to=10, length = 5)

# a sequence from 1 up to 10, distance by 1
seq(10)

# select elements at some indices
indices <- c(1,5,7)
x <- c(2, 3, 5, 6, 1, 3, 6, 8, 4, 3, 5, 7, 9, 5, 3, 2, 1)
selected.x = x[indices]

#---------------------------------------------

# matrix in this format will fill by col, so [[1,3,5],[2,4,6]]
m <- matrix(c(1:6), nrow=2, ncol=3); 

# to fill the matrix by rows:
m <- matrix(c(1:6), nrow=2, ncol=3, byrow=T)

# rbind(vector_a, vector_b) will stack the vectors atop each other to form a matrix
a <- c(1,2,3,4)
b <- c(5,6,7,8)
ab_row <- rbind(a,b)

# cbind(vector_a, vector_b) similar to rbind but col wise
ab_col = cbind(a,b)
ab_col.try <- cbind(ab_row, c(9,10))

#-------------------------------------------

# lists can have mixed types
list.1 <- list(10.5, 20, TRUE, "Daisy")

x = c(2,4,6,8) # length 4
y = c(T, F, T) # length 3

# assign names to list members and you can access members by index or name
list.2 = list(A = x, B = y) 
list.2[1] 
list.2$A 

# single square brackets is basically list slicing
# double square brackets is actually retreiving the value
list.1[1]
list.1[1]*2 # cannot perform multiplication to a list
list.1[[1]]*2 # works

#-----------------------------------------

# Manually creating a dataframe (rare)
height = c(1.6, 1.8, 1.7) # height of 3 people in meter
weight = c(46, 75, 68) # weight of them in kg
HW = data.frame(height, weight)

## Importing a file (csv usually) as a dataframe
setwd("/Users/yizhong/School/Y2S1/DSA1101/Data")

# read.csv allows for optional args 
# sep: field separator; header: whether there is are column names or not
data1<-read.csv("lung_cancer.csv")

# get the names of the column
names(data1) 
head(data1)

# col.names param in read.table for specifying column names
# read.table is a more generalised version of read.csv
varnames <- c("Subject", "Gender", "CA1", "CA2", "HW")
data2<-read.table("C:/Data/ex_1.txt", header = FALSE,
                  col.names = varnames)

# dataframe.name[rows.to.retrieve, cols.to.retrieve]
# syntax similar to slicing in python, but starts from 1 and always inclusive
data1[,1] # first column
data1[,2:4] # all columns from 2 up to 4
data1[1:2,] # row 1 to row 2
data1[3,3] # value at 3rd row & 3rd column
data1[3,4] # value at 3rd row & 4th column

data3<-read.table("ex_1_name.txt", header = TRUE)
head(data3)

# all the rows (observations) whose gender = M:
data3[data3$Gender == "M",]

#all the rows (observations) whose gender = M and CA2>85
data3[Gender == "M" & CA2 > 85,]

# indices of all the rows where gender = M
which(data3$Gender == "M")

# indices of rows where gender = M and CA2>85
which(data3$Gender == "M" & data3$CA2 > 85)

# converts the Gender column into a categorical one
data1$Gender <- factor(data1$Gender)


#-----------------------------------------

# while loop
x = 1
while (x <= 3) {
  print("x is less than 4")
  x = x + 1
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
x = c(1:8);
x = ifelse(x%%2 == 0, "even", "odd")
x

#-----------------------------------------

# ifelse(cond, yes, no)
x = c(1:8);x
x = ifelse(x%%2 == 0, "even", "odd")
x

#-----------------------------------------

# sort(vector)
x = c(1,4,4,6,3,2,7,5,4,8,5,9,10)
y = c(3,2,2,5,6,1,3,4,8,4,2,6,8)

# Sort in incringase order
sorted.x = sort(x)

# find indicies of 3 smallest elements in x
smallest.3.indices = which(x <= sorted.x[3])

# Sort in decreasing order
sorted.x = sort(x, decreasing = TRUE)

# find indicies of 3 largest elements in x
largest.3.indices = which(x >= sorted.x[3])

#-----------------------------------------

#functions
find.sum = function(x = 1, y) { 
  s = sum(x)
  return(s*y)
}

