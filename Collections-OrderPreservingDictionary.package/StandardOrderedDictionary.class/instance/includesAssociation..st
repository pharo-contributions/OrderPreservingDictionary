testing
includesAssociation: anAssociation
	"IndentityDictionary>>includesAssociation: works differently on GS
	testing both key and value identity, so it is reimplemented here
	to behave like Pharo/Squeak"
	^ (dictionary
		at: anAssociation key
		ifAbsent: [^ false]) = anAssociation value