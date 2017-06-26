accessing
associationAt: aKey ifPresent: aBlock
	"Squeak and GS do not have #associationAt:ifPresent: so it
	is reimplemented for portability"
	^ aBlock cull:
		(dictionary
			associationAt: aKey
			ifAbsent: [^ nil])