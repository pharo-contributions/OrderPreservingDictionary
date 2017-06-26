tests
testKeyAtIdentityValue
	| dictionary |

	dictionary := self emptyDictionary.
	self orderedAssociations do: [:each |
		self assert: (dictionary keyAtIdentityValue: each value) = ''.

		dictionary add: each.
		self
			assert: (dictionary keyAtIdentityValue: each value) = each key;
			assert: (dictionary keyAtIdentityValue: each value copy) = ''].