accessing
keyAtIdentityValue: aValue
	^ self
		keyAtIdentityValue: aValue
		ifAbsent: [self errorValueNotFound: aValue]