Class {
	#name : 'Cronometro',
	#superclass : 'Object',
	#instVars : [
		'tiempo',
		'enMarcha',
		'delay',
		'proceso'
	],
	#category : 'Juego',
	#package : 'Juego'
}

{ #category : 'as yet unclassified' }
Cronometro >> detener [
 enMarcha := false.
        proceso ifNotNil: [ proceso terminate ].  "Termina el proceso si está activo"
        Transcript show: 'Cronómetro detenido en: ', tiempo printString; cr.
]

{ #category : 'as yet unclassified' }
Cronometro >> iniciar [
  tiempo := 15. "Inicia el cronómetro en 15 segundos"
        enMarcha := true.
        delay := Delay forSeconds: 1.

        proceso := [
            [ enMarcha and: [ tiempo > 0 ] ] whileTrue: [
                Transcript show: 'Tiempo: ', tiempo printString; cr.
                tiempo := tiempo - 1.
                delay wait.
            ].

            "Muestra un mensaje cuando el cronómetro llega a 0"
            tiempo = 0 ifTrue: [ Transcript show: '¡Tiempo terminado!'; cr ].
        ] fork.
]

{ #category : 'as yet unclassified' }
Cronometro >> reiniciar [
tiempo := 15.
        enMarcha := false.
        proceso ifNotNil: [ proceso terminate ].  "Asegura que el proceso anterior esté terminado"
        Transcript show: 'Cronómetro reiniciado a 15 segundos.'; cr.
]
