"
A lazy version of StandardOrderedIdentityDictionary that only allocates memory when modified.
"
Class {
	#name : #LazyStandardOrderedIdentityDictionary,
	#superclass : #LazyStandardOrderedDictionary,
	#classVars : [
		'EmptyStandardOrderedIdentityDictionary'
	],
	#category : #'Collections-OrderPreservingDictionary'
}

{ #category : #private }
LazyStandardOrderedIdentityDictionary class >> emptyOrderPreservingDictionary [
	^ EmptyStandardOrderedIdentityDictionary

]

{ #category : #'class initialization' }
LazyStandardOrderedIdentityDictionary class >> initialize [
	"self initialize"

	EmptyStandardOrderedIdentityDictionary := StandardOrderedIdentityDictionary new
]
