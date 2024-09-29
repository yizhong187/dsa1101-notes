# TOPIC 5 - Decision Tree

### Overview on Decision Trees

Decision tree is a classification method. We focus on the **classification tree**, where the output is categorical.

Given a set of **features** $X = (x_1, x_2, ..., x_p)$, the goal is to predict a **response** or **output variable** $Y$ (categorical).

Each member of the set $(x_1, x_2, ..., x_p)$ is called an **input variable** or a **feature** which could be categorical or continuous.

### Example of Decision Tree

<div align="center">
  <img src="diagrams/decisiontree.png"  height="220">
</div>

1. **Nodes**:
   - These represent test points where decisions are made.
   - **Root Node**:
     - The topmost internal node, from which the tree starts.
   - **Internal Nodes**:
     - These represent decision or test points based on input variables or attributes.
     - Usually two branches, but might be more than two.
   - **Leaf Nodes**:
     - Nodes without further branches.
     - They return class labels (response) or, in some cases, probability scores.
2. **Branches**:

   - The outcomes of decisions, represented as lines connecting nodes.
   - The branching of a node is referred to as a **split**.
   - For numerical decisions:
     - The "greater than" branch is usually placed on the right.
     - The "less than" branch is placed on the left.
     - Sometimes, one of the branches may include an "equal to" component. (Usually on the left)

3. **Depth of a Node**:
   - The minimum number of steps required to reach the node from the root.

### Application: Term Deposit Clients

Given the demographics of clients and their reactions to previous campaign phone calls, the bank's goal is to predict which clients would subscribe to a term deposit.

