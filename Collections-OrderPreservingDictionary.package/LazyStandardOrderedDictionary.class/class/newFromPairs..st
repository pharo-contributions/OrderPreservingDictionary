instance creation
newFromPairs: aSequenceableCollection
	^ self basicNew setOrderPreservingDictionary:
		(self emptyOrderPreservingDictionaryClass newFromPairs:
			aSequenceableCollection)