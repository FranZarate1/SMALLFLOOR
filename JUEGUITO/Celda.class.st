Class {
	#name : 'Celda',
	#superclass : 'Morph',
	#instVars : [
		'COLORCELDA',
		'x',
		'y',
		'Propietario'
	],
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
Celda >> CrearCelda: ancho altoo: alto fila: i columna: j [
    | etiqueta jugador  |

    "Configuración visual"
    COLORCELDA := Color random.
    self color: COLORCELDA.
    self extent: ancho @ alto.
    self borderWidth: 2.
    self borderColor: Color black.

    "Configurar las posiciones X e Y"
    self setX: i.
    self setY: j.

    "Agregar una etiqueta con las coordenadas"
    etiqueta := StringMorph new.
    etiqueta contents: 'Jugador ', i asString, '-', j asString.
    etiqueta center: self center.
    self addMorph: etiqueta.

    "Crear un jugador y asociarlo a la celda"
    jugador := Jugador new.
    jugador CrearJugador: i color: COLORCELDA.
    jugador AgregarTerritorio: self.
    self setPropietario: jugador.

    ^ self "Devolver la instancia configurada"
]

{ #category : 'as yet unclassified' }
Celda >> CrearCelda: ancho altoo: alto fila: i columna: j juegador: num [ 
    | etiqueta jugador  |
    
    "Configuración visual"
    COLORCELDA := Color random.
    self color: COLORCELDA.
    self extent: ancho @ alto.
    self borderWidth: 2.
    self borderColor: Color black.

    "Configurar las posiciones X e Y"
    self setX: i.
    self setY: j.

    "Agregar una etiqueta con las coordenadas"
    etiqueta := StringMorph new.
    etiqueta contents: 'Jugador ', i asString, '-', j asString.
    etiqueta center: self center.
    self addMorph: etiqueta.

    "Crear un jugador y asociarlo a la celda"
    jugador := Jugador new.
    jugador CrearJugador: num color: COLORCELDA.
    jugador AgregarTerritorio: self.
    self setPropietario: jugador.

    ^ self "Devolver la instancia configurada"
]

{ #category : 'as yet unclassified' }
Celda >> GetPropietario [
^Propietario.
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
Celda >> initialize [ 
super initialize .
	 x := 0.
    y := 0.
    Propietario := nil.
]

{ #category : 'initialization' }
Celda >> setColor:unColor [
	COLORCELDA :=unColor .
	
]

{ #category : 'initialization' }
Celda >> setPropietario:unPropietario [
	Propietario:=unPropietario .
]

{ #category : 'initialization' }
Celda >> setX: posicionX [
	x:= posicionX asInteger.
]

{ #category : 'initialization' }
Celda >> setY: posicionY [
	y:= posicionY asInteger.
]
