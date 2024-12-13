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
Duelo >> iniciar [ 
| numeros |
        numeros := #(1 2).  "Lista de posibles juegos, 1 = el de los clicks y 2 = al de las sumas"

        "Obtenemos un juego aleatorio de la lista"
        juego_del_duelo := numeros atRandom.

        "Comprobamos qué juego se invoca"
        juego_del_duelo = 1 
            ifTrue: [
                "Transcript show: 'Se jugara a la guerra de clicks'.".
                Juegos new BatallaClicks.
            ] 
            ifFalse: [
                "Transcript show: 'Se jugara al juego de las sumas'.".
                Juegos new suma.
            ].
    
]

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
        juego := #("BatallaClicks" NumeroSecreto ) atRandom.

        "Iniciar el juego seleccionado y determinar el ganador"
        "juego = #BatallaClicks ifTrue: [ jueguito := Juegos new BatallaClicks ]."
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
