Class {
	#name : 'Tablero',
	#superclass : 'Object',
	#instVars : [
		'Matrix',
		'celdaSeleccionada',
		'celdasAdyacentesAnteriores',
		'celdaAdyacente',
		'adyacenteArriba',
		'adyacenteAbajo',
		'adyacenteDerecha',
		'adyacenteIzquierda'
	],
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
Tablero >> Crear_Tablero: filap columna: columnap [ 
        | tablero ventana ventana2 filas columnas celda anchoCelda altoCelda totalAncho totalAlto matrizCeldas xOffset yOffset botonB numJugador |
		  numJugador:=1.
        ventana2 := SystemWindow new.
        ventana2 setLabel: 'Tablero 4x4'.
        ventana2 extent: 800 @ 700.  "Tamaño inicial de la ventana."

        ventana := SystemWindow new.
        ventana extent: 800 @ 600.  "Tamaño inicial de la ventana."

        filas := filap.  "Número de filas"
        columnas := columnap.  "Número de columnas"

        "Calcular el tamaño de las celdas según el tamaño de la ventana"
        totalAncho := ventana extent x.  "Ancho total de la ventana"
        totalAlto := ventana extent y.  "Alto total de la ventana"
        anchoCelda := totalAncho // columnas.  "Ancho de cada celda"
        altoCelda := totalAlto // filas.  "Alto de cada celda"

        "Crear el tablero"
        tablero := Morph new.
        tablero layoutPolicy: nil.  "Sin layout automático; las celdas se posicionan manualmente."
        tablero hResizing: #spaceFill; vResizing: #spaceFill.  "Permitir que se ajuste al espacio disponible."

        "Crear la matriz para almacenar las celdas"
        matrizCeldas := Array new: filas.  "Crea un arreglo para las filas"
        1 to: filas do: [:i | matrizCeldas at: i put: (Array new: columnas)].
        
        "Crear y posicionar las celdas directamente en el tablero"
        yOffset := 0.
        1 to: filas do: [:i | 
            xOffset := 0.
            1 to: columnas do: [:j | 
                "Crear la celda con tamaño y posición específicos"
                celda := Celda new CrearCelda: anchoCelda altoo: altoCelda fila: i columna: j juegador: numJugador .
                celda position: xOffset @ yOffset.  "Colocar la celda en su posición en el tablero"
                numJugador:=numJugador +1.
                "Agregar la celda a la matriz"
                (matrizCeldas at: i) at: j put: celda.

                "Agregar la celda al tablero"
                tablero addMorph: celda.

                "Actualizar el offset horizontal"
                xOffset := xOffset + anchoCelda.
            ].
            "Actualizar el offset vertical"
            yOffset := yOffset + altoCelda.
        ].

        "Almacenar la matriz como un atributo de la clase para acceso posterior"
        Matrix := matrizCeldas.

        "Agregar el tablero dentro de la ventana"
        ventana addMorph: tablero.

        "Agregar otra ventana para poner un botón e iniciar la búsqueda del jugador"
        botonB := SimpleButtonMorph new.
        botonB label: 'Encontrar Celda Random'; 
            target: self; 
            actionSelector: #EncontrarCeldaRandom;
            position: 350 @ 630.  "Primer N° posición horizontal y el segundo la vertical"
        ventana2 addMorph: botonB.
        ventana2 addMorph: ventana.

        ventana2 openInWorld.
]

