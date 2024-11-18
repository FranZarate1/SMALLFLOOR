Class {
	#name : 'Celda',
	#superclass : 'Object',
	#instVars : [
		'COLORCELDA',
		'x',
		'y',
		'NumeroJugador'
	],
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
Celda >> CrearCelda: ancho altoo: alto fila: i columna: j [
    | celdaMorph etiqueta Juegador |
	 NumeroJugador :=0 asInteger.
    celdaMorph := Morph new.  "Crear un Morph directamente para representar la celda"
	 COLORCELDA:= Color random.
	 celdaMorph color: COLORCELDA.  "Asignar un color aleatorio inicial"
    celdaMorph extent: ancho @ alto.  "Asignar el tamaño de la celda"
    celdaMorph borderWidth: 2.  "Asignar el ancho del borde"
    celdaMorph borderColor: Color black.  "Asignar el color del borde"
    
    "Agregar una etiqueta con el texto 'Jugador' y las coordenadas"
    etiqueta := StringMorph new.
    etiqueta contents: 'Jugador ', i asString, '-', j asString.
    etiqueta center: celdaMorph center.  "Centrar la etiqueta dentro de la celda"
    celdaMorph addMorph: etiqueta.
	
	 
	 "Guardar las posiciones X e Y de la celda"
    self setX: i.  "Guardar posición X"
    self setY: j.  "Guardar posición Y"

     NumeroJugador := (NumeroJugador + 1).
	  "crea jugadores"
	  Juegador:= Jugador new.
	  Juegador CrearJugador: NumeroJugador  color: COLORCELDA . 	
	 	

    "Configurar acción para cambiar de color al hacer clic"
    celdaMorph on: #mouseUp send: #value to: [ celdaMorph color: Color random ].
    
    ^ celdaMorph  "Devolver el Morph creado"
]

{ #category : 'as yet unclassified' }
Celda >> getX [
	^x.
]

{ #category : 'as yet unclassified' }
Celda >> getY [
	^y.
]

{ #category : 'initialization' }
Celda >> setX: posicionX [
	x:= posicionX asInteger.
]

{ #category : 'initialization' }
Celda >> setY: posicionY [
	y:= posicionY asInteger.
]
