accessing
indexOfKey: aKey ifAbsent: aBlock
	^ orderPreservingDictionary
		indexOfKey: aKey
		ifAbsent: aBlock