removing
removeKey: aKey ifAbsent: aBlock
	^ self copiedOrderPreservingDictionary
		removeKey: aKey
		ifAbsent: aBlock