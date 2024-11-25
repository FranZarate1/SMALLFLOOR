Class {
	#name : 'Juegos',
	#superclass : 'Object',
	#instVars : [
		'ganador_duelo'
	],
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
Juegos >> BatallaClicks [

	| ventana boton contador1 contador2 jugador1 jugador2 turnoMaximo ganador ganador_duelo tiempoLabel tiempoRestante procesoTiempo turnoActual turnoLabel tiempoEsperaLabel tiempoEspera ganadorLabel botonProceso botonDireccionX botonDireccionY random |
	"Inicializa contadores y jugadores"
	contador1 := 0.
	contador2 := 0.
	jugador1 := 'Jugador 1'.
	jugador2 := 'Jugador 2'.
	turnoMaximo := 2.
	turnoActual := 1.
	tiempoRestante := 10. "10 segundos para cada turno"
	tiempoEspera := 3. "3 segundos de pausa entre turnos"

	"Inicializa la dirección del movimiento del botón"
	botonDireccionX := 5.
	botonDireccionY := 5.

	"Crear la ventana principal"
	ventana := Morph new.
	ventana extent: 700 @ 700. "Tamaño de la ventana"
	ventana openInWorld.

	"Crear el botón de clics"
	boton := SimpleButtonMorph new.
	boton
		label: 'Haz clic aquí';
		extent: 150 @ 150.

	"Posicionar el botón dentro de los límites de la ventana"
	boton position: ventana innerBounds center - (boton extent // 2).
	ventana addMorph: boton.

	"Acción del botón"
	boton on: #mouseDown send: #value to: [
		tiempoRestante > 0 ifTrue: [
			turnoActual = 1
				ifTrue: [ contador1 := contador1 + 1 ]
				ifFalse: [ contador2 := contador2 + 1 ] ] ].

	"Crear la etiqueta para mostrar el tiempo restante"
	tiempoLabel := StringMorph new.
	tiempoLabel
		contents:
			'Tiempo restante: ' , tiempoRestante printString , ' segundos';
		position: 140 @ 50.
	ventana addMorph: tiempoLabel.

	"Crear la etiqueta para mostrar el turno actual"
	turnoLabel := StringMorph new.
	turnoLabel contents: 'Turno de: ' , (turnoActual = 1
			 ifTrue: [ jugador1 ]
			 ifFalse: [ jugador2 ]).
	turnoLabel position: 140 @ 80.
	ventana addMorph: turnoLabel.

	"Crear la etiqueta para mostrar el tiempo de espera entre turnos"
	tiempoEsperaLabel := StringMorph new.
	tiempoEsperaLabel contents: ''.
	tiempoEsperaLabel position: 140 @ 110.
	ventana addMorph: tiempoEsperaLabel.

	"Crear la etiqueta para mostrar el ganador"
	ganadorLabel := StringMorph new.
	ganadorLabel contents: ''.
	ganadorLabel position: 70 @ 170.
	ventana addMorph: ganadorLabel.

	"Proceso para mover el botón"
	random := Random new.
	botonProceso := [
		[ true ] whileTrue: [
			| nuevaPosicionX nuevaPosicionY ventanaBounds |
			(Delay forMilliseconds: 50) wait. "Esperar un intervalo corto para suavizar el movimiento"

			"Obtener los límites de la ventana"
			ventanaBounds := ventana innerBounds.

			"Calcular la nueva posición del botón"
			nuevaPosicionX := boton position x + botonDireccionX.
			nuevaPosicionY := boton position y + botonDireccionY.

			"Determinar si el botón rebota en los bordes de la ventana"
			(nuevaPosicionX < ventanaBounds left or: [
				nuevaPosicionX + boton width > ventanaBounds right ])
				ifTrue: [
				botonDireccionX := botonDireccionX negated ].
			(nuevaPosicionY < ventanaBounds top or: [
				nuevaPosicionY + boton height
				> ventanaBounds bottom ]) ifTrue: [
				botonDireccionY := botonDireccionY negated ].

			"Actualizar la posición del botón"
			boton position: nuevaPosicionX @ nuevaPosicionY ] ] fork.

	"Proceso para actualizar el tiempo y alternar turnos"
	procesoTiempo := [
    [ turnoActual <= turnoMaximo ] whileTrue: [
        tiempoRestante := 10.
        tiempoEsperaLabel contents: ''.
        tiempoEsperaLabel changed.
        [ tiempoRestante > 0 ] whileTrue: [
            (Delay forSeconds: 1) wait.
            tiempoRestante := tiempoRestante - 1.
            tiempoLabel contents: 
                'Tiempo restante: ' , tiempoRestante printString , ' segundos'.
            tiempoLabel changed
        ].
        ventana removeMorph: boton.
        turnoActual := turnoActual + 1.
        turnoActual <= turnoMaximo ifTrue: [
            tiempoEsperaLabel 
                contents: 'Esperando el siguiente turno...'; 
                changed.
            (Delay forSeconds: tiempoEspera) wait.
            turnoLabel contents: 
                'Turno de: ' , (turnoActual = 1
                    ifTrue: [ jugador1 ]
                    ifFalse: [ jugador2 ]).
            turnoLabel changed.
            boton position: ventana innerBounds center - (boton extent // 2).
            ventana addMorph: boton
        ]
    ].

    "Evaluar el ganador después de que todos los turnos hayan terminado"
    turnoActual > turnoMaximo ifTrue: [
        ganador := contador1 > contador2 
            ifTrue: [ 1 ] 
            ifFalse: [ contador2 > contador1 ifTrue: [ 2 ] ifFalse: [ 'Empate' ] ].

        "Mostrar el resultado en la interfaz"
        ganador = 'Empate'
            ifTrue: [
                ganadorLabel contents: 
                    'Empate! El juego se reiniciará.'.
                ganadorLabel changed.
                (Delay forSeconds: 3) wait.
                ventana delete.
                self ReiniciarClicks
            ]
            ifFalse: [
                ganadorLabel contents: 'Juego terminado. 
    ' , jugador1 , ': ' , contador1 printString , ' clics. 
    ' , jugador2 , ': ' , contador2 printString , ' clics. 
    Ganador: jugador ' , ganador printString.
                ganadorLabel changed.
                (Delay forSeconds: 5) wait.
                ventana delete
            ]
    ]
] fork.

]

{ #category : 'as yet unclassified' }
Juegos >> GetGanador [
	^ganador_duelo 
]

{ #category : 'as yet unclassified' }
Juegos >> NumeroSecreto [

	| ventana mensajeLabel secretNumber1 secretNumber2 guessedNumber1 guessedNumber2 attempts1 attempts2 playerTurn gameEnded |
	secretNumber1 := (1 to: 100) atRandom.
	secretNumber2 := (1 to: 100) atRandom.
	guessedNumber1 := 0.
	guessedNumber2 := 0.
	attempts1 := 0.
	attempts2 := 0.
	playerTurn := 1.
	gameEnded := false.
	ventana := Morph new.
	ventana extent: 400 @ 200.
	ventana openInWorld.
	mensajeLabel := StringMorph new.
	mensajeLabel contents:
		'Bienvenidos al juego de adivinanza de números!'.
	mensajeLabel position: 55 @ 100.
	mensajeLabel font: (LogicalFont familyName: 'Arial' pointSize: 16).
	ventana addMorph: mensajeLabel.
	[ gameEnded ] whileFalse: [
		playerTurn = 1
			ifTrue: [
				guessedNumber1 := (UIManager default
					                   request:
					                   'Jugador 1, Ingresa un número entre 1 y 100:'
					                   initialAnswer: '') asInteger.
				attempts1 := attempts1 + 1.
				guessedNumber1 = secretNumber1
					ifTrue: [
						mensajeLabel contents:
							'¡Jugador 1 ha acertado su número en ' , attempts1 printString
							, ' intentos!' ]
					ifFalse: [
						guessedNumber1 < secretNumber1
							ifTrue: [
								mensajeLabel contents:
									'¡Jugador 1, demasiado bajo! Intenta nuevamente.' ]
							ifFalse: [
								mensajeLabel contents:
									'¡Jugador 1, demasiado alto! Intenta nuevamente.' ] ].
				mensajeLabel changed.
				playerTurn := 2 ]
			ifFalse: [
				guessedNumber2 := (UIManager default
					                   request:
					                   'Jugador 2, Ingresa un número entre 1 y 100:'
					                   initialAnswer: '') asInteger.
				attempts2 := attempts2 + 1.
				guessedNumber2 = secretNumber2
					ifTrue: [
						mensajeLabel contents:
							'¡Jugador 2 ha acertado su número en ' , attempts2 printString
							, ' intentos!' ]
					ifFalse: [
						guessedNumber2 < secretNumber2
							ifTrue: [
								mensajeLabel contents:
									'¡Jugador 2, demasiado bajo! Intenta nuevamente.' ]
							ifFalse: [
								mensajeLabel contents:
									'¡Jugador 2, demasiado alto! Intenta nuevamente.' ] ].
				mensajeLabel changed.
				gameEnded := guessedNumber1 = secretNumber1 or: [
					             guessedNumber2 = secretNumber2 ].
				playerTurn := 1 ] ].
	(guessedNumber1 = secretNumber1 and: [
		 guessedNumber2 = secretNumber2 ]) ifTrue: [
		mensajeLabel contents:
			'¡Empate! Ambos jugadores acertaron en el mismo intento. Comenzará un desempate.'.
		mensajeLabel changed.
		secretNumber1 := (1 to: 100) atRandom.
		secretNumber2 := (1 to: 100) atRandom.
		guessedNumber1 := 0.
		guessedNumber2 := 0.
		attempts1 := 0.
		attempts2 := 0.
		playerTurn := 1.
		gameEnded := false ].
	guessedNumber1 = secretNumber1 ifTrue: [
		mensajeLabel contents:
			'¡Jugador 1 gana! El jugador 2 no logró acertar.'.
		mensajeLabel changed.
		ganador_duelo := 1 ].
	guessedNumber2 = secretNumber2 ifFalse: [ ^ self ].
	mensajeLabel contents:
		'¡Jugador 2 gana! El jugador 1 no logró acertar.'.
	mensajeLabel changed.
	ganador_duelo := 2
]

{ #category : 'as yet unclassified' }
Juegos >> ReiniciarClicks [
	self BatallaClicks .
]

{ #category : 'as yet unclassified' }
Juegos >> SumaTrix [
 | numeros suma usuario1 usuario2 diferencia1 diferencia2 resultado morph ventana resultadoMorph |

    "Generar tres números aleatorios entre -10 y 50"
    numeros := { (1 to: 50) atRandom. (1 to: 30) atRandom. (1 to: 40) atRandom }.

    "Calcular la suma de los tres números"
    suma := numeros sum.

    "Crear el Morph donde se mostrarán los números"
    ventana := Morph new.
    ventana color: Color white.
    ventana extent: 600 @ 300. "Aseguramos que la ventana sea suficientemente grande"
    ventana openInWorld.

    "Crear el Morph para mostrar los números"
    morph := TextMorph new.
    morph color: Color black.
    morph position: 200 @ 100.
    morph contents: 'Esperando...'.
    morph openInWorld.
    ventana addMorph: morph.

    "Crear el Morph para mostrar el resultado"
    resultadoMorph := TextMorph new.
    resultadoMorph color: Color black.
    resultadoMorph position: 200 @ 100. "Posicionar más abajo y mantener esta posición fija"
    resultadoMorph contents: ''.
    resultadoMorph openInWorld.
    ventana addMorph: resultadoMorph.

    "Mostrar los números uno a uno con un retraso de 0.5 segundos"
    [ 
        numeros do: [ :numero |
            "Mostrar el número"
            morph contents: 'Número: ', numero printString.
            morph changed. "Indicar que el Morph ha cambiado"
            
            "Esperar 0.5 segundos para que el número se muestre"
            (Delay forSeconds: 0.5) wait.

            "Borrar el número del Morph"
            morph contents: ''.
            morph changed. "Indicar que el Morph ha cambiado después de borrar"

            "Esperar 0.5 segundos antes de mostrar el siguiente número"
            (Delay forSeconds: 0.5) wait.
        ].

        "Esperar para que todos los números se hayan mostrado"
        (Delay forSeconds: 2) wait.
        
        "Después de mostrar todos los números, solicitar las respuestas de los jugadores"
        usuario1 := UIManager default request: 'Jugador 1, ingrese su respuesta:'.
        usuario2 := UIManager default request: 'Jugador 2, ingrese su respuesta:'.

        "Validar y convertir las respuestas a enteros"
        [usuario1 := usuario1 asInteger] on: Error do: [^ UIManager default inform: 'Respuesta inválida de Jugador 1'].
        [usuario2 := usuario2 asInteger] on: Error do: [^ UIManager default inform: 'Respuesta inválida de Jugador 2'].

        "Calcular las diferencias de cada jugador con la suma correcta"
        diferencia1 := (usuario1 - suma) abs.
        diferencia2 := (usuario2 - suma) abs.

        "Comparar las respuestas y determinar el resultado"
        resultado := (diferencia1 < diferencia2)
            ifTrue: [('Jugador 1 gana con una diferencia de ', diferencia1 printString). ganador_duelo:= 1]
            ifFalse: [diferencia2 < diferencia1 ifTrue: [('Jugador 2 gana con una diferencia de ', diferencia2 printString). ganador_duelo:= 2] ifFalse: ['Empate']].

        "Mostrar el resultado en el Morph de resultado"
        resultadoMorph contents: 'Suma correcta: ', suma printString, ' - ', resultado asString.
        resultadoMorph changed. "Actualizar el Morph de resultado para mostrar la información"

        "Ajustar el tamaño del Morph de resultados al contenido"
        resultadoMorph extent: resultadoMorph contents size. "Ajustar automáticamente el tamaño del Morph para que se ajuste al texto"

        "Si es un empate, mostrar mensaje y reiniciar el juego después de 5 segundos"
        (resultado = 'Empate') ifTrue: [
            resultadoMorph contents: resultadoMorph contents, ' - Empate. El juego se repetirá en 5 segundos.'.
            resultadoMorph changed.
            (Delay forSeconds: 5) wait.
            self SumaTrix.
        ].
    ] fork.
]

{ #category : 'as yet unclassified' }
Juegos >> reinitializeGame [
"Reiniciar el juego en caso de empate"
    self NumeroSecreto.
]
