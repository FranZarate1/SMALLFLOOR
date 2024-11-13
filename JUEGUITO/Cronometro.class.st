Class {
	#name : 'Cronometro',
	#superclass : 'Object',
	#instVars : [
		'tiempo',
		'enMarcha',
		'delay',
		'proceso',
		'pausaTiempo',
		'ventana'
	],
	#category : 'JUEGUITO',
	#package : 'JUEGUITO'
}

{ #category : 'as yet unclassified' }
Cronometro >> detener [
 enMarcha := false.
    
    proceso ifNotNil: [
        proceso terminate.  "Termina el proceso actual"
        pausaTiempo := tiempo.  "Guarda el tiempo en que se detuvo"
        
        "Actualiza el mensaje en el TextMorph a 'Cronómetro detenido'"
        ventana contents: 'Cronómetro detenido en: ', pausaTiempo printString.
        ventana changed.  "Indica que el contenido ha cambiado y necesita redibujarse"
    ].
]

{ #category : 'as yet unclassified' }
Cronometro >> iniciar [
  tiempo := 15. "Inicia el cronómetro en 15 segundos"
        enMarcha := true.
        pausaTiempo := 0.
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
Cronometro >> reanudar [
 enMarcha := true.

    "Proceso principal del cronómetro que se actualiza cada segundo desde donde se detuvo"
    proceso := [
        [enMarcha and: [tiempo > 0]] whileTrue: [
            "Actualizar el contenido del TextMorph"
            ventana contents: 'Tiempo restante: ', tiempo printString.
            ventana changed.  "Indica que el contenido ha cambiado y necesita redibujarse"
            tiempo := tiempo - 1.
            (Delay forSeconds: 1) wait.
        ].

        "Cuando el cronómetro llegue a 0"
        tiempo = 0 ifTrue: [
            ventana contents: '¡Tiempo terminado!'.
            ventana changed.
            enMarcha := false.
        ].
    ] fork.
]

{ #category : 'as yet unclassified' }
Cronometro >> reiniciar [
tiempo := 15.
        enMarcha := false.
        pausaTiempo := 0.  "Resetea el tiempo de pausa"
        proceso ifNotNil: [ proceso terminate ].  "Asegura que el proceso anterior esté terminado"
        Transcript show: 'Cronómetro reiniciado a 15 segundos.'; cr.
]

{ #category : 'as yet unclassified' }
Cronometro >> tiempoActual [
^tiempo
]
