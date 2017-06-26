tests
testKeyAtIdentityValue
	| dictionary |

	dictionary := self emptyDictionary.
	dictionary defaultValue: self defaultValue.
	self orderedAssociations do: [:each |
		self assert:
			(dictionary keyAtIdentityValue: each value) = self defaultValue.

		dictionary add: each.
		self assert:
			(dictionary keyAtIdentityValue: each value) = each key.
		self assert:
			(dictionary keyAtIdentityValue: each value copy) = self defaultValue].