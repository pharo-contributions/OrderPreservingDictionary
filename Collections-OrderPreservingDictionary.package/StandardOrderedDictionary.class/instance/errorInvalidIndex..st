private
errorInvalidIndex: anIndex
	"Squeak and GS do not have SubscriptOutOfBounds, so Error is used
	for portability"
	Error signal: 'Invalid index: ', anIndex printString