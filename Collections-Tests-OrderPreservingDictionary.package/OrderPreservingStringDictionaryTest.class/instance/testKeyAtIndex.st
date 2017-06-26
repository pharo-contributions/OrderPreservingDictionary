tests
testKeyAtIndex
	| dictionary |

	dictionary := self emptyDictionary.
	self assert: (dictionary keyAtIndex: 0) = ''.
	self orderedAssociations withIndexDo: [:each :i |
		self assert: (dictionary keyAtIndex: i) = ''.

		dictionary add: each.
		self assert: (dictionary keyAtIndex: i) = each key].