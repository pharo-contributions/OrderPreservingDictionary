tests
testAt
	| dictionary |

	dictionary := self emptyDictionary.
	dictionary defaultValue: self defaultValue.
	self orderedAssociations do: [:each |
		self assert: (dictionary at: each key) = self defaultValue.

		dictionary add: each.
		self assert: (dictionary at: each key) = each value].