accessing
changedOrderedAssociationsFirst: anInteger
	"GS does not have #first:"
	^ self changedOrderedAssociations
		copyFrom: 1
		to: anInteger