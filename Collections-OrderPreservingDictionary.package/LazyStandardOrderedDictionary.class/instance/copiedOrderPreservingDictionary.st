private
copiedOrderPreservingDictionary
	"replaces the shared, empty order-preserving dictionary with a new
	mutable one ready for modification"
	^ orderPreservingDictionary == self emptyOrderPreservingDictionary
		ifTrue: [orderPreservingDictionary := orderPreservingDictionary copy]
		ifFalse: [orderPreservingDictionary]