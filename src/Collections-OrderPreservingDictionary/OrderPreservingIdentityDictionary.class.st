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
	1 to: self size do: [:i |
		(orderedKeys at: i) == aKey
			ifTrue: [^ i]].
	^ aBlock value.
]
