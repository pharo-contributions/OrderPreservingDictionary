instance creation
newFrom: anAssociationCollection
	^ self basicNew setOrderPreservingDictionary:
		(self emptyOrderPreservingDictionaryClass newFrom:
			anAssociationCollection)