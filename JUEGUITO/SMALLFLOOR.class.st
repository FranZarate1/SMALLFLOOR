Class {
	#name : 'SMALLFLOOR',
	#superclass : 'Object',
	#instVars : [
		'fila',
		'columna',
		'flag_config'
	],
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
SMALLFLOOR >> Iniciar [
	"|ventana|

	ventana:=SystemWindow new.
	ventana setLabel: 'Inicio del juego'.
	ventana extent: 800@800 "
	
	| ventana boton1 boton2 boton3 boton4|
	
    ventana := Morph new.
    ventana extent: 400@300;  "Tamaño de la ventana"
        openInWorld.
    
	"Poner caratula en esta parte"
	
    "Crear y configurar el primer botón"
  	 flag_config := false.
	 boton1 := SimpleButtonMorph new.
    boton1 label: 'Iniciar Juego'; 
        target: self; 
        actionSelector: #accionBoton1; 
        position: 160@150.  "Primer N° posición horizontal y el segundo la vertical"
    ventana addMorph: boton1.

    "Crear y configurar el tercer botón"
    boton2 := SimpleButtonMorph new.
    boton2 label: 'Configuraciones'; 
        target: self; 
        actionSelector: #accionBoton2; 
        position: 150@200.
    ventana addMorph: boton2.

  "Crear y configurar el segundo botón"
    boton3 := SimpleButtonMorph new.
    boton3 label: 'Instrucciones'; 
        target: self; 
        actionSelector: #accionBoton3; 
        position: 160@250.
    ventana addMorph: boton3.

	"Crear y configurar el segundo botón"
    boton4 := SimpleButtonMorph new.
    boton4 label: 'X'; 
        target: self; 
        actionSelector: #accionBoton3; 
        position: 385@19.
    ventana addMorph: boton4.
	
	
	
	
]

{ #category : 'as yet unclassified' }
SMALLFLOOR >> accionBoton1 [
    "Aquí defines qué hace el primer botón"
    |p|
	flag_config ifFalse: [ p:= Tablero new Crear_Tablero: 4 columna: 4.] 
	ifTrue: [ p:= Tablero new Crear_Tablero: fila columna: columna .  ].
	
	
	
	
	
]

{ #category : 'as yet unclassified' }
SMALLFLOOR >> accionBoton2 [
    "Aquí defines qué hace el segundo botón"
	| ventana|
	
    ventana := Morph new.
    ventana extent: 400@300;  "Tamaño de la ventana"
        openInWorld.
	
	fila:= (UIManager default request: 'Elija la cantidad de filas:')asInteger.
	columna:= (UIManager default request: 'Elija la cantidad de columnas:')asInteger.
	flag_config:=true. 
	
	ventana delete.

	
	
]

{ #category : 'as yet unclassified' }
SMALLFLOOR >> accionBoton3 [
	
]
