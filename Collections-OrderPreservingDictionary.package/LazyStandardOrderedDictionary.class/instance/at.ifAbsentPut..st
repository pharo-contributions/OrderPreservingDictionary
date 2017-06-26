accessing
at: aKey ifAbsentPut: aBlock
	^ self copiedOrderPreservingDictionary
		at: aKey
		ifAbsentPut: aBlock