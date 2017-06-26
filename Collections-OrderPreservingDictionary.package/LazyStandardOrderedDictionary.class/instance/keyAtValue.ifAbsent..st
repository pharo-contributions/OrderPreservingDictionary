accessing
keyAtValue: anObject ifAbsent: aBlock
	^ orderPreservingDictionary
		keyAtValue: anObject
		ifAbsent: aBlock