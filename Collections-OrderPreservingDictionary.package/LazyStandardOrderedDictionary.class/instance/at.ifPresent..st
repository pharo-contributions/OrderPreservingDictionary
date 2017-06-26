accessing
at: aKey ifPresent: aBlock
	^ orderPreservingDictionary
		at: aKey
		ifPresent: aBlock