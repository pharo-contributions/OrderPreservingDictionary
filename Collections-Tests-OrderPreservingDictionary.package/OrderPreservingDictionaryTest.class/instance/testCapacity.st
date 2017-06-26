tests
testCapacity
	| defaultCapacity dictionary |

	super testCapacity.

	defaultCapacity := self defaultCapacity.
	dictionary := self dictionaryClass defaultValue: nil.
	self assert: dictionary capacity >= defaultCapacity.

	dictionary :=
		self dictionaryClass
			new: defaultCapacity * 2
			withDefaultValue: nil.
	self assert: dictionary capacity >= (defaultCapacity * 2).