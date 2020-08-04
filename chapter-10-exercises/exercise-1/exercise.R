# Exercise 1: creating data frames

# Create a vector of the number of points the Seahawks scored in the first 4 games
# of the season (google "Seahawks" for the scores!)
pointsScored <- c(22, 19, 23, 17)

# Create a vector of the number of points the Seahwaks have allowed to be scored
# against them in each of the first 4 games of the season
pointsLost <- c(14, 25, 15, 15)

# Combine your two vectors into a dataframe called `games`
games <- data.frame(pointsScored, pointsLost)

# Create a new column "diff" that is the difference in points between the teams
# Hint: recall the syntax for assigning new elements (which in this case will be
# a vector) to a list!
games[["diff"]] <- abs(games$pointsScored - games$pointsLost)

# Create a new column "won" which is TRUE if the Seahawks won the game
games[["won"]] <- games$pointsScored > games$pointsLost

# Create a vector of the opponent names corresponding to the games played
opponentNames <- c("Broncos", "Vikings", "Chargers", "Raiders")

# Assign your dataframe rownames of their opponents
rownames(games) <- opponentNames

# View your data frame to see how it has changed!
View(games)
