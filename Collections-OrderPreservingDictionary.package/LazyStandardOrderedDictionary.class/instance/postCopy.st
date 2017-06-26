copying
postCopy
	orderPreservingDictionary == self emptyOrderPreservingDictionary
		ifFalse: [orderPreservingDictionary := orderPreservingDictionary copy]