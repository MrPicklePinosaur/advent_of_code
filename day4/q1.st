
Object subclass: #Solver.

Solver extend [

    new [
    	| r |
    	r := super new.
	r init.
	^r
    ]

    isCover: l [
    	| answer split oneSplit twoSplit |
	answer := 0.
    	split := l substrings: ','.
	oneSplit := split first substrings: '-'.
	twoSplit := split last substrings: '-'.

	((oneSplit first asNumber <= twoSplit first asNumber) & (twoSplit last asNumber <= oneSplit last asNumber))
	| ((twoSplit first asNumber <= oneSplit first asNumber) & (oneSplit last asNumber <= twoSplit last asNumber))
	ifTrue: [ answer := 1 ].
	^answer
    ]
]

total := 0.
solver := Solver new.

file := FileStream open: 'input.txt' mode: FileStream read.
[(l := file nextLine) notNil] whileTrue: [ total := total + (solver isCover: l) ].

Transcript show: total printString; nl.