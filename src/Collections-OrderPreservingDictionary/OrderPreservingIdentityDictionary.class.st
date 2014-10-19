"
IdentityDictionary version that uses == instead of = for key comparing.
"
Class {
	#name : #OrderPreservingIdentityDictionary,
	#superclass : #OrderPreservingDictionary,
	#category : #'Collections-OrderPreservingDictionary'
}

{ #category : #accessing }
OrderPreservingIdentityDictionary >> dictionaryClass [
	^ IdentityDictionary
]

{ #category : #private }
OrderPreservingIdentityDictionary >> indexOfKey: aKey [
	^ orderedKeys identityIndexOf: aKey
]
