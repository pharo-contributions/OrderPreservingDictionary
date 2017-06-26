tests
testSelect
	super testSelect.

	self assert:
		(self dictionaryWithOrderedAssociations
			defaultValue: self defaultValue;
			select: [:each | true]) defaultValue = self defaultValue.