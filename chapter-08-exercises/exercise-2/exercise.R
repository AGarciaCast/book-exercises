# Exercise 2: using `*apply()` functions

# Create a *list* of 10 random numbers. Use the `runif()` function to make a 
# vector of random numbers, then use `as.list()` to convert that to a list
numbers <- as.list(runif(10))

# Use `lapply()` to apply the `round()` function to each number, rounding it to 
# the nearest 0.1 (one decimal place)
numbers <- lapply(numbers, round, digits = 1)

# Create a variable 'sentence' that contains a sentence of text (something 
# longish). Make the sentence lowercase; you can use a function to help.
sentence <- "Preservar la utilidad educativa de ciertos trabajos prácticos propuestos a los alumnos y proteger la inversión y el esfuerzo dedicados a su elaboración por parte de los profesores"
sentence <- tolower(sentence)

# Use the `strsplit()` function to split the sentence into a vector of letters.
# Hint: split on `""` to split every character
# Note: this will return a _list_ with 1 element (which is the vector of letters)
listaAux <- strsplit(sentence, "")

# Extract the vector of letters from the resulting list
caracteres <- listaAux[[1]]

# Use the `unique()` function to get a vector of unique letters
caracteresUniq <- unique(caracteres)

# Define a function `count_occurrences` that takes in two parameters: a letter 
# and a vector of letters. The function should return how many times that letter
# occurs in the provided vector.
# Hint: use a filter operation!
count_occurrences <- function(letter, vect){
  length(vect[vect == letter])
}

# Call your `count_occurrences()` function to see how many times the letter 'e'
# is in your sentence.
print(count_occurrences("e", caracteres))

# Use `sapply()` to apply your `count_occurrences()` function to each unique 
# letter in the vector to determine their frequencies.
# Convert the result into a list (using `as.list()`).
frequenciaCaract <- as.list(sapply(caracteresUniq, count_occurrences, caracteres))

# Print the resulting list of frequencies
print(frequenciaCaract)
