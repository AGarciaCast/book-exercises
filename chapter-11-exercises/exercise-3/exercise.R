# Exercise 3: using the pipe operator

# Install (if needed) and load the "dplyr" library
#install.packages("dplyr")
library("dplyr")

# Install (if needed) and load the "fueleconomy" package
#install.packages('devtools')
#devtools::install_github("hadley/fueleconomy")
library("fueleconomy")

# Which 2015 Acura model has the best hwy MGH? (Use dplyr, but without method
# chaining or pipes--use temporary variables!)
test1 <- function(){
  acura2015 <- filter(vehicles, year == 2015, make == "Acura")
  minHwyMGHAcura2015 <- filter(acura2015, hwy == min(hwy))
  modelResult <- select(minHwyMGHAcura2015, model)
}

# Which 2015 Acura model has the best hwy MPG? (Use dplyr, nesting functions)
test2 <- function(){
  modelResult <- select(
    filter(
      filter(
        vehicles,
        year == 2015,
        make == "Acura"
        ),
      hwy == min(hwy)
      ),
    model)
  }

# Which 2015 Acura model has the best hwy MPG? (Use dplyr and the pipe operator)
test3 <- function(){
  modelResult <- vehicles %>% 
    filter(year == 2015, make == "Acura") %>% 
    filter(hwy == min(hwy)) %>% 
    select(model)
}



### Bonus

# Write 3 functions, one for each approach.  Then,
# Test how long it takes to perform each one 1000 times
startTime <- Sys.time()
for(i in 1:1000) test1()
stopTime <- Sys.time()

print("Done Test1")
timeVariable <- stopTime - startTime

startTime <- Sys.time()
for(i in 1:1000) test2()
stopTime <- Sys.time()

print("Done Test2")
timeNesting <- stopTime - startTime

startTime <- Sys.time()
for(i in 1:1000) test3()
stopTime <- Sys.time()

print("Done Test3")
timePipes <- stopTime - startTime

print(paste("The time for variables is:", timeVariable))
print(paste("The time for nesting is:", timeNesting))
print(paste("The time for pipes is:", timePipes))

#Se podria haber hecho esto para calcular el tiempo:
system.time(for(i in 1:1000) test1())


