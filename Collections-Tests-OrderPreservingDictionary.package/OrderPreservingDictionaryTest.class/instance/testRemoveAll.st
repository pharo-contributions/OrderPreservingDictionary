tests
testRemoveAll
	| dictionary |

	super testRemoveAll.

	dictionary := self dictionaryWithOrderedAssociations.
	dictionary
		defaultValue: self defaultValue;
		removeAll.
	self assert: dictionary defaultValue = self defaultValue.