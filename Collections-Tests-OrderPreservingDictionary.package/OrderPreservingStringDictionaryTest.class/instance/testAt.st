tests
testAt
	| dictionary |

	dictionary := self emptyDictionary.
	self orderedAssociations do: [:each |
		self assert: (dictionary at: each key) = ''.

		dictionary add: each.
		self assert: (dictionary at: each key) = each value].