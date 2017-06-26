tests
testCopyEmpty
	| dictionary copy |

	super testCopyEmpty.
	
	dictionary := self dictionaryWithOrderedAssociations.
	dictionary defaultValue: self defaultValue.
	copy := dictionary copyEmpty.
	self assert: copy defaultValue = dictionary defaultValue.