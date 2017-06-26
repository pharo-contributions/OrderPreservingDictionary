tests
testNewFrom
	| dictionary copy |

	super testNewFrom.

	dictionary := self dictionaryClass newFrom: self orderedAssociations.
	dictionary defaultValue: self defaultValue.
	copy := self dictionaryClass newFrom: dictionary.
	self assert: copy defaultValue = dictionary defaultValue.