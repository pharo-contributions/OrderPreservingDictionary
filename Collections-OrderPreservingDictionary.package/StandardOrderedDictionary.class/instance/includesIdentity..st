testing
includesIdentity: anObject
	"GS does not have includesIdentity:"
	self valuesDo: [:each |
		each == anObject
			ifTrue: [^ true]].
	^ false.