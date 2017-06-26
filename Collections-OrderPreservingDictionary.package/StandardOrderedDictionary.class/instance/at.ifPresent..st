accessing
at: aKey ifPresent: aBlock
	"Squeak and GS don't use #cull: for the ifPresent:
	block, so it is reimplemented for portability"
	^ aBlock cull:
		(self
			at: aKey
			ifAbsent: [^ nil])