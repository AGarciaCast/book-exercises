library("pscl")
library("nycflights13")
library("dplyr") #Con este paquete puedes hacer operaciones de seleccion como en SQL
library("ggplot2")

View(presidentialElections)

#select() extrae una serie de COLUMNAS del dataFrame
#Importante: los nombres de las columnas no van entre comillas!
votos <- select(presidentialElections, year, demVote) #Devuelve un sub-dataFrame
#El select es lo mismo que usar esta notacion que habiamos visto
votosNotacionLarga <- presidentialElections[, c("year", "demVote")]
#Esta notacion puede seguir siendo util cuando se quiere usar nombres de 
#columnas almacenadas en variables como strings

#Puedes usar sintactic sugar para seleccionar las columnas
#Usando col1:col2 dices que quieres todas las columnas desde la col1 hasta la col2 
select(presidentialElections, state:year)

#Con -col dices que quieres todas las columnas EXCEPTO col
select(presidentialElections, -south)

#Si quieres sacar una columna y que sea un vetor, o sacar un elemento puedes
# usar la notacion usual de R o usar la funcion pull()
pull(presidentialElections, state)

#Podemos sacar FILAS que cumplan una serie de requisitos con filter()
votes_2008 <- filter(presidentialElections, year==2008)
#Que es lo mismo que hacer
votes_2008NotacionLarga <- presidentialElections[presidentialElections$year == 2008, ]

votes_2004_California <- filter(
  presidentialElections,
  year == 2004,
  state == "California"
)

#Estas funciones eliminan los rownames
#Una buena practica es crear una columna que contenga dichos nombres para no perder los valores
#df <- mutate(df, row_names = rownames(df))

#La funcion mutate() sirve para añadir nuebas COLUMNAS, tiene una notacion parecida a la de las
#listas
#Realmente no modifica la original sino que devuelve una nueva con las nuevas columnas

presidentialElections <- mutate(
  presidentialElections,
  otherPartiesVote = 100 - demVote,
  absVoteDiff = abs(otherPartiesVote - demVote) #Puedes hacer referencia a columnas que acabas de crear
)

#Puedes usar arrange() para ordenar un dataFrame 
#Pones las columnas en el orden de prioridad de orden
#De manera normal van en orden creciente a medida que bajas en filas
#Si pones el simbolo - o usas la funcion desc() lo pones en orden descendiente
presidentialElections <- arrange(presidentialElections, -year, demVote)

#Podemos aplicar funciones de agregado (funciones que toman un vector y devuelven un valor)
#para ello se usar la funcion summarize(), la cual te permite crear un nuevo dataSet al que se
#le ha aplicado estas funciones de agregado a las columnas de otro dataSet
#Si no tienes agrupaciones en el dataSet el resultado de summarize() es un dataSet de una fila
#si tenemos agrupaciones habrá tantas filas como agrupaciones

mediaVotos <- summarize(
  presidentialElections,
  mediaDemocratas = mean(demVote),
  mediaRestoPartidos = mean(otherPartiesVote)
)

numVictorias <- function(porcentajes){
  sum(porcentajes > 50)  
} 

resumenVictorias <- summarize(
  presidentialElections,
  victoriasDem = numVictorias(demVote),
  derrotasDem = nrow(presidentialElections) - victoriasDem
)

#Como en SQL, la mayoria de las veces necesitas combinar las funciones
#MODO 1: Puedes crear variables auxiliares 
#SACAR EL ESTADO QUE MAS HAN VOTADO A LOS DEMOCRATAS EN 2008

votos2008 <- filter(
  presidentialElections,
  year == 2008
)

mayorVotoDem2008 <- filter(
  votos2008,
  demVote == max(demVote)
)

estadoMayorVotoDem2008 <- select(mayorVotoDem2008, state)

#MODO 2: Puedes hacer "nesting", donde concadenas las llamadas
#PROS: No hay variables aux
#CONS: No se puede leer bien

