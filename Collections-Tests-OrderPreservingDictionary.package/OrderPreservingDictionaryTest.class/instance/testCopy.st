tests
testCopy
	| dictionary copy |

	super testCopy.

	dictionary := self dictionaryWithOrderedAssociations.
	dictionary defaultValue: self defaultValue.
	copy := dictionary copy.
	self assert: copy defaultValue = dictionary defaultValue.