nombre <- c("Alejandro", "Marta", "Raul", "Alejandro", "Jose", "Rocio")
edad <- c(15, 23, 54, 22, 33, 41)
dni <- c(89807519, 60336416, 37745792, 20319216, 72157807, 96725383)
#Los data frames son como tablas de SQL, pero en R son como una lista de vectores

#Puedes usar la funcion data.frame() para crear una tabla pasando los vectores que 
# se asignaran como las columnas de la tabla
#Puedes usar variables y las columnas tendran dicho nombre 
empleados <- data.frame(dni, nombre, edad, stringsAsFactors = FALSE)
#El tipo de datos Factor indica que dicho dato es nominal
#En este caso queremos que simplemente sean strings

#Puedes usar la notacion de las listas si no quieres crear variables
empleados2 <- data.frame(
  dni = c(89807519, 60336416, 37745792, 20319216, 72157807, 96725383),
  nombre = c("Alejandro", "Marta", "Raul", "Cristina", "Jose", "Rocio"),
  edad = c(15, 23, 54), # Si no tienen la misma longitud los vectores, se repetiran hasta la lng del mayor
  stringsAsFactors = FALSE
)

#Como se considera una lista de vectores puedes usar la notacion de listas
nombreEmpleados <- empleados$nombre
dniEmpleados <- empleados[["dni"]]

#Numero de filas
print(nrow(empleados)) # -> [1] 6
#Numero de columnas
print(ncol(empleados)) # -> [1] 3
#Dimension de la tabla
print(dim(empleados)) # -> [1] 6 3
#Nombre de las columnas
print(colnames(empleados)) # -> [1] "dni" "nombre" "edad"
#Nombre de las filas
print(rownames(empleados)) # -> [1] "1" "2" "3" "4" "5" "6"
#Un sub-data.frame con los primeros elementos
print(head(empleados))
#Lo mismo pero con los ultimos
print(tail(empleados))
#Abre una ventana con formato excel de la tabla
View(empleados)
#Puedes usar alguna de estas funciones para cambiar estos valores
colnames(empleados2) <- c("test1", "test2", "test3")

#rownames(empleados) <- empleados$nombre ERROR duplicate 'row.names' are not allowed
rownames(empleados) <- empleados$dni
#Si has asignado previamente un nombre a las filas puedes usar el nombre para la obtener el elemento
# puedes obtener elementos con my_df[row_name/row_num, col_name/col_num]
print(empleados["89807519", c("edad", "nombre")]) #Te devuelve un sub data frame si son mas de una columna
print(is.data.frame(empleados["89807519", c("edad", "nombre")]))
print(empleados[1:3, 2]) #Pero si es mas de una fila te devuelve un vector
#Si dejas en blanco uno de los campos entonces sacas todos las filas/columnas
print(empleados["20319216",]) #Todas las columnas de una/s columna/s
print(empleados[, "dni"]) #Lo mismo que si haces empleados[["dni"]]

#Tambien puedes filtrar los elementos por con esta notacion
#Sacar todas las personas que sean mayor de edad y dni par
print(empleados[empleados$edad > 18 & empleados$dni %% 2 == 0, ])

#Puedes crear un csv de tu tabla
# De manera general no queremos los nombres de las filas en el CSV
write.csv(empleados,"datos_test.csv", row.names = FALSE) 
print(getwd()) #Para cambiar el directorio de trabajo puedes usar o bien setwd()
#O en el menu haces: Session > Set Working Directory 
empleadosCSV <- read.csv("datos_test.csv", stringsAsFactors = FALSE)

#El tipo de dato Factor sirve para modelizar conjunto de elementos que solo
#pueden tomar unos valores
#En vez de guardar el valor real, por ejemplo, el string, este crea valores numericos
#llamados "levels" y guarda la asociacion de el level con el valor real.
colores <- as.factor(c("rojo", "rojo", "azul", "verde", "amarillo", "azul"))
print(colores) # Imprime tanto el conjunto como si fuese un vector, pero tambien los levels
#[1] rojo     rojo     azul     verde    amarillo azul    
#Levels: amarillo azul rojo verde

#Pero las operaciones de vectores no van a funcionar en los factores
numeritos <- as.factor(c(1,2,0,1,2,3,1,2))

print(numeritos * 2) # -> [1] NA NA NA NA NA NA NA NA
#In Ops.factor(numeriros, 2) : ‘*’ not meaningful for factors

#Se pueden cambiar valores del conjunto pero solo por valores de los levels
numeritos[1] <- 0
print(numeritos)

numeritos[1] <- 77  #invalid factor level, NA generated
print(numeritos) #[1] <NA> 2    0    1    2    3    1    2   
#Esto es lo que hace que en la mayoria de los casos pongamos stringsAsFactors = FALSE
#porque sino no se pueden añadir nuevos strings diferentes a los originales

empleadosFactores <- data.frame(
  dni = c(89807519, 60336416, 37745792, 20319216, 72157807, 96725383),
  nombre = c("Alejandro", "Marta", "Raul", "Cristina", "Jose", "Rocio"),
  edad =  c(15, 23, 54, 22, 33, 41)
)

print(is.factor(empleadosFactores$nombre)) # -> [1] TRUE
#Si queremos poner un nombre que no estaba antes saldra el Warning y se insertara el NA
empleadosFactores[1,2] <- "NO ESTABA"
View(empleadosFactores)

#Una de las posibles utilidades de dejar los strings como factors en un data frame
#es que te permite usar funciones que filtran tu data frame por los levels de  un factor

#split() devuelve una lista de dataframes, uno por cada nivel
tamanyoCamiseta <- c("s", "l", "l", "m", "m", "s", "s", "m", "m")
precios <- c(15.5, 12, 10 , 30, 50, 20, 12, 22, 7)
camisetas <- data.frame(tamanyoCamiseta, precios)

splitCamisetasPorTamanyo <- split(camisetas, camisetas$tamanyoCamiseta)
print(splitCamisetasPorTamanyo)

#Tambien puedes usar tapply para aplicar funciones a cada factor level
#Primero el vector a la que se aplica la funcion
#Segundo el Factor por el que filtrar
#Tercero la funcion
quees<-tapply(camisetas$precios, camisetas$tamanyoCamiseta, mean) 
# Devuelve un array que no es lo mismo que un vector


