tests
testNewWithDefaultValue
	| dictionary |

	dictionary :=
		self dictionaryClass
			new: 10
			withDefaultValue: self defaultValue.
	self assert: dictionary defaultValue = self defaultValue.