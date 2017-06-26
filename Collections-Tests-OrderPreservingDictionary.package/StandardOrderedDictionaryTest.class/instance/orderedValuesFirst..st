accessing
orderedValuesFirst: anInteger
	"GS does not have #first:"
	^ self orderedValues
		copyFrom: 1
		to: anInteger