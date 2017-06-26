enumerating
associationsSelect: aBlock
	^ self copyEmpty setOrderPreservingDictionary:
		(orderPreservingDictionary associationsSelect: aBlock)