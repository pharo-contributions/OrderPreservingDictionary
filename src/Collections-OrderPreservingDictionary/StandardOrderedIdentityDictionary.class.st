"
An IdentityDictionary version that uses == instead of = for key comparing.
"
Class {
	#name : #StandardOrderedIdentityDictionary,
	#superclass : #StandardOrderedDictionary,
	#category : #'Collections-OrderPreservingDictionary'
}

{ #category : #accessing }
StandardOrderedIdentityDictionary >> dictionaryClass [
	^ IdentityDictionary
]

{ #category : #accessing }
StandardOrderedIdentityDictionary >> indexOfKey: aKey ifAbsent: aBlock [
	^ self identityIndexOfKey: aKey ifAbsent: aBlock
]
