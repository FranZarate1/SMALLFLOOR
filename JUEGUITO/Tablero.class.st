Class {
	#name : 'Tablero',
	#superclass : 'Object',
	#instVars : [
		'Matrix',
		'celdaSeleccionada',
		'celdasAdyacentesAnteriores',
		'celdaAdyacente',
		'adyacenteArriba',
		'adyacenteAbajo',
		'adyacenteDerecha',
		'adyacenteIzquierda',
		'botones'
	],
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
Tablero >> Crear_Tablero: arg1 columna: arg2 [

	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 tmp7 tmp8 tmp9 tmp10 tmp11 tmp12 tmp13 tmp14 tmp15 tmp16 tmp17 tmp18 tmp20 |
	tmp15 := 1.
	tmp3 := SystemWindow new.
	tmp3
		setLabel: 'Tablero 4x4';
		extent: 800 @ 700.
	tmp2 := SystemWindow new.
	tmp2 extent: 800 @ 600.
	tmp4 := arg1.
	tmp5 := arg2.
	tmp9 := tmp2 extent x.
	tmp10 := tmp2 extent y.
	tmp7 := tmp9 // tmp5.
	tmp8 := tmp10 // tmp4.
	tmp1 := Morph new.
	tmp1
		layoutPolicy: nil;
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	tmp11 := Array new: tmp4.
	tmp16 := tmp4.
	tmp18 := tmp16.
	1 to: tmp18 do: [ :tmp19 | tmp11 at: tmp19 put: (Array new: tmp5) ].
	1.
	tmp13 := 0.
	tmp16 := tmp4.
	tmp18 := tmp16.
	1 to: tmp18 do: [ :tmp19 |
		tmp12 := 0.
		tmp17 := tmp5.
		tmp20 := tmp17.
		1 to: tmp20 do: [ :tmp21 |
			tmp6 := Celda new
				        CrearCelda: tmp7
				        altoo: tmp8
				        fila: tmp19
				        columna: tmp21
				        juegador: tmp15
						  total:arg1.
			tmp6 position: tmp12 @ tmp13.
			tmp15 := tmp15 + 1.
			(tmp11 at: tmp19) at: tmp21 put: tmp6.
			tmp1 addMorph: tmp6.
			tmp12 := tmp12 + tmp7 ].
		1.
		tmp13 := tmp13 + tmp8 ].
	1.
	Matrix := tmp11.
	tmp2 addMorph: tmp1.
	tmp14 := SimpleButtonMorph new.
	tmp14
		label: 'Encontrar Celda Random';
		target: self;
		actionSelector: #EncontrarCeldaRandom;
		position: 350 @ 630.
	tmp3
		addMorph: tmp14;
		addMorph: tmp2;
		openInWorld
]

