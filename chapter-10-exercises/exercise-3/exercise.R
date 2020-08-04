# Exercise 3: working with built-in data sets

# Load R's "USPersonalExpenditure" dataset using the `data()` function
# This will produce a data frame called `USPersonalExpenditure`
data("USPersonalExpenditure")

# The variable `USPersonalExpenditure` is now accessible to you. Unfortunately,
# it's not a data frame (it's actually what is called a matrix)
# Test this using the `is.data.frame()` function
print(is.data.frame(USPersonalExpenditure))

# Luckily, you can pass the USPersonalExpenditure variable as an argument to the
# `data.frame()` function to convert it a data farm. Do this, storing the
# result in a new variable
USPersonalExpenditureDF <- data.frame(USPersonalExpenditure, stringsAsFactors = FALSE) 

# What are the column names of your dataframe?
print(colnames(USPersonalExpenditureDF))

## Consider: why are they so strange? Think about whether you could use a number 
## like 1940 with dollar notation!
#No podrias crearlo con data.frame ya que las constantes numericas no pueden 
#ser el nombre de variables 

# What are the row names of your dataframe?
print(rownames(USPersonalExpenditureDF))

# Add a column "category" to your data frame that contains the rownames
USPersonalExpenditureDF[["category"]] <- rownames(USPersonalExpenditureDF) 

# How much money was spent on personal care in 1940?
print(USPersonalExpenditureDF["Personal Care", "X1940"])

# How much money was spent on Food and Tobacco in 1960?
print(USPersonalExpenditureDF["Food and Tobacco", "X1960"])

# What was the highest expenditure category in 1960?
highestExpenditure1960 <- max(USPersonalExpenditureDF$X1960)
print(USPersonalExpenditureDF[USPersonalExpenditureDF$X1960 == highestExpenditure1960,"category"])
#Manera libro
USPersonalExpenditureDF$category[USPersonalExpenditureDF$X1960 == max(USPersonalExpenditureDF$X1940)]

# Define a function `lowest_category` that takes in a year as a parameter, and
# returns the lowest spending category of that year
lowest_category <- function(year){
  year <- 1940
  yearTag <- paste("X", year, sep = "")
  lowestExpenditure <- min(USPersonalExpenditureDF[[yearTag]])
  USPersonalExpenditureDF[USPersonalExpenditureDF[[yearTag]] == lowestExpenditure,"category"]
}

# Using your function, determine the lowest spending category of each year
# Hint: use the `sapply()` function to apply your function to a vector of years
sapply(seq(1940, 1960, 5), lowest_category)
