Class {
	#name : 'SMALLFLOOR',
	#superclass : 'Object',
	#instVars : [
		'fila',
		'columna',
		'flag_config',
		'ventana',
		'ventanax'
	],
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
SMALLFLOOR >> Iniciar [

	| tmp1 tmp2 tmp3 tmp4 |
	ventana := Morph new.
	ventana
		extent: 400 @ 300;
		openInWorld.
	flag_config := false.
	tmp1 := SimpleButtonMorph new.
	tmp1
		label: 'Iniciar Juego';
		target: self;
		actionSelector: #accionBoton1;
		position: 160 @ 150.
	ventana addMorph: tmp1.
	tmp2 := SimpleButtonMorph new.
	tmp2
		label: 'Configuraciones';
		target: self;
		actionSelector: #accionBoton2;
		position: 150 @ 200.
	ventana addMorph: tmp2.
	tmp3 := SimpleButtonMorph new.
	tmp3
		label: 'Instrucciones';
		target: self;
		actionSelector: #accionBoton3;
		position: 160 @ 250.
	ventana addMorph: tmp3.
	tmp4 := SimpleButtonMorph new.
	tmp4
		label: 'X';
		target: self;
		actionSelector: #accionBoton4;
		position: 385 @ 19.
	ventana addMorph: tmp4
]

{ #category : 'as yet unclassified' }
SMALLFLOOR >> Jugadores_2 [
		  fila:=2 asInteger.
		  columna:=2 asInteger.
		  flag_config:=true.
		self accionBotonX 
			
]

{ #category : 'as yet unclassified' }
SMALLFLOOR >> Jugadores_3 [
		fila:=3 asInteger.
		  columna:=3 asInteger.
		  flag_config:=true.
		self accionBotonX 
]

{ #category : 'as yet unclassified' }
SMALLFLOOR >> Jugadores_4 [
		  fila:=4 asInteger.
		  columna:=4 asInteger.
		  flag_config:=true.
		self accionBotonX 
]

{ #category : 'as yet unclassified' }
SMALLFLOOR >> Jugadores_5 [
	fila:=5 asInteger.
		  columna:=5 asInteger.
		  flag_config:=true.
		self accionBotonX 
]

{ #category : 'as yet unclassified' }
SMALLFLOOR >> Jugadores_6 [
	     fila:=6 asInteger.
		  columna:=6 asInteger.
		  flag_config:=true.
		self accionBotonX 
]

{ #category : 'as yet unclassified' }
SMALLFLOOR >> Jugadores_7 [
	fila:=7 asInteger.
		  columna:=7 asInteger.
		  flag_config:=true.
		self accionBotonX 
]

{ #category : 'as yet unclassified' }
SMALLFLOOR >> Jugadores_8 [
		 fila:=8 asInteger.
		  columna:=8 asInteger.
		  flag_config:=true.
		self accionBotonX 
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
	| botonx boton2 boton3 boton4 boton5 boton6 boton7|
    ventanax := Morph new.
	 ventanax color: Color red.
    ventanax extent: 400@300;  "Tamaño de la ventana"
        openInWorld.

	 
	 botonx := SimpleButtonMorph new.
    botonx label: '4 jugadores'; 
        target: self; 
        actionSelector: #Jugadores_2;
        position: 100@100.
    ventanax addMorph: botonx.

    boton2 := SimpleButtonMorph new.
    boton2 label: '9 jugadores'; 
        target: self; 
		  actionSelector: #Jugadores_3 ;
        position: 200@100.  "Primer N° posición horizontal y el segundo la vertical"
    ventanax addMorph: boton2.

	 boton3 := SimpleButtonMorph new.
    boton3 label: '16 jugadores'; 
        target: self; 
	     actionSelector: #Jugadores_4;
        position: 100@150.  "Primer N° posición horizontal y el segundo la vertical"
    ventanax addMorph: boton3.

	 boton4 := SimpleButtonMorph new.
    boton4 label: '25 jugadores'; 
        target: self; 
			actionSelector: #Jugadores_5;
        position: 200@150.  "Primer N° posición horizontal y el segundo la vertical"
    ventanax addMorph: boton4.
	
	 boton5 := SimpleButtonMorph new.
    boton5 label: '36 jugadores'; 
        target: self; 
			actionSelector: #Jugadores_6 ;
        position: 100@210.  "Primer N° posición horizontal y el segundo la vertical"
    ventanax addMorph: boton5.
	
	 boton6 := SimpleButtonMorph new.
    boton6 label: '49 jugadores'; 
        target: self; 
			actionSelector: #Jugadores_7;
        position: 200@210.  "Primer N° posición horizontal y el segundo la vertical"
    ventanax addMorph: boton6.

	 boton7 := SimpleButtonMorph new.
    boton7 label: '64 jugadores'; 
        target: self; 
		  actionSelector: #Jugadores_8 ;
        position: 150@260.  "Primer N° posición horizontal y el segundo la vertical"
    ventanax addMorph: boton7.	
]

{ #category : 'as yet unclassified' }
SMALLFLOOR >> accionBoton3 [
	
]

{ #category : 'as yet unclassified' }
SMALLFLOOR >> accionBoton4 [

	ventana delete
]

{ #category : 'as yet unclassified' }
SMALLFLOOR >> accionBotonX [
    ventanax delete.
]
