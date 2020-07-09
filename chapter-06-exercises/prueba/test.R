library("stringr")

print("Hola Peru")

valor <- sqrt(75)

min(4,2,1,5,7)

sum(1,2,3)

round(pi,2)

toupper(paste("Levantarse","Comer","Dormir",sep="->"))

nchar("hola buenas")

#Concatenar elementos a un vector
c(1123,"Hola") # -> [1] "1123" "Hola"
c(1123,21) # -> [1] 1123   21

seq(0,3) # -> [1] 0 1 2 3

#Funciones de la libreria stringr
frutas <- c("Platano","Manzana","Pera")
#Cuenta el numero de veces que aparece un substring
str_count(frutas,"a")
#Si la funcion existe en varios paquetes tienes que indicar cual es el que 
#quieres
stringr::str_count(frutas,"an")

#Ejemplo definicion de funcion:
#Las funciones en R se les "asigna" una variable cuando se le da un nombre
nombre_y_apellidos <- function(nombre, apellido){
  
  nombreCompleto <- paste(nombre,apellido)
  
  #Se retorna la evaluacion de la ultima linea de la funcion 
  nombreCompleto
}

nombre_y_apellidos("Carmen","Fernandez")

areaTriangulo <- function(base, altura){
  # Con la funcion return() retornas el valor y sales de la funcion
  return((base*altura)/2) 
  toupper("hola") #NO SE EJECUTA
}

areaTriangulo(2,3) # -> [1] 3

areaRectangulo <- function(lado1,lado2){
  lado1*lado2
}

areaSel <- function(fig, l1, l2){
  if(fig=="rect")
    resultado <- areaRectangulo(l1,l2)
  else if (fig=="triang")
    resultado <- areaTriangulo(l1,l2)
  else 
    resultado <- "Error"
  
  resultado
}

areaSel("rect",1,2)
areaSel("triang",1,2)
areaSel("asdas",1,2)








