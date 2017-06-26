accessing
keyAtIdentityValue: aValue ifAbsent: aBlock
	^ orderPreservingDictionary
		keyAtIdentityValue: aValue
		ifAbsent: aBlock