- The variables include (1) job, (2) marital status, (3) education level, (4) if the credit is in default, (5) if there is a housing loan, (6) if the customer currently has a personal loan, (7) contact type, (8) result of the previous marketing campaign contact (poutcome), and finally (9) if the client actually subscribed to the term deposit. All variables are categorical.
- Attributes (1) through (8) are the input variables or features.
- (9) is considered the (binary) outcome: The outcome subscribed is either yes (meaning the customer will subscribe to the term deposit) or no (meaning the customer won't subscribe).

### Initialisation

Initialise working directory and read file:

```r
setwd("/Users/yizhong/School/Y2S1/DSA1101/Data")
bankdata = read.csv("bank-sample.csv", header = TRUE)
```

Install and call the "rpart" package:

```r
install.packages("rpart")
library("rpart")
```

### Building the Decision Tree

The `rpart` method:

```r
fit <- rpart([response] ~ [features...],
  method="class",
  data=[dataframe],
  control=rpart.control(minsplit=1), # minimum number of observations that must exist in a node for a split
  parms=list(split='information')
)
```

Note that there are few other arguments instead of `minsplit` in `rpart.control`:

- `cp`:smaller values of cp correspond to decision trees of larger sizes, and hence more complex decision surfaces.
- `maxdepth`

Example:

```r
fit <- rpart(subscribed ~ job+marital+education+default
                          +housing+loan+contact+poutcome,
  method="class",
  data=bankdata,
  control=rpart.control(minsplit=1),
  parms=list(split='information')
)
```

### Visualising the Decision Tree

<div align="center">
  <img src="diagrams/bankdecisiontree.png"  height="400">
</div>

```r
rpart.plot(fit, type=4, extra=2)

rpart.plot(fit, type=4, extra=2, varlen=0, faclen=0, clip.right.labs=FALSE)
```

Note:

- `varlen`: length of variable's name,varlen = 0 means full name of input variables is shown.
- `faclen`: length of category's name, faclen = 0 means full name of categories.
- `clip.right.labs`: TRUE means don't print the name of variable for the right stem.

### Choosing the Most Informative Attribute

A common way to identify the most informative attribute is to use entropy-based methods, based on two measurements:

- **Entropy**, which measures the impurity of an attribute
- **Information gain**, which measures the reduction in impurity (if a split is made)

#### Purity

- The _purity_ of a node is defined as its probability of the corresponding class.
- For example, in the top of the decision tree built earlier,
  $$ P(\text{subscribed} = 0) = \frac{1789}{2000} \approx 89.45\% $$
- Therefore, it is 89.45% pure on the ($\text{subscribed} = 0$) class and 10.55% pure on the ($\text{subscribed} = 1$) class.

#### Entropy

Heuristically, entropy is a measure of unpredictability.

Given variable $Y$ and the set of possible categorical values it can take, $(y_1, y_2, \dots, y_K)$, the entropy of $Y$ is defined as:

$$
D_Y = -\sum_{j=1}^{K} P(Y = y_j) \log_2 P(Y = y_j),
$$

where $P(Y = y_j)$ denotes the purity or the probability of the class $Y = y_j$, and $\sum_{j=1}^{K} P(Y = y_j) = 1.$

---

If the variable $Y$ is binary and only takes on two values 0 or 1, the entropy of $Y$ is:

$$
\{P(Y = 1) \log_2 P(Y = 1) + P(Y = 0) \log_2 P(Y = 0)\}.
$$

For example, let $Y$ denote the outcome of a coin toss, $Y = 1$ for head; $Y = 0$ for tail.

- If the coin is a fair one, then $P(Y = 0) = P(Y = 1) = \frac{1}{2}$, then the entropy is:

  $$
  \{0.5 \log_2 0.5 + 0.5 \log_2 0.5\} = 1.
  $$

- If the coin is biased, suppose $P(Y = 0) = \frac{3}{4}, P(Y = 1) = \frac{1}{4}$, the entropy is now:

$$
\{0.25 \log_2 0.25 + 0.75 \log_2 0.75\} \approx 0.81.
$$

When the coin is biased, we have less uncertainty" in predicting the outcome of its next toss, so that the entropy is lower. When the coin is fair, we are much more less able to predict the next toss, and so the entropy is at its highest value.

---

Plotting entropy against probability of binary variable:

```r
p = seq(0, 1, 0.01)
Entropy = - (p * log2(p) + (1 - p) * log2(1 - p))
plot(p, Entropy, ylab="Entropy", xlab="P(Y=1)", type="l")
```

<div align="center">
  <img src="diagrams/entropyplot.png"  height="250">
</div>

### Base Entropy

The base entropy is defined as the entropy of the output variable.

- $ P(\text{subscribed} = 0) = \frac{1789}{2000} \approx 89.45\% $
- $ P(\text{subscribed} = 1) = 1 - \frac{1789}{2000} \approx 10.55\% $

Let $ D $ denote the entropy, the base entropy is then

$$
D_{\text{subscribed}} = - \left\{ 0.1055 \log_2(0.1055) + 0.8945 \log_2(0.8945) \right\} \approx 0.4862.
$$

### Conditional Entropy

Consider a binary tree algorithm. Suppose a feature $X$ has split values $(x_1, x_2)$. The conditional entropy given feature $X$ and the split points $(x_1, x_2)$ is defined as

$$
D_{Y|X} = \sum_{i=1}^{2} P(X = x_i) D(Y|X = x_i)
$$

$$
= - \sum_{i=1}^{2} \left\{ P(X = x_i) \sum_{j=1}^{K} P(Y = y_j | X = x_i) \log_2 [P(Y = y_j | X = x_i)] \right\}
$$

---

We will illustrate the calculation of conditional entropy for the decision variable in the root node, $p_{outcome}$.

Let $ x_1 = \text{failure}, \text{other}, \text{unknown} $ and $ x_2 = \text{success} $.

```r
x1 = which(bankdata$poutcome != "success")
# index of the rows where poutcome = x1

length(x1) # 1942 rows that the value of poutcome = x1.
# [1] 1942

x2 = which(bankdata$poutcome == "success")
# index of the rows where poutcome = x2

length(x2) # 58 rows that the value of poutcome = x2 = success
# [1] 58
```

$P(X = x_1) = \frac{1942}{2000}$ | $P(X = x_2) = \frac{58}{2000}$

---

```r
table(bankdata$subscribed[x1])
```

```
  no   yes
1768   179
```

Among 1942 customers with $p_{outcome} = x_1$, 179 subscribed, and 1763 did not.

```r
table(bankdata$subscribed[x2])
```

```
no   yes
126   32
```

Among 58 customers with $p_{outcome} = x_2$, 32 subscribed, and 26 did not.

<div align="center">
  <img src="diagrams/conditionalprobability.png"  height="150">
</div>

</br>

Therefore, the conditional entropy for selecting $p_{outcome}$ as the decision variable with the split at $x_1$ and $x_2$ is equal to:

$$
D_{\text{subscribed} | p_{outcome}} = - \sum_{i=1}^{2} P(X = x_i) \sum_{j=1}^{2} P(Y = y_j | X = x_i) \log_2[P(Y = y_j | X = x_i)]
$$

$$
= - \left\{ 0.971 \times [0.092 \log_2(0.092) + 0.908 \log_2(0.908)] + 0.029 \times [0.552 \log_2(0.552) + 0.448 \log_2(0.448)] \right\} \approx 0.459.
$$

Hence, there is a reduction of about $(0.4862 - 0.459) \approx 0.027$ from the base entropy.

### Information Gain

The reduction in entropy is also known as **information gain**.

The decision tree algorithm proceeds at the root and internal nodes by calculating the conditional entropy for **each feature variable $X$** and its **different split points**.

Then, the decision variable and its split points with the **largest information gain** (or largest reduction from base entropy) at that node will be selected.

### Gini Index

Besides Information Gain, another commonly used criterion for selecting the decision variable and split points is the Gini index.

Given variable $Y$ and the set of possible categorical values it can take, $(y_1, y_2, \ldots, y_K)$, the Gini index of $Y$ is defined as

$$
G_Y = \sum_{j=1}^{K} P(Y = y_j) [1 - P(Y = y_j)],
$$

where $P(Y = y_j)$ denotes the purity or the probability of the class $Y = y_j$, and

$$
\sum_{j=1}^{K} P(Y = y_j) = 1.
$$

### Application II: Playing Golf

**Play** would be the output variable (or the predicted class), and **Outlook, Temperature, Humidity**, and **Wind** would be the input variables.

### Initialisation

Initialise working directory and read file:

```r
setwd("/Users/yizhong/School/Y2S1/DSA1101/Data")
play_decision <- read.table("DTdata.csv",header=TRUE,sep=",")

library("rpart")
library("rpart.plot")
```

### Building and Visualising the Decision Tree

```r
fit <- rpart(Play ~ Outlook + Temperature + Humidity + Wind,
  method="class",
  data=play_decision,
  control=rpart.control(minsplit=1),
  parms=list(split='information')
)

rpart.plot(fit, type=4, extra=2)
```

### Predicting with Decision Tree

```r
newdata <- data.frame(Outlook= c("rainy", "sunny"), Temperature= c("mild","hot"),
Humidity=c("high", "normal"), Wind=c(FALSE, TRUE))

# get the probability
p = predict(fit,newdata=newdata,type="prob")

# get the probability in numeric
p = predict(fit,newdata=newdata,type="prob")
as.numeric(paste(p))

# get the class
p = predict(fit,newdata=newdata,type="class")

p = predict(fit, newdata = play_decision[,-1], type = "class")
```
