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
Jugador >> CrearJugador: unNombre color: unColor [
   
    self SetNombre: unNombre .
	 self SetColor: unColor.
    "Aquí puedes agregar el jugador a una colección si necesitas mantener un registro de ellos"
     Transcript show: 'Jugador creado: ', (unNombre +1) asString, ' con color: ', unColor printString; cr.
    ^self.

]

{ #category : 'as yet unclassified' }
Jugador >> SetColor:colorr [
COLOR:=colorr.

]

{ #category : 'as yet unclassified' }
Jugador >> SetNombre:nombree [
 nombre:=nombree.
]