estadoMayorVotoDem2008_2 <- select(
  filter(
    filter(
      presidentialElections,
      year == 2008
    ),
    demVote == max(demVote)
  ),
  state
)

#MODO 3: El paquete dplyr, carga la dependencia del paquete magrittr que nos 
#permite usar una especie de pipe, este es el operador %>% (ctrl+shift+m)
#Este operador coge el output de la izquierda y lo pasa como PRIMER ARGUMENTO a la 
#funcion de la derecha
estadoMayorVotoDem2008_3 <- presidentialElections %>% #Primero "cargamos" el DF
  filter(year == 2008) %>% #No ponemos el primer parametro, ya que ya se pasa por el pipe
  filter(demVote == max(demVote)) %>%
  select(state)
#Todas las funciones de dplyr toman como primer parametro el DF y devuelven otro DF

#Realmente puedes usar el pipe con funciones que no son de dplyr, pero antes hay que cargar 
#el paquete

#Puedes agrupar el dataFrame con group_by(), donde agrupas filas que tengan el mismo valor en un/as 
#columnas
#Te devuelve un tibble, que es una version simplificada y mejorada del data.frame
#Cuando haces la agrupacion se guardan las relaciones en de grupo en el tibble resultante
#Los resultados de funciones de dplyr sobre tibbles son tibbles y si quieres volver a dataFrame
#puedes usar as.data.frame() y viceversa con as.tibble()

#Cuando haces agrupaciones estas cambiando la unidad de tu analisis
resumenVotoPorEstado <- presidentialElections %>% 
  group_by(state) %>% #Agrupamos los datos por estado
  summarize(
    mediaDemocratas = mean(demVote),
    mediaRestoPartidos = mean(otherPartiesVote)
  )
#Una de las cosas buenas del tibble es que la impresion es mucho mejor
#Puedes ver que te indica el tipo de dato de cada columna
print(resumenVotoPorEstado) 

#EJEMPLO:
#Primero vamos a conocer nuestros datos
?flights
dim(flights)
colnames(flights)
View(flights)

#Which airline has the highest number of delayed depatures?
query1 <- inner_join(flights, airlines, by = "carrier") %>% 
  group_by(name) %>% 
  filter(dep_delay > 0) %>% 
  summarize(numDelais = n()) %>% 
  filter(numDelais == max(numDelais)) %>% 
  select(name)

print(query1$name)

#On average, to wich airport do flights arrive most early
query2 <- left_join(flights, airports, by = c("dest" = "faa")) %>% 
  group_by(name) %>% 
  summarize(delay = mean(arr_delay, na.rm = TRUE)) %>% 
  filter(delay == min(delay, na.rm = TRUE)) %>% 
  select(name)

print(query2$name)
#Como en el libro:
most_early <- flights %>% 
  group_by(dest) %>% 
  summarize(delay = mean(arr_delay, na.rm = TRUE)) %>% 
  filter(delay == min(delay, na.rm = TRUE)) %>% 
  left_join(airports, by = c("dest" = "faa")) %>% 
  select(dest, name, delay)

print(most_early)

#delays + visualizacion (capitulo 17)
delay_by_month <- flights %>% 
  group_by(month) %>% 
  summarize(delay = mean(arr_delay, na.rm = TRUE)) %>% #Se añade la columna 
  #que se agrupo por y tambien se ordena por esa
  select(delay) %>% 
  mutate (month = month.name) #añades el valor nuevo a la columna de month
                              #La variable month.name es interna a R

ggplot(data = delay_by_month) +
  geom_point(
    mapping = aes(x = delay, y = month),
    color = "blue",
    alpha = .4,
    size = 3
  ) +
  geom_vline(xintercept = 0, size = .25) +
  xlim(c(-20, 20)) +
  scale_y_discrete(limits = rev(month.name)) +
  labs(title = "Average Delay by Month", y = "", x = "Delay (minutes)")