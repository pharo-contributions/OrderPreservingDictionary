"
A lazy version of OrderPreservingIdentityStringDictionary that only allocates memory when modified.
"
Class {
	#name : #LazyOrderPreservingIdentityStringDictionary,
	#superclass : #LazyOrderPreservingStringDictionary,
	#classVars : [
		'EmptyOrderPreservingIdentityStringDictionary'
	],
	#category : #'Collections-OrderPreservingDictionary'
}

{ #category : #private }
LazyOrderPreservingIdentityStringDictionary class >> emptyOrderPreservingDictionary [
	^ EmptyOrderPreservingIdentityStringDictionary
]

{ #category : #'class initialization' }
LazyOrderPreservingIdentityStringDictionary class >> initialize [
	"self initialize"

	EmptyOrderPreservingIdentityStringDictionary :=
		OrderPreservingIdentityStringDictionary new
]
