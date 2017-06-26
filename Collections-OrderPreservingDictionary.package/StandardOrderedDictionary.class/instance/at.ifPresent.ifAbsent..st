accessing
at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock
	"Squeak and GS don't use #cull: for the ifPresent:
	block, so it is reimplemented for portability"
	self
		at: aKey
		ifPresent: [:value | ^ aPresentBlock cull: value].
	^ anAbsentBlock value.