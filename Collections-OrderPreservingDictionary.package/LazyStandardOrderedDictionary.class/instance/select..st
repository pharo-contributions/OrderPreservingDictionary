enumerating
select: aBlock
	^ self copyEmpty setOrderPreservingDictionary:
		(orderPreservingDictionary select: aBlock)