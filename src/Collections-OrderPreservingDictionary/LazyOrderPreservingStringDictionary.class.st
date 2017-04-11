"
A lazy version of OrderPreservingStringDictionary that only allocates memory when modified.
"
Class {
	#name : #LazyOrderPreservingStringDictionary,
	#superclass : #LazyStandardOrderedDictionary,
	#classVars : [
		'EmptyOrderPreservingStringDictionary'
	],
	#category : #'Collections-OrderPreservingDictionary'
}

{ #category : #private }
LazyOrderPreservingStringDictionary class >> emptyOrderPreservingDictionary [
	^ EmptyOrderPreservingStringDictionary
]

{ #category : #'class initialization' }
LazyOrderPreservingStringDictionary class >> initialize [
	"self initialize"

	EmptyOrderPreservingStringDictionary := OrderPreservingStringDictionary new
]

{ #category : #accessing }
LazyOrderPreservingStringDictionary >> defaultValue [
	^ orderPreservingDictionary defaultValue
]
