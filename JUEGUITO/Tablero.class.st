Class {
	#name : 'Tablero',
	#superclass : 'Object',
	#instVars : [
		'Matrix',
		'celdaSeleccionada',
		'celdasAdyacentesAnteriores'
	],
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
Tablero >> Crear_Tablero: filap columna: columnap [ 
                | tablero ventana ventana2 filas columnas celda anchoCelda altoCelda totalAncho totalAlto matrizCeldas xOffset yOffset botonB |

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
                celda := Celda new CrearCelda: anchoCelda altoo: altoCelda fila: i columna: j.
                celda position: xOffset @ yOffset.  "Colocar la celda en su posición en el tablero"
                
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
        botonB label: 'Iniciar Juego'; 
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
Tablero >> ElegirCeldaAdyacente:uncelda [
        | fila columna celdasAdyacentes celdaAdyacente |
"comit"
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
Tablero >> EncontrarCeldaRandom [ 
    | filaAleatoria columnaAleatoria celdaAleatoria totalCeldas contador |

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
                    self marcarCeldasSeleccionadasYAdyacentes: filaAleatoria columna: columnaAleatoria.
                ].
            ].
        ].
    ].

  
    ^ celdaAleatoria
]

{ #category : 'as yet unclassified' }
Tablero >> marcarCeldasAdyacentes: fila columna: columna [ 
    | posicionesAdyacentes adyacentes |

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

    "Marcar las celdas adyacentes"
    adyacentes do: [:pos |
        | celdaAdyacente |
        celdaAdyacente := (Matrix at: pos x) at: pos y.
        celdaAdyacente borderWidth: 4.
        celdaAdyacente borderColor: Color red.
    ].
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

    "Marcar las celdas adyacentes"
    adyacentes do: [:pos |
        | celdaAdyacente |
        celdaAdyacente := (Matrix at: pos x) at: pos y.
        celdaAdyacente borderWidth: 4.
        celdaAdyacente borderColor: Color white.
    ]
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
