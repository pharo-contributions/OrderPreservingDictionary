tests
testDefaultValue
	| dictionary |
	
	dictionary := self dictionaryClass defaultValue: self defaultValue.
	self
		assert: dictionary defaultValue = self defaultValue;
		assert: (dictionary defaultValue: self newDefaultValue) == dictionary;
		assert: dictionary defaultValue = self newDefaultValue.