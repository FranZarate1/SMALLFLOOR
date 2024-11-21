Class {
	#name : 'Tablero',
	#superclass : 'Object',
	#instVars : [
		'Matrix'
	],
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
Tablero >> Crear_Tablero: filap columna: columnap [
    | tablero ventana ventana2 filas columnas celda anchoCelda altoCelda totalAncho totalAlto matrizCeldas xOffset yOffset botonB |

    ventana2 := SystemWindow new.
    ventana2 setLabel: 'Tablero 4x4'.
    ventana2 extent: 800@870.  "Tamaño inicial de la ventana."

    ventana := SystemWindow new.
    ventana extent: 800@800.  "Tamaño inicial de la ventana."

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
            celda position: xOffset@yOffset.  "Colocar la celda en su posición en el tablero"
            
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
        position: 375@830.  "Primer N° posición horizontal y el segundo la vertical"
    ventana2 addMorph: botonB.
    ventana2 addMorph: ventana.

    ventana2 openInWorld.
   

]

{ #category : 'as yet unclassified' }
Tablero >> EncontrarCeldaRandom [ 
    | filaAleatoria columnaAleatoria celdaAleatoria celdaSeleccionada |

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

    "Hacer que todas las celdas titilen"
    Matrix do: [:fila | fila do: [:celda | self titilarCelda: celda]].

    "Marcar la nueva celda seleccionada"
    celdaAleatoria borderWidth: 4.
    celdaAleatoria borderColor: Color red.

    "Guardar la referencia de la celda seleccionada"
    celdaSeleccionada := celdaAleatoria.

    ^ celdaAleatoria

]

{ #category : 'as yet unclassified' }
Tablero >> titilarCelda: celda [
    | originalColor|
    originalColor := celda color.
    [ 10 timesRepeat: [
        celda color: Color yellow.
        (Delay forMilliseconds: 200) wait.
        celda color: Color blue.
        (Delay forMilliseconds: 200) wait.
    ].
    celda color: originalColor.  "Restaurar el color original al final"
    ] fork.
]
