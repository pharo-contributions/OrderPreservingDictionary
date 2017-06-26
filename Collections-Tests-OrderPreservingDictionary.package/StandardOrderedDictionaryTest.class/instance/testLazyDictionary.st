tests
testLazyDictionary
	self isTestingLazyDictionary
		ifFalse: [^ self].

	self assert:
		self emptyDictionary orderPreservingDictionary ==
			self dictionaryClass emptyOrderPreservingDictionary.
	self assert:
		self dictionaryClass emptyOrderPreservingDictionary isEmpty.