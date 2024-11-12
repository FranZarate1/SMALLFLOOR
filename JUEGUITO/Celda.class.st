Class {
	#name : 'Celda',
	#superclass : 'Object',
	#instVars : [
		'COLORCELDA',
		'POS_I',
		'POS_J'
	],
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
Celda >> CrearCelda: ancho altoo: alto fila: i columna: j [
    | celdaMorph etiqueta |
    celdaMorph := Morph new.  "Crear un Morph directamente para representar la celda"
    celdaMorph extent: ancho @ alto.  "Asignar el tamaño de la celda"
    celdaMorph borderWidth: 2.  "Asignar el ancho del borde"
    celdaMorph borderColor: Color black.  "Asignar el color del borde"
	 COLORCELDA:=Color random.  "Asignar un color aleatorio inicial"
	 celdaMorph  color: COLORCELDA.
    
    "Agregar una etiqueta con el texto 'Jugador' y las coordenadas"
    etiqueta := StringMorph new.
    etiqueta contents: 'Jugador ', i asString, '-', j asString.
	 POS_I:=i.
	 POS_J:=j.
    etiqueta center: celdaMorph center.  "Centrar la etiqueta dentro de la celda"
    celdaMorph addMorph: etiqueta.
    
    "Configurar acción para cambiar de color al hacer clic"
    celdaMorph on: #mouseUp send: #value to: [ celdaMorph color: Color random ].
    
    ^ celdaMorph  "Devolver el Morph creado"
]
