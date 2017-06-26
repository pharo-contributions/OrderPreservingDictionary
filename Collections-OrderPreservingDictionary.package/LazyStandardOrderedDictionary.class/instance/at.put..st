accessing
at: aKey put: aValue
	^ self copiedOrderPreservingDictionary
		at: aKey
		put: aValue