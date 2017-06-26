accessing
orderedAssociationsFirst: anInteger
	"GS does not have #first:"
	^ self orderedAssociations
		copyFrom: 1
		to: anInteger