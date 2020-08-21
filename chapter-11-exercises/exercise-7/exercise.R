# Exercise 7: using dplyr on external data

# Load the `dplyr` library
library("dplyr")

# Use the `read.csv()` function to read in the included data set. Remember to
# save it as a variable.
teams <- read.csv("./data/nba_teams_2016.csv", stringsAsFactors = FALSE)

# View the data frame you loaded, and get some basic information about the 
# number of rows/columns. 
# Note the "X" preceding some of the column titles as well as the "*" following
# the names of teams that made it to the playoffs that year.
dim(teams)
View(teams)

# Add a column that gives the turnovers to steals ratio (TOV / STL) for each team
teams <- mutate(teams, TOV.STL = TOV / STL)

# Sort the teams from lowest turnover/steal ratio to highest
# Which team has the lowest turnover/steal ratio?
teams <- arrange(teams, TOV.STL)
print(teams$Team[1])

# Using the pipe operator, create a new column of assists per game (AST / G) 
# AND sort the data.frame by this new column in descending order.
teams <- teams %>% 
  mutate(AST.G = AST / G) %>% 
  arrange(-AST.G)

# Create a data frame called `good_offense` of teams that scored more than 
# 8700 points (PTS) in the season
good_offense <- filter(teams, PTS > 8700)

# Create a data frame called `good_defense` of teams that had more than 
# 470 blocks (BLK)
good_defense <- filter(teams, BLK > 470)

# Create a data frame called `offense_stats` that only shows offensive 
# rebounds (ORB), field-goal % (FG.), and assists (AST) along with the team name.
offense_stats <- select(teams, ORB, FG., AST, Team)

# Create a data frame called `defense_stats` that only shows defensive 
# rebounds (DRB), steals (STL), and blocks (BLK) along with the team name.
defensive_stats <- select(teams, DRB, STL, BLK, Team)

# Create a function called `better_shooters` that takes in two teams and returns
# a data frame of the team with the better field-goal percentage. Include the 
# team name, field-goal percentage, and total points in your resulting data frame
better_shooters <- function(team1, team2){
  teams %>%
    filter(Team %in% c(team1,team2)) %>%
    select(Team, FG., PTS) %>% 
    filter(FG. == max(FG.)) 
}

# Call the function on two teams to compare them (remember the `*` if needed)
better_shooters("Golden State Warriors*", "Orlando Magic")