{ #category : 'as yet unclassified' }
Tablero >> ElegirCeldaAdyacente: X y: Y [ 
    | fila columna celdasAdyacentes posicionesAdyacentes adyacentes cont botonTemporal  |

    "Marcar la celda seleccionada"
    celdaSeleccionada borderWidth: 4.
    celdaSeleccionada borderColor: Color red.

    cont := 1.
    "Obtener la posición de la celda seleccionada"
    fila := X.
    columna := Y.

    "Inicializar la colección de celdas adyacentes"
    celdasAdyacentes := OrderedCollection new.
    botones := OrderedCollection new.  "Colección para almacenar los botones"

    "Predefinir todas las posiciones posibles de las celdas adyacentes (arriba, abajo, izquierda, derecha)"
    celdasAdyacentes := {
        (fila - 1) @ columna.  "Arriba"
        (fila + 1) @ columna.  "Abajo"
        fila @ (columna - 1).  "Izquierda"
        fila @ (columna + 1).  "Derecha"
    }.

    "Inicializar referencias y colección de celdas adyacentes anteriores"
    adyacenteArriba := nil.
    adyacenteAbajo := nil.
    adyacenteIzquierda := nil.
    adyacenteDerecha := nil.
    celdasAdyacentesAnteriores := OrderedCollection new.

    "Inicializar el contador para asociar direcciones"
    celdasAdyacentes do: [:pos |
        | celdaAdyacente |
        "Verificar si la posición está dentro de los límites del tablero"
        ((pos x between: 1 and: Matrix size) and: [pos y between: 1 and: (Matrix at: 1) size]) ifTrue: [
            celdaAdyacente := (Matrix at: pos x) at: pos y.
            celdaAdyacente borderWidth: 4.
            celdaAdyacente borderColor: Color white.
					celdaSeleccionada GetPropietario = celdaAdyacente GetPropietario ifFalse: [  
            "Asociar cada celda con su dirección específica según el contador"
            cont caseOf: {
                [1] -> [
                    adyacenteArriba := celdaAdyacente.
                    botonTemporal := SimpleButtonMorph new.
                    botonTemporal label: 'Seleccionar'.
                    botonTemporal target: self.
                    botonTemporal actionSelector: #manejarClicEnCeldaAdyacenteArriba.

                    botonTemporal extent: celdaAdyacente extent // 2.
                    botonTemporal position: celdaAdyacente position + (celdaAdyacente extent // 4).
                    celdaAdyacente addMorph: botonTemporal.
                    botones add: botonTemporal. "Añadir el botón a la colección"
                ].
                [2] -> [
                    adyacenteAbajo := celdaAdyacente.
                    botonTemporal := SimpleButtonMorph new.
                    botonTemporal label: 'Seleccionar'.
                    botonTemporal target: self.
                    botonTemporal actionSelector: #manejarClicEnCeldaAdyacenteAbajo.

                    botonTemporal extent: celdaAdyacente extent // 2.
                    botonTemporal position: celdaAdyacente position + (celdaAdyacente extent // 4).
                    celdaAdyacente addMorph: botonTemporal.
                    botones add: botonTemporal. "Añadir el botón a la colección"
                ].
                [3] -> [
                    adyacenteIzquierda := celdaAdyacente.
                    botonTemporal := SimpleButtonMorph new.
                    botonTemporal label: 'Seleccionar'.
                    botonTemporal target: self.
                    botonTemporal actionSelector: #manejarClicEnCeldaAdyacenteIzquierda.

                    botonTemporal extent: celdaAdyacente extent // 2.
                    botonTemporal position: celdaAdyacente position + (celdaAdyacente extent // 4).
                    celdaAdyacente addMorph: botonTemporal.
                    botones add: botonTemporal. "Añadir el botón a la colección"
                ].
                [4] -> [
                    adyacenteDerecha := celdaAdyacente.
                    botonTemporal := SimpleButtonMorph new.
                    botonTemporal label: 'Seleccionar'.
                    botonTemporal target: self.
                    botonTemporal actionSelector: #manejarClicEnCeldaAdyacenteDerecha.

                    botonTemporal extent: celdaAdyacente extent // 2.
                    botonTemporal position: celdaAdyacente position + (celdaAdyacente extent // 4).
                    celdaAdyacente addMorph: botonTemporal.
                    botones add: botonTemporal. "Añadir el botón a la colección"
                ].
            }.
			]
            "Agregar la celda válida a la colección de referencias anteriores"
            "celdasAdyacentesAnteriores add: celdaAdyacente."
        ].

        "Avanzar al siguiente contador para la próxima dirección"
        cont := cont + 1.
    ].

]

{ #category : 'as yet unclassified' }
Tablero >> EncontrarCeldaRandom [

	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 tmp8 |
	tmp1 := (1 to: Matrix size) atRandom.
	tmp2 := (1 to: (Matrix at: tmp1) size) atRandom.
	tmp3 := (Matrix at: tmp1) at: tmp2.
	celdaSeleccionada ifNotNil: [
		celdaSeleccionada
			borderWidth: 2;
			borderColor: Color black ].
	celdasAdyacentesAnteriores ifNotNil: [
		celdasAdyacentesAnteriores do: [ :arg1 |
			arg1
				borderWidth: 2;
				borderColor: Color black ] ].
	celdaSeleccionada := tmp3.
	tmp4 := Matrix size * (Matrix at: 1) size.
	tmp8 := 0.
	Matrix do: [ :arg2 |
		arg2 do: [ :arg3 |
			self titilarCelda: arg3 after: [
				tmp8 := tmp8 + 1.
				tmp8 = tmp4 ifTrue: [ self ElegirCeldaAdyacente: tmp1 y: tmp2 ] ] ] ].
	^ tmp3
]

{ #category : 'as yet unclassified' }
Tablero >> ivo [ 
	^nil
]

{ #category : 'as yet unclassified' }
Tablero >> manejarClicEnCeldaAdyacente [

	| tmp1 |
	Transcript show: 'Celda seleccionada: ' , celdaSeleccionada printString , ' (' , celdaSeleccionada getX asString , ',' , celdaSeleccionada getY asString , ')';cr.
		Transcript show: 'Celda adyacente tocada: ' , celdaAdyacente printString , ' (', celdaAdyacente getX asString , ',' , celdaAdyacente getY asString, ')';cr.
	tmp1 := Duelo new
		        iniciarDueloEntre: (celdaSeleccionada GetPropietario) jugador2: (celdaAdyacente GetPropietario) .
botones do: [:boton |
        boton delete.
    ].
]

{ #category : 'as yet unclassified' }
Tablero >> manejarClicEnCeldaAdyacenteAbajo [
    |duelo |
        "Mostrar la celda adyacente que fue tocada"
          Transcript show: 'Celda seleccionada: ', celdaSeleccionada printString, ' (', (celdaSeleccionada getX) asString, ',', (celdaSeleccionada getY) asString, ')'; cr.

        Transcript show: 'Celda adyacente tocada: ', adyacenteAbajo printString, ' (', ( adyacenteAbajo   getX) asString, ',', (adyacenteAbajo getY) asString, ')'; cr.

        duelo:= Duelo new iniciarDueloEntre: (celdaSeleccionada GetPropietario) jugador2: (adyacenteAbajo GetPropietario) .
			
botones do: [:boton |
        boton delete.
    ].

]

{ #category : 'as yet unclassified' }
Tablero >> manejarClicEnCeldaAdyacenteArriba [
    |duelo |
        "Mostrar la celda adyacente que fue tocada"
          Transcript show: 'Celda seleccionada: ', celdaSeleccionada printString, ' (', (celdaSeleccionada getX) asString, ',', (celdaSeleccionada getY) asString, ')'; cr.
        Transcript show: 'Celda adyacente tocada: ', adyacenteArriba printString, ' (', (adyacenteArriba getX) asString, ',', (adyacenteArriba  getY) asString, ')'; cr.

        duelo:= Duelo new iniciarDueloEntre: (celdaSeleccionada GetPropietario) jugador2: (adyacenteArriba GetPropietario).

botones do: [:boton |
        boton delete.
    ].

]

{ #category : 'as yet unclassified' }
Tablero >> manejarClicEnCeldaAdyacenteDerecha [
    |duelo |
        "Mostrar la celda adyacente que fue tocada"
          Transcript show: 'Celda seleccionada: ', celdaSeleccionada printString, ' (', (celdaSeleccionada getX) asString, ',', (celdaSeleccionada getY) asString, ')'; cr.
        Transcript show: 'Celda adyacente tocada: ', adyacenteDerecha printString, ' (', (adyacenteDerecha  getX) asString, ',', (adyacenteDerecha  getY) asString, ')'; cr.

     duelo:= Duelo new iniciarDueloEntre: (celdaSeleccionada GetPropietario) jugador2: (adyacenteDerecha GetPropietario).
botones do: [:boton |
        boton delete.
    ].

]

{ #category : 'as yet unclassified' }
Tablero >> manejarClicEnCeldaAdyacenteIzquierda [
    |duelo |
        "Mostrar la celda adyacente que fue tocada"

          Transcript show: 'Celda seleccionada: ', celdaSeleccionada printString, ' (', (celdaSeleccionada getX) asString, ',', (celdaSeleccionada getY) asString, ')'; cr.
        Transcript show: 'Celda adyacente tocada: ', adyacenteIzquierda printString, ' (', (adyacenteIzquierda   getX) asString, ',', (adyacenteIzquierda  getY) asString, ')'; cr.

        duelo:= Duelo new iniciarDueloEntre: (celdaSeleccionada GetPropietario) jugador2: (adyacenteIzquierda GetPropietario).
botones do: [:boton |
        boton delete.
    ].

]

{ #category : 'as yet unclassified' }
Tablero >> marcarCeldasSeleccionadasYAdyacentes: arg1 columna: arg2 [

	| tmp1 tmp2 |
	celdaSeleccionada
		borderWidth: 4;
		borderColor: Color red.
	tmp1 := {
		        (arg1 - 1 @ arg2).
		        (arg1 + 1 @ arg2).
		        (arg1 @ (arg2 - 1)).
		        (arg1 @ (arg2 + 1)) }.
	tmp2 := tmp1 select: [ :arg3 |
		        (arg3 x between: 1 and: Matrix size) and: [
			        arg3 y between: 1 and: (Matrix at: 1) size ] ].
	celdasAdyacentesAnteriores := OrderedCollection new.
	tmp2 do: [ :arg4 |
		| tmp3 |
		tmp3 := (Matrix at: arg4 x) at: arg4 y.
		tmp3
			borderWidth: 4;
			borderColor: Color white.
		celdasAdyacentesAnteriores add: tmp3 ]
]

{ #category : 'as yet unclassified' }
Tablero >> titilarCelda: arg1 after: arg2 [

	| tmp1 |
	tmp1 := arg1 color.
	[
	1 to: 10 do: [ :tmp2 |
		arg1 color: Color yellow.
		(Delay forMilliseconds: 200) wait.
		arg1 color: Color blue.
		(Delay forMilliseconds: 200) wait ].
	1.
	arg1 color: tmp1.
	arg2 value ] fork
]
