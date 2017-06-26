tests
testEqualsOtherOrderPreservingDictionaries
	self otherOrderPreservingDictionaryClasses do: [:otherClass |
		| dictionary otherDictionary |
		dictionary := self dictionaryClass new.
		otherDictionary := otherClass new.
		dictionary isIdentityDictionary = otherDictionary isIdentityDictionary
			ifTrue: [
				self
					assertDictionary: dictionary
					equals: otherDictionary.
				self orderedAssociations do: [:each |
					dictionary add: each.
					self
						assertDictionary: dictionary
						doesNotEqual: otherDictionary.
					otherDictionary add: each copy.
					self
						assertDictionary: dictionary
						equals: otherDictionary]]
			ifFalse: [
				self
					assertDictionary: dictionary
					doesNotEqual: otherDictionary.
				self orderedAssociations do: [:each |
					dictionary add: each.
					otherDictionary add: each copy.
					self
						assertDictionary: dictionary
						doesNotEqual: otherDictionary]]]