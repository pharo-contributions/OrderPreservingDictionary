accessing
orderedKeysFirst: anInteger
	"GS does not have #first:"
	^ self orderedKeys
		copyFrom: 1
		to: anInteger