#Los vectores en R so fuertemente tipados 
#Es habitual usar la funcion c() para crear vectores
numeritos <- c(1, 2, 3, 4, 5)
print(numeritos)
print(length(numeritos))

#Para crear secuencias numericas se puede usar seq()
del1al70 <- seq(1, 70)
print(del1al70)

#Puedes usar azucar sintactico para este tipo de secuencias
del1al70SintacticSugar <- 1:70
print(del1al70SintacticSugar)
# [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22
#[23] 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44
#[45] 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66
#[67] 67 68 69 70
#Los numeros entre [] indican el indice donde se empueza a imprimir en dicha 
#linea por consola

paresHasta25 <- seq(0, 25, 2)
print(paresHasta25)

#Las operaciones de vectores son a punto, es decir, elemento a elemento (incluso producto y division)
v1 <- c(6, 7, 2, 0, 1)
v2 <- c(1, 0, 3, 5, 9)
v3 <- 1:2

print(v1 + v2)
print(v1 * v2)
print(v1 / v2)
print(v1 + v3) 
#Reciclado: se repite la operacion de manera ciclica hasta que se haga con todos 
#los elementos del vector con mayor longitud
# (6, 7, 2, 0, 1) + (1, 2, 1, 2, 1) -> [1] 7 9 3 2 2 

#Se puede usar todas las funciones del tipo de dato del vector y se aplicaran elemento a elemento
print(paste(c("Hola", "que"), c("Maria", "pasa?")))

#En R todos los valores son vectores
print(is.vector(18))
print(is.vector(TRUE))
#Los string son "vectores de longitud 1" (se considera un tipo basico)
print(is.vector("Hola"))
print(length("Hola")) # -> [1] 1 Te dice que el string esta metido en un vector de long 1
print(nchar("Hola")) # -> [1] 4 Pero con nchar() si que puedes saber la longitud real del string


#Aqui tambien se recica y se produce el producto usual de vector por escalar
t1 <- 1:10
print(t1 * 4) 
# Tambien la suma por un escalar hace que se sume a todos los elementos
print(t1 + 4)

#Cuando usas una funcion sobre un vector se aplica a todos los elementos en orden
print(round(c(1.323, 112.34534, 234, 3.1)))
print(nchar(c("holA", "CARACOLA"))) # -> [1] 4 8

#Como las operaciones son iterables con vectores no es necesarios bucles for (en la mayoria de casos)

#Para indicar los indices de un vector se una [] y se comienza en 1
print(numeritos[1])
print(numeritos[2])
print(numeritos[29]) # Si te sales del rango te devuelve NA (not available)
#Si el indice es negativo devuelve todos los valores excepto el del indice indicado
print(numeritos[-2]) # -> [1] 1 3 4 5

#Como los numeros son vectores de longitud 1 puedes pasar un vector de longitud
#n como indice para obtener el subconjunto de dichos n elementos
print(numeritos[c(1, 2, 3, 30)]) # -> [1]  1  2  3 NA
print(numeritos[2:5]) # -> [1] 2 3 4 5

# Podemos hacer vector filtering a traves de indices de vectores booleanos
# TRUE -> Se añade  la solucion
# FALSE -> Se descarta
c1 <- c(TRUE, FALSE, TRUE, FALSE, TRUE)
print(numeritos[c1]) # -> [1] 1 3 5
c2 <- c(TRUE, FALSE, TRUE)
#Se hace Recyclin y sale este indice [TRUE, FALSE, TRUE, (SE REPITE) TRUE, FALSE (YA HE LLEGADO A 5)] 
print(numeritos[c2]) # -> [1] 1 3 4

#Debido al Recycling puedes crear vectores booleanos para hacer esta indexacion logica
print(numeritos > 2) # -> [1] FALSE FALSE  TRUE  TRUE  TRUE
print(numeritos[numeritos > 2]) # -> [1] 3 4 5

print(numeritos[numeritos %% 2 == 1]) # Los numeros impares

# Para campiar el valor de una posicion de un vector se hace asi:
nombres <- c("maria", "roberto", "julio")
nombres[3] <- "oscar"
print(nombres)

nombres[length(nombres)] <- "alex"
print(nombres) # Modifica el ultimo: [1] "maria"   "roberto" "alex" 

nombres[length(nombres) + 1] <- "NUEVO"
print(nombres) # Añade al final: [1] "maria"   "roberto" "alex"    "NUEVO"   

#En general si el indice es mayor que la longitud, se extiende el vector inicializandolo
# con NA y en las posiciones indicadas de pone los valores indicados
nombres[c(1, 2, length(nombres) + 4)] <- c("BRRR", "pipo")
print(nombres) # -> [1] "BRRR"  "pipo"  "alex"  "NUEVO" NA      NA      NA      "BRRR"  

#Una manera mas limpia de añadir un elemento al final es juntar los vectores con c()
print(c(nombres, "LLLLLL"))

#Puedes combinar el Filtering con la asignacion vectorial para poder cambiar los valores
# que cumplan una condicion logica
del1al70[del1al70 < 10] <- 7
print(del1al70)




