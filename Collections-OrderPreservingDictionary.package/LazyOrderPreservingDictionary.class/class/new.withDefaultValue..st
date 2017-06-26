instance creation
new: aCapacity withDefaultValue: aDefaultValue
	^ self basicNew setOrderPreservingDictionary:
		(self emptyOrderPreservingDictionaryClass
			new: aCapacity
			withDefaultValue: aDefaultValue)