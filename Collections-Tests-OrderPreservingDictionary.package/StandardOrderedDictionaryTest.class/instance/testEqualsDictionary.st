tests
testEqualsDictionary
	"cannot use assertDictionary:doesNotEqual: for backwards compatibility with
	older Pharo images where Dictionary>>= uses #isDictionary to test the argument
	because these classes also implement isDictionary"
	self
		deny: self emptyDictionary = self emptyInternalDictionary;
		deny: self dictionaryWithOrderedAssociations = self internalDictionaryWithAssociations