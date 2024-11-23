Class {
	#name : 'Duelo',
	#superclass : 'Object',
	#instVars : [
		'juego_del_duelo',
		'jugador1',
		'jugador2',
		'ganador',
		'perdedor'
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
    | juego ganador perdedor territorioPerdedor jueguito |

    "Asignar jugadores"
    self setJugador1: jugador1.
    self setJugador2: jugador2.

    "Seleccionar aleatoriamente un juego"
    juego := #(BatallaClicks NumeroSecreto SumaTrix) atRandom.

    "Iniciar el juego seleccionado y determinar el ganador"
    juego = #BatallaClicks ifTrue: [ jueguito:= Juegos new BatallaClicks].
    juego = #NumeroSecreto ifTrue: [ jueguito:= Juegos new NumeroSecreto].
    juego = #SumaTrix ifTrue: [jueguito := Juegos new SumaTrix].
	ganador:= jueguito GetGanador.
    "Simular la lógica de determinar perdedor (debería venir del juego)"
ganador = 1 ifTrue:[ganador:=jugador1]  ifFalse:[ganador:=jugador2].    

perdedor := (ganador = jugador1) ifTrue: [jugador2] ifFalse: [jugador1].
	 self setPerdedor: perdedor.
	self setGanador:ganador.
    "Asignar el territorio del perdedor al ganador"
    territorioPerdedor := perdedor getTerritorio.
    ganador AgregarTerritorio: territorioPerdedor.
	perdedor vaciarTerritorio .

	 ganador actualizarColorTerritorio.
	
    "Imprimir el resultado en el Transcript"
    Transcript show: 'Ganador: ', ganador getNombre asString, ' ha ganado el territorio de ', perdedor getNombre asString; cr.

    "Devolver el ganador"
    ^ ganador.


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
