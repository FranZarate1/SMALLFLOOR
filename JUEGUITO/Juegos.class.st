Class {
	#name : 'Juegos',
	#superclass : 'Object',
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
Juegos >> suma [
| numeros suma opciones usuario1 usuario2 diferencia1 diferencia2 resultado morph |

"Generar tres números aleatorios entre 1 y 9"
numeros := { (1 to: 9) atRandom. (1 to: 9) atRandom. (1 to: 9) atRandom }.

"Calcular la suma de los tres números"
suma := numeros sum.

"Crear el Morph donde se mostrarán los números"
morph := TextMorph new.
morph contents: 'Esperando...'.
morph openInWorld. "Abrir el Morph en la ventana principal"
[  
"Mostrar los números uno a uno con un retraso de 3 segundos"
numeros do: [ :numero |
    "Crear un proceso para mostrar el número con un retraso de 3 segundos"
    
        (Delay forSeconds: 3) wait. "Esperar 3 segundos"
        morph contents: 'Número: ', numero printString. "Actualizar el Morph con el número"
        morph changed. "Indicar que el Morph ha cambiado"
        (Delay forSeconds: 2) wait. "Esperar 2 segundos para que el número se muestre por un tiempo"
        morph contents: ''. "Borrar el número del Morph"
        morph changed. "Indicar que el Morph ha cambiado después de borrar"
    . "Ejecutar en un proceso paralelo"
].

"Esperar para que todos los números se hayan mostrado y desaparecido"
(Delay forSeconds: 3 * numeros size + 2 * numeros size) wait.
]fork.

"Obtener las respuestas de los dos jugadores"
usuario1 := UIManager default request: 'Jugador 1, ingrese su respuesta:'.
usuario2 := UIManager default request: 'Jugador 2, ingrese su respuesta:'.

"Calcular las diferencias de cada jugador con la suma correcta"
diferencia1 := (usuario1 asInteger - suma abs).
diferencia2 := (usuario2 asInteger - suma abs).

"Comparar las respuestas"
resultado := (diferencia1 <= diferencia2) 
    ifTrue: ['Jugador 1 gana con una diferencia de ', diferencia1 printString]
    ifFalse: ['Jugador 2 gana con una diferencia de ', diferencia2 printString].

"Mostrar el resultado"
Transcript show: 'Suma correcta: ', suma printString; cr.
Transcript show: resultado; cr.

]
