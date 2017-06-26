class initialization
initialize
	"self initialize"

	"directly initialized class vars are used for the empty dictionaries
	to simplify initialization and speed up instance creation"
	EmptyStandardOrderedDictionary := StandardOrderedDictionary new