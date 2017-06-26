accessing
at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock
	^ orderPreservingDictionary
		at: aKey
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock