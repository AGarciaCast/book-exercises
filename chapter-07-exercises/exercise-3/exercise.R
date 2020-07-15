# Exercise 3: vector practice

# Create a vector `words` of 6 (or more) words.
# You can Google for a "random word generator" if you wish!
words <- c("unlawful", "incapable", "bake", "relinquish", "breakfast", "confuse", "gorilla")

# Create a vector `words_of_the_day` that is your `words` vector with the string
# "is the word of the day!" pasted on to the end.
# BONUS: Surround the word in quotes (e.g., `'data' is the word of the day!`)
# Note that the results are more obviously correct with single quotes.
words_of_the_day <- paste("'", words,"' is the word of the day!", sep="")

# Create a vector `a_f_words` which are the elements in `words` that start with 
# "a" through "f"
# Hint: use a comparison operator to see if the word comes before "f" alphabetically!
# Tip: make sure all the words are lower-case, and only consider the first letter
# of the word!
a_f_words <- words[substr(words,1,1)<= "f"]

# Create a vector `g_m_words` which are the elements in `words` that start with 
# "g" through "m"
first_word <- substr(words,1,1)
g_m_words <- words[first_word >= "g" & first_word <= "m"]

# Define a function `word_bin` that takes in three arguments: a vector of words, 
# and two letters. The function should return a vector of words that go between 
# those letters alphabetically.
word_bin <- function(words, l1, l2){
  first_word <- substr(words,1,1)
  if(l1< l2)
    cond <- first_word >= l1 & first_word <= l2
  else
    cond <- first_word >= l2 & first_word <= l1
  
  words[cond]
}
print(word_bin(c("test", "prueba", "alfiler"), "q", "c"))
s
# Use your `word_bin` function to determine which of your words start with "e" 
# through "q"
print(word_bin(words, "e", "q"))
