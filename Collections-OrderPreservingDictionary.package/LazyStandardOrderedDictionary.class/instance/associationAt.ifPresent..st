accessing
associationAt: aKey ifPresent: aBlock
	^ orderPreservingDictionary
		associationAt: aKey
		ifPresent: aBlock