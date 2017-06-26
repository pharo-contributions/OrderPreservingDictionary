tests
testAssociationsSelect
	super testAssociationsSelect.

	self assert:
		(self dictionaryWithOrderedAssociations
			defaultValue: self defaultValue;
			associationsSelect: [:each | true]) defaultValue = self defaultValue.