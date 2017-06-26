instance creation
defaultValue: aDefaultValue
	^ self basicNew setOrderPreservingDictionary:
		(self emptyOrderPreservingDictionaryClass defaultValue: aDefaultValue)