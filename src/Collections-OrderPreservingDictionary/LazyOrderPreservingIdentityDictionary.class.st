"
A lazy version of OrderPreservingIdentityDictionary that only allocates memory when modified.
"
Class {
	#name : #LazyOrderPreservingIdentityDictionary,
	#superclass : #LazyOrderPreservingDictionary,
	#classVars : [
		'EmptyOrderPreservingIdentityDictionary'
	],
	#category : #'Collections-OrderPreservingDictionary'
}

{ #category : #private }
LazyOrderPreservingIdentityDictionary class >> emptyOrderPreservingDictionary [
	^ EmptyOrderPreservingIdentityDictionary
]

{ #category : #'class initialization' }
LazyOrderPreservingIdentityDictionary class >> initialize [
	"self initialize"

	EmptyOrderPreservingIdentityDictionary := OrderPreservingIdentityDictionary new
]
