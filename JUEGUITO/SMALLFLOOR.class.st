Class {
	#name : 'SMALLFLOOR',
	#superclass : 'Object',
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
SMALLFLOOR >> Iniciar [
	"|ventana|

	ventana:=SystemWindow new.
	ventana setLabel: 'Inicio del juego'.
	ventana extent: 800@800 "
	
	| ventana boton1 boton2 boton3|
	
    ventana := Morph new.
    ventana extent: 400@300;  "Tamaño de la ventana"
        openInWorld.
    
	"Poner caratula en esta parte"
	
    "Crear y configurar el primer botón"
    boton1 := SimpleButtonMorph new.
    boton1 label: 'Iniciar Juego'; 
        target: self; 
        actionSelector: #accionBoton1; 
        position: 160@150.  "Primer N° posición horizantal y el segundo la vertical"
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
	
	
	
	
]

{ #category : 'as yet unclassified' }
SMALLFLOOR >> accionBoton1 [
    "Aquí defines qué hace el primer botón"
    |p|
	p:= Tablero new.
	
	p Crear_Tablero 
	
]

{ #category : 'as yet unclassified' }
SMALLFLOOR >> accionBoton2 [
    "Aquí defines qué hace el segundo botón"
    Transcript show: 'Botón 2 presionado'; cr.
]

{ #category : 'as yet unclassified' }
SMALLFLOOR >> accionBoton3 [
	
]
