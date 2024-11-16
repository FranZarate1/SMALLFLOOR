Class {
	#name : 'Celda',
	#superclass : 'Object',
	#instVars : [
		'COLORCELDA',
		'Posx',
		'Posy'
	],
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
Celda >> CrearCelda: ancho altoo: alto fila: i columna: j [
    | celdaMorph etiqueta |
	 
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
    "Configurar acción para cambiar de color al hacer clic"
    celdaMorph on: #mouseUp send: #value to: [ celdaMorph color: Color random ].
	 self Posicionx: i.  "Guardar posición X"
    self Posiciony: j.  "Guardar posición Y"
    
    ^ celdaMorph  "Devolver el Morph creado"
]

{ #category : 'as yet unclassified' }
Celda >> Posicionx: valorx [
	|x|
	x:= valorx.
	Posx:= x .

]

{ #category : 'as yet unclassified' }
Celda >> Posiciony: valory [ 
	|y|
	y:= valory.
    Posy := y.

]
