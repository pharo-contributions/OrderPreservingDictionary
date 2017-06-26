accessing
keyAtIdentityValue: aValue ifAbsent: aBlock
	"GS does not have keyAtIdentityValue:ifAbsent:"
	self keysAndValuesDo: [:key :value |
		value == aValue
			ifTrue: [^ key]].
	^ aBlock value.