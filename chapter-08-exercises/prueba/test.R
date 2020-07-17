#En R list = Dictionary de Python
person <- list(
  nombre = "Alejandro",
  apellido = "Garcia",
  edad = 20,
  trabajando = FALSE,
  favoritos = list(
    musica = "Prog Rock",
    comida = "Queso"
  ),
  notasUni = c(9.69, 9.8, 9.83) 
)

print(person)
#Para acceder a los elementos puedes hacerlo con el tag usando esta notacion
print(person$nombre)
#Tambien puedes usar [[]] si quieres usar el indice numerico
print(person[[3]])
print(person[[8]]) # -> Error in person[[8]] : subíndice fuera de  los límites
#Mientras que en los vectores si te sales de rango solo te devuelve NA

#La notacion [[]] tambien te permite usar los tags 
print(person[["nombre"]])
print(person[["asdasd"]]) # -> NULL, ya que no existe dicho tag en la lista
tag <- "edad"
print(person[[tag]]) # Puedes usar variables que contengan un tag
print(person$tag) # -> NULL, ya que el nombre de la variable no coincide con el tag

print(person$favoritos$musica)
print(person$notasUni[2])

#Si queremos crear un nuevo tag solo hay que asignarle un valor distinto de NULL
person$test <- "PRUEBA"
print(person)
#Si queremos eliminar una entrada en la lista tenemos que asignarle NULL
person$edad <- NULL
print(person)
#Para cambiar el valor de una etiqueta ya existente solo hay que asignarle un valor
person$trabajando <- TRUE
print(person)

#En realidad en R cuando usas [] (simples) lo que haces es filtrar por el vector que le pasas
#Cuando se usa sobre lista lo que te devuelve es una sublista con los nombres o indices que has filtrado
print(person["nombre"])
print(is.list(person["nombre"])) #Puedes comprobar que lo que te devuelve es una lista
#Mientras que lo que te devuelve el [[]] es un elemento de una lista (lo cual a su vez podria ser otra lista)
print(person[["nombre"]])
print(is.list(person[["nombre"]]))
#Si le pasas un vector de nombres/indices puedes sacar una sublista con dichos nombres/indices
print(person[c("nombre", "apellido","notasUni")])

#Para aplicarle una funcion a todos los elemetos de una lista tenemos que usar un *apply()
# en este caso lapply()
lista <- list("Adrian", "Gonzalo", "Ramon")
print(lapply(lista, paste, "UWU", sep = " -> "))

#Existe sapply() que sirve para vectorizar funciones (normalmente funciones que
# originalmente no son vectoriales)
vector <- c(2,4,6)
funcionPocha <- function(x){
  "BRR"
}
print(funcionPocha(vector)) # -> [1] "BRR"
print(sapply(vector,funcionPocha)) # -> [1] "BRR" "BRR" "BRR"










