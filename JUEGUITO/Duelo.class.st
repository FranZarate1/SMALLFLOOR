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
