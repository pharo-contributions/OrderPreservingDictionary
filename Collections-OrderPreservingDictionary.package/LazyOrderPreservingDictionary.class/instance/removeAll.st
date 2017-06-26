removing
removeAll
	orderPreservingDictionary :=
		orderPreservingDictionary defaultValue ==
			self emptyOrderPreservingDictionary defaultValue
			ifTrue: [self emptyOrderPreservingDictionary]
			ifFalse: [orderPreservingDictionary copyEmpty]