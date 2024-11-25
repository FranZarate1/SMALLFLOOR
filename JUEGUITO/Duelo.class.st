Class {
	#name : 'Duelo',
	#superclass : 'Object',
	#instVars : [
		'juego_del_duelo',
		'jugador1',
		'jugador2',
		'ganador',
		'perdedor',
		'DuelosActivos'
	],
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
Duelo >> iniciarDueloEntre: jugador1 jugador2:jugador2 [ 
   | jugador1 jugador2 ganador perdedor  juego jueguito territorioPerdedor|

    "Verificar que ninguno de los jugadores esté en un duelo"
        (jugador1 estaEnDuelo or: [jugador2 estaEnDuelo]) ifTrue: [
            Transcript show: 'Uno o ambos jugadores ya están en un duelo. Intenta más tarde.'; cr.
            ^self.
        ].

        "Activar la bandera de duelo para ambos jugadores"
        jugador1 activarDuelo.
        jugador2 activarDuelo.
		 
        "Seleccionar aleatoriamente un juego"
        juego := #( NumeroSecreto ) atRandom.

        "Iniciar el juego seleccionado y determinar el ganador"
        juego = #NumeroSecreto ifTrue: [ jueguito := Juegos new NumeroSecreto ].
        "juego = #SumaTrix ifTrue: [ jueguito := Juegos new SumaTrix ]."
        ganador := jueguito GetGanador.

        "Determinar perdedor basado en el ganador"
        ganador := (ganador = 1) ifTrue: [jugador1] ifFalse: [jugador2].
        perdedor := (ganador = jugador1) ifTrue: [jugador2] ifFalse: [jugador1].

        self setPerdedor: perdedor.
        self setGanador: ganador.

        "Transferir territorio del perdedor al ganador"
        territorioPerdedor := perdedor getTerritorio.
        ganador AgregarTerritorio: territorioPerdedor.
        perdedor vaciarTerritorio.

        "Actualizar colores del territorio"
        ganador actualizarColorTerritorio.

        "Desactivar la bandera de duelo para ambos jugadores"
        jugador1 desactivarDuelo.
        jugador2 desactivarDuelo.

        "Imprimir el resultado"
        Transcript show: 'Ganador: ', (ganador getNombre)asString, ' ha ganado el territorio de ', (perdedor getNombre)asString; cr.

        ^ganador.


]

{ #category : 'accessing' }
Duelo >> setGanador: unJugador [ 
    ganador:= unJugador.
]

{ #category : 'accessing' }
Duelo >> setJugador1: unJugador [ 
    jugador1 := unJugador.

]

{ #category : 'accessing' }
Duelo >> setJugador2: unJugador [ 
    jugador2 := unJugador.

]

{ #category : 'accessing' }
Duelo >> setPerdedor: unJugador [ 
    perdedor:= unJugador.
]
