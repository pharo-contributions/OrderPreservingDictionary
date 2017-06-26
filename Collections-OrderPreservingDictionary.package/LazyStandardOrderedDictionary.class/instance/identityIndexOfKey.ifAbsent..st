accessing
identityIndexOfKey: aKey ifAbsent: aBlock
	^ orderPreservingDictionary
		identityIndexOfKey: aKey
		ifAbsent: aBlock