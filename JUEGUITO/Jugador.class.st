Class {
	#name : 'Jugador',
	#superclass : 'Object',
	#instVars : [
		'nombre',
		'COLOR',
		'territorio',
		'cant_celdas'
	],
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
Jugador >> AgregarTerritorio: otroTerritorio [ 
    | combinado |
    "Asegurarse de que territorio sea una colección válida"
    territorio ifNil: [territorio := OrderedCollection new]. "Inicializar si es nil"
    
    "Convertir territorio a OrderedCollection si no lo es"
    combinado := territorio asOrderedCollection.
    
    "Agregar el nuevo territorio"
    combinado add: otroTerritorio. "add en lugar de addAll porque parece ser una única celda"
    
    "Volver a asignar como Array si es necesario"
    territorio := combinado asArray.  
    
    "Mensaje para confirmar la operación"
    Transcript show: 'Territorio actualizado: ', territorio printString; cr.
]

{ #category : 'as yet unclassified' }
Jugador >> CrearJugador: unNombre color: unColor [ 
        self SetNombre: unNombre.
        self SetColor: unColor.
        territorio := #().
        "Aquí puedes agregar el jugador a una colección si necesitas mantener un registro de ellos"
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
Jugador >> actualizarColorTerritorio [ [
    territorio do: [ :celda |
        (celda color ~= COLOR) ifTrue: [
            celda color: COLOR.
        ].
    ].
]
]

{ #category : 'initialization' }
Jugador >> initialize [
    super initialize.
    territorio := OrderedCollection new. "Inicializar como una colección vacía"
]
