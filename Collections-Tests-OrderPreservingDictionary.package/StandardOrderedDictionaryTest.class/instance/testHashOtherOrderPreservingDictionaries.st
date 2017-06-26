tests
testHashOtherOrderPreservingDictionaries
	self otherOrderPreservingDictionaryClasses do: [:otherClass |
		| dictionary otherDictionary |
		dictionary := self dictionaryClass new.
		otherDictionary := otherClass new.
		dictionary isIdentityDictionary = otherDictionary isIdentityDictionary
			ifTrue: [
				self assert: dictionary hash = otherDictionary hash.
				self orderedAssociations do: [:each |
					dictionary add: each.
					otherDictionary add: each copy.
					self assert: dictionary hash = otherDictionary hash]]]