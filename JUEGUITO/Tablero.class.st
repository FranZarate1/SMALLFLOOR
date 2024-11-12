Class {
	#name : 'Tablero',
	#superclass : 'Object',
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
Tablero >> Crear_Tablero: filap columna:columnap [
	| tablero ventana filas columnas celda fila anchoCelda altoCelda totalAncho totalAlto  |

ventana := SystemWindow new.
ventana setLabel: 'Tablero 4x4'.
ventana extent: 400@400.  "Tamaño inicial de la ventana."

filas := filap .  "Número de filas"
columnas := columnap .  "Número de columnas"

"Calcular el tamaño de las celdas según el tamaño de la ventana"
totalAncho := ventana extent x.  "Ancho total de la ventana"
totalAlto := ventana extent y.  "Alto total de la ventana"
anchoCelda := totalAncho // columnas.  "Ancho de cada celda"
altoCelda := totalAlto // filas.  "Alto de cada celda"

"Crear el contenedor para las filas"
tablero := Morph new.
tablero layoutPolicy: TableLayout new.  "Usar TableLayout para organizar las filas."
tablero listDirection: #topToBottom.  "Organizar de arriba hacia abajo."

tablero hResizing: #spaceFill; vResizing: #spaceFill.  "Permitir que se ajuste al espacio disponible."

1 to: filas do: [ :i |
    "Crear un contenedor para la fila"
    fila := Morph new.
    fila layoutPolicy: TableLayout new.  "Usar TableLayout para organizar las celdas."
    fila listDirection: #leftToRight.  "Organizar de izquierda a derecha."

    "Ajustar el tamaño de la fila para que ocupe todo el ancho"
    fila extent: totalAncho @ altoCelda.  "Cada fila tendrá un alto dinámico según la ventana."

    1 to: columnas do: [ :j |
       		"Crear la celda pasando el tamaño y las coordenadas"
            celda := Celda new CrearCelda: anchoCelda altoo: altoCelda fila: i columna: j.
            
            "Agregar la celda a la fila"
            fila addMorphBack: celda.
    ].

    "Agregar la fila al tablero"
    tablero addMorphBack: fila.
].

"Agregar el tablero dentro de la ventana"
ventana addMorph: tablero.
ventana openInWorld.
]