tests
testKeyAtIndex
	| dictionary |

	dictionary := self emptyDictionary.
	dictionary defaultValue: self defaultValue.
	self assert: (dictionary keyAtIndex: 0) = self defaultValue.
	self orderedAssociations withIndexDo: [:each :i |
		self assert: (dictionary keyAtIndex: i) = self defaultValue.

		dictionary add: each.
		self assert: (dictionary keyAtIndex: i) = each key].