{ #category : 'as yet unclassified' }
Tablero >> ElegirCeldaAdyacente [
        | fila columna celdasAdyacentes celdaAdyacente |

        "Obtener la posición de la celda seleccionada"
        fila := celdaSeleccionada getX.
        columna := celdaSeleccionada getY.

        "Inicializar la colección de celdas adyacentes"
        celdasAdyacentes := OrderedCollection new.

        "Agregar celdas adyacentes (arriba, abajo, izquierda, derecha) si están dentro de los límites"
        (fila > 1) ifTrue: [ celdasAdyacentes add: (Matrix at: fila - 1) at: columna ].  "Arriba"
        (fila < Matrix size) ifTrue: [ celdasAdyacentes add: (Matrix at: fila + 1) at: columna ].  "Abajo"
        (columna > 1) ifTrue: [ celdasAdyacentes add: (Matrix at: fila) at: columna - 1 ].  "Izquierda"
        (columna < (Matrix at: fila) size) ifTrue: [ celdasAdyacentes add: (Matrix at: fila) at: columna + 1 ].  "Derecha"

        "Pintar las celdas adyacentes"
        celdasAdyacentes do: [:celda | celda color: Color green].

        "Seleccionar una celda adyacente aleatoria"
        celdaAdyacente := celdasAdyacentes atRandom.

        "Marcar la nueva celda seleccionada"
        celdaSeleccionada borderWidth: 2.
        celdaSeleccionada borderColor: Color black.
        celdaAdyacente borderWidth: 4.
        celdaAdyacente borderColor: Color red.

        "Guardar la referencia de la nueva celda seleccionada"
        celdaSeleccionada := celdaAdyacente.

        ^ celdaAdyacente
]

{ #category : 'as yet unclassified' }
Tablero >> ElegirCeldaAdyacente: X y:Y [
        | fila columna celdasAdyacentes posicionesAdyacentes adyacentes  cont|

             "Marcar la celda seleccionada"
               celdaSeleccionada borderWidth: 4.
            celdaSeleccionada borderColor: Color red.
        cont:=1.
        "Obtener la posición de la celda seleccionada"
        fila := X.
        columna := Y.

        "Inicializar la colección de celdas adyacentes"
        celdasAdyacentes := OrderedCollection new.

"Predefinir todas las posiciones posibles de las celdas adyacentes (arriba, abajo, izquierda, derecha)"
celdasAdyacentes := {
    (fila - 1) @ columna.  "Arriba"
    (fila + 1) @ columna.  "Abajo"
    fila @ (columna - 1).  "Izquierda"
    fila @ (columna + 1).  "Derecha"
}.

"Inicializar referencias y colección de celdas adyacentes anteriores"
adyacenteArriba := nil.
adyacenteAbajo := nil.
adyacenteIzquierda := nil.
adyacenteDerecha := nil.
celdasAdyacentesAnteriores := OrderedCollection new.

"Inicializar el contador para asociar direcciones"

"Iterar sobre las posiciones posibles, manteniendo la lógica de direcciones"
celdasAdyacentes do: [:pos |
    | celdaAdyacente |
    "Verificar si la posición está dentro de los límites del tablero"
    ((pos x between: 1 and: Matrix size) and: [pos y between: 1 and: (Matrix at: 1) size]) ifTrue: [
        celdaAdyacente := (Matrix at: pos x) at: pos y.
        celdaAdyacente borderWidth: 4.
        celdaAdyacente borderColor: Color white.

        "Asociar cada celda con su dirección específica según el contador"
        cont caseOf: {
            [1] -> [
                celdaAdyacente on: #mouseUp send: #manejarClicEnCeldaAdyacenteArriba to: self.
                adyacenteArriba := celdaAdyacente.
            ].
            [2] -> [
                celdaAdyacente on: #mouseUp send: #manejarClicEnCeldaAdyacenteAbajo to: self.
                adyacenteAbajo := celdaAdyacente.
            ].
            [3] -> [
                celdaAdyacente on: #mouseUp send: #manejarClicEnCeldaAdyacenteIzquierda to: self.
                adyacenteIzquierda := celdaAdyacente.
            ].
            [4] -> [
                celdaAdyacente on: #mouseUp send: #manejarClicEnCeldaAdyacenteDerecha to: self.
                adyacenteDerecha := celdaAdyacente.
            ].
        }.

        "Agregar la celda válida a la colección de referencias anteriores"
        celdasAdyacentesAnteriores add: celdaAdyacente.
    ].

    "Avanzar al siguiente contador para la próxima dirección"
    cont := cont + 1.
].

		

]

{ #category : 'as yet unclassified' }
Tablero >> EncontrarCeldaRandom [ 
        | filaAleatoria columnaAleatoria celdaAleatoria totalCeldas contador X Y|

        "Generar índices aleatorios para fila y columna"
        filaAleatoria := (1 to: Matrix size) atRandom.
        columnaAleatoria := (1 to: (Matrix at: filaAleatoria) size) atRandom.

        "Obtener la celda aleatoria"
        celdaAleatoria := (Matrix at: filaAleatoria) at: columnaAleatoria.

        "Restaurar la celda previamente seleccionada si existe"
        celdaSeleccionada ifNotNil: [
            celdaSeleccionada borderWidth: 2.
            celdaSeleccionada borderColor: Color black.
        ].

        "Restaurar las celdas adyacentes del turno anterior si existen"
        celdasAdyacentesAnteriores ifNotNil: [
            celdasAdyacentesAnteriores do: [:celdaAdyacente |
                celdaAdyacente borderWidth: 2.
                celdaAdyacente borderColor: Color black.
            ].
        ].

        "Guardar la referencia de la celda seleccionada"
        celdaSeleccionada := celdaAleatoria.

        "Hacer que todas las celdas titilen y luego marcar las celdas seleccionadas y adyacentes"
        totalCeldas := Matrix size * (Matrix at: 1) size.
        contador := 0.

        Matrix do: [:fila |
            fila do: [:celda |
                self titilarCelda: celda after: [
                    contador := contador + 1.
                    (contador = totalCeldas) ifTrue: [
                        self ElegirCeldaAdyacente:filaAleatoria  y:columnaAleatoria.
                    ].
                ].
            ].
        ].
        "Llamar al método para elegir una celda adyacente"
       	"jiji"

        ^ celdaAleatoria
]

{ #category : 'as yet unclassified' }
Tablero >> ivo [ 
	^nil
]

{ #category : 'as yet unclassified' }
Tablero >> manejarClicEnCeldaAdyacente [
	|duelo |
        "Mostrar la celda adyacente que fue tocada"
		  Transcript show: 'Celda seleccionada: ', celdaSeleccionada printString, ' (', celdaSeleccionada getX asString, ',', celdaSeleccionada getY asString, ')'; cr.
        Transcript show: 'Celda adyacente tocada: ', celdaAdyacente printString, ' (', celdaAdyacente  getX asString, ',', celdaAdyacente  getY asString, ')'; cr.
		
		duelo:= Duelo new iniciarDueloEntre: (celdaSeleccionada GetPropietario) jugador2: (celdaAdyacente GetPropietario)
			
]

{ #category : 'as yet unclassified' }
Tablero >> manejarClicEnCeldaAdyacente: celdaAdyacente [
        "Mostrar la celda adyacente que fue tocada"
		  Transcript show: 'Celda seleccionada: ', celdaSeleccionada printString, ' (', celdaSeleccionada getX asString, ',', celdaSeleccionada getY asString, ')'; cr.
        Transcript show: 'Celda adyacente tocada: ', celdaAdyacente class
]

{ #category : 'as yet unclassified' }
Tablero >> manejarClicEnCeldaAdyacenteAbajo [
    |duelo |
        "Mostrar la celda adyacente que fue tocada"
          Transcript show: 'Celda seleccionada: ', celdaSeleccionada printString, ' (', celdaSeleccionada getX asString, ',', celdaSeleccionada getY asString, ')'; cr.

        Transcript show: 'Celda adyacente tocada: ', adyacenteAbajo printString, ' (', ( adyacenteAbajo )  getX asString, ',', adyacenteAbajo getY asString, ')'; cr.

        duelo:= Duelo new iniciarDueloEntre: (celdaSeleccionada GetPropietario) jugador2: (adyacenteAbajo GetPropietario) .

]

{ #category : 'as yet unclassified' }
Tablero >> manejarClicEnCeldaAdyacenteArriba [
    |duelo |
        "Mostrar la celda adyacente que fue tocada"
          Transcript show: 'Celda seleccionada: ', celdaSeleccionada printString, ' (', celdaSeleccionada getX asString, ',', celdaSeleccionada getY asString, ')'; cr.
        Transcript show: 'Celda adyacente tocada: ', adyacenteArriba printString, ' (', adyacenteArriba getX asString, ',', adyacenteArriba  getY asString, ')'; cr.

        duelo:= Duelo new iniciarDueloEntre: (celdaSeleccionada GetPropietario) jugador2: (adyacenteArriba GetPropietario).


]

{ #category : 'as yet unclassified' }
Tablero >> manejarClicEnCeldaAdyacenteDerecha [
    |duelo |
        "Mostrar la celda adyacente que fue tocada"
          Transcript show: 'Celda seleccionada: ', celdaSeleccionada printString, ' (', celdaSeleccionada getX asString, ',', celdaSeleccionada getY asString, ')'; cr.
        Transcript show: 'Celda adyacente tocada: ', adyacenteDerecha printString, ' (', adyacenteDerecha  getX asString, ',', adyacenteDerecha  getY asString, ')'; cr.

     duelo:= Duelo new iniciarDueloEntre: (celdaSeleccionada GetPropietario) jugador2: (adyacenteDerecha GetPropietario).
]

{ #category : 'as yet unclassified' }
Tablero >> manejarClicEnCeldaAdyacenteIzquierda [
    |duelo |
        "Mostrar la celda adyacente que fue tocada"

          Transcript show: 'Celda seleccionada: ', celdaSeleccionada printString, ' (', celdaSeleccionada getX asString, ',', celdaSeleccionada getY asString, ')'; cr.
        Transcript show: 'Celda adyacente tocada: ', adyacenteIzquierda printString, ' (', adyacenteIzquierda   getX asString, ',', adyacenteIzquierda  getY asString, ')'; cr.

        duelo:= Duelo new iniciarDueloEntre: (celdaSeleccionada GetPropietario) jugador2: (adyacenteIzquierda GetPropietario).
]

{ #category : 'as yet unclassified' }
Tablero >> marcarCeldasSeleccionadasYAdyacentes: fila columna: columna [ 
        | posicionesAdyacentes adyacentes |

    

    "Marcar la celda seleccionada"
    celdaSeleccionada borderWidth: 4.
    celdaSeleccionada borderColor: Color red.

    "Definir las posiciones adyacentes (arriba, abajo, izquierda, derecha)"
    posicionesAdyacentes := {
        (fila - 1) @ columna.  "Arriba"
        (fila + 1) @ columna.  "Abajo"
        fila @ (columna - 1).  "Izquierda"
        fila @ (columna + 1).  "Derecha"
    }.

    "Filtrar las posiciones que están dentro de los límites del tablero"
    adyacentes := posicionesAdyacentes select: [:pos |
        (pos x between: 1 and: Matrix size) and: [pos y between: 1 and: (Matrix at: 1) size]
    ].

    "Marcar las celdas adyacentes y almacenar la referencia"
    celdasAdyacentesAnteriores := OrderedCollection new.
    adyacentes do: [:pos |
        | celdaAdyacente |
        celdaAdyacente := (Matrix at: pos x) at: pos y.
        celdaAdyacente borderWidth: 4.
        celdaAdyacente borderColor: Color white.
        celdasAdyacentesAnteriores add: celdaAdyacente.
    ].


]

{ #category : 'as yet unclassified' }
Tablero >> titilarCelda: celda after: aBlock [ 
        | originalColor |
    originalColor := celda color.
    [ 10 timesRepeat: [
        celda color: Color yellow.
        (Delay forMilliseconds: 200) wait.
        celda color: Color blue.
        (Delay forMilliseconds: 200) wait.
    ].
    celda color: originalColor.  "Restaurar el color original al final"
    aBlock value.  "Ejecutar el bloque después de que termine de titilar"
    ] fork.
]
