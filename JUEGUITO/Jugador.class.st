Class {
	#name : 'Jugador',
	#superclass : 'Object',
	#instVars : [
		'nombre',
		'COLOR',
		'territorio',
		'cant_celdas',
		'flagDuelo'
	],
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
Jugador >> AgregarTerritorio: otroTerritorio [ 
        territorio ifNil: [territorio := OrderedCollection new]. "Inicializar si es nil"

        "Verificar si otroTerritorio es una colección"
        (otroTerritorio isCollection) 
            ifTrue: [territorio addAll: otroTerritorio]  "Agregar todos los elementos si es una colección"
            ifFalse: [territorio add: otroTerritorio].  "Agregar el objeto directamente si no es una colección"

        "Imprimir el resultado en el Transcript para depuración"
        Transcript show: 'Territorio actualizado: ', territorio printString; cr.
    
    
]

{ #category : 'as yet unclassified' }
Jugador >> CrearJugador: unNombre color: unColor [ 
    self SetNombre: unNombre asInteger.
    self SetColor: unColor.
    territorio := OrderedCollection new. "Inicializa territorio como una colección vacía"
    Transcript show: 'Jugador creado: ', unNombre asString, ' con color: ', unColor printString; cr.
    ^ self.
    

]

{ #category : 'as yet unclassified' }
Jugador >> GetColor [
	^COLOR .
 
]

{ #category : 'as yet unclassified' }
Jugador >> SetColor:colorr [
COLOR:=colorr.

]

{ #category : 'as yet unclassified' }
Jugador >> SetNombre:nombree [
 nombre:=nombree.
]

{ #category : 'as yet unclassified' }
Jugador >> activarDuelo [ 
        flagDuelo := true.
    
]

{ #category : 'as yet unclassified' }
Jugador >> actualizarColorTerritorio [
    "Actualizar el color de todas las celdas en el territorio del jugador"
    territorio ifNil: [^self]. "Evitar errores si el territorio está vacío"

    territorio do: [:celda |
        (celda color ~= self GetColor ) ifTrue: [
            celda color: self GetColor.
        ].
    ].
]

{ #category : 'as yet unclassified' }
Jugador >> desactivarDuelo [ 
        flagDuelo := false.
    
]

{ #category : 'as yet unclassified' }
Jugador >> estaEnDuelo [ 
      ^flagDuelo == true
    
]

{ #category : 'as yet unclassified' }
Jugador >> getNombre [
	^nombre .
]

{ #category : 'as yet unclassified' }
Jugador >> getTerritorio [
	^territorio 
]

{ #category : 'initialization' }
Jugador >> initialize [
    super initialize.
    territorio := OrderedCollection new. "Inicializar como una colección vacía"
 "Inicializamos la bandera en falso"
    flagDuelo := false.
]

{ #category : 'as yet unclassified' }
Jugador >> vaciarTerritorio [ 
    "Vaciar el territorio si no es nil"
    territorio ifNotNil: [territorio removeAll].

]
