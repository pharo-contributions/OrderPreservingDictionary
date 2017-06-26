enumerating
collect: aBlock
	^ self copyEmpty setOrderPreservingDictionary:
		(orderPreservingDictionary collect: aBlock)