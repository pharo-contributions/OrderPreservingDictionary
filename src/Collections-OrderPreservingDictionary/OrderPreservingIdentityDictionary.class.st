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

{ #category : #accessing }
OrderPreservingIdentityDictionary >> indexOfKey: aKey ifAbsent: aBlock [
	^ orderedKeys identityIndexOf: aKey ifAbsent: aBlock
]
