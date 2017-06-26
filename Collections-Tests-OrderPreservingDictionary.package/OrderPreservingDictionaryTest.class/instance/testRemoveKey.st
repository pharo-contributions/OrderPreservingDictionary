tests
testRemoveKey
	| dictionary |

	dictionary := self dictionaryWithOrderedAssociations.
	dictionary defaultValue: self defaultValue.
	self orderedAssociations withIndexDo: [:each :i |
		self assert: (dictionary removeKey: each key) = each value.
		self
			assertKey: each key
			wasRemovedfrom: dictionary.
		self
			assertIsDictionary: dictionary
			withOrderedAssociations: (self orderedAssociationsAllButFirst: i).

		self assert: (dictionary removeKey: each key) = self defaultValue]