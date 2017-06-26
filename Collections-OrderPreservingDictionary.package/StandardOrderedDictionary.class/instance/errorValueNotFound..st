private
errorValueNotFound: aValue
	"Squeak and GS do not have ValueNotFound, so Error is used
	for portability"
	Error signal: 'Value not found'