accessing
keyAtIndex: anIndex ifAbsent: aBlock
	^ orderPreservingDictionary
		keyAtIndex: anIndex
		ifAbsent: aBlock