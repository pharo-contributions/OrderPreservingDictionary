tests
testAssociationAt
	| dictionary |

	dictionary := self emptyDictionary.
	self orderedAssociations do: [:each |
		self assert: (dictionary associationAt: each key) isNil.
	
		dictionary add: each.
		self assert: (dictionary associationAt: each key) = each].