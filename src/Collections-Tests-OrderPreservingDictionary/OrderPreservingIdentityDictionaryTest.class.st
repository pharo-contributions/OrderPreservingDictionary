Class {
	#name : #OrderPreservingIdentityDictionaryTest,
	#superclass : #OrderPreservingDictionaryTest,
	#instVars : [
		'identityAssociations'
	],
	#category : #'Collections-Tests-OrderPreservingDictionary'
}

{ #category : #testing }
OrderPreservingIdentityDictionaryTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
OrderPreservingIdentityDictionaryTest >> dictionaryAssociations [
	identityAssociations
		ifNil: [| key |
			key := 'testKey'.
			identityAssociations :=
				(#('testValue' 'testValue3' 'testValue2' 'testValue4') collect: [:each |
					(key := key copy) -> each])].

	^ identityAssociations collect: [:each | each copy].
]

{ #category : #accessing }
OrderPreservingIdentityDictionaryTest >> dictionaryClass [
	^ OrderPreservingIdentityDictionary
]

{ #category : #accessing }
OrderPreservingIdentityDictionaryTest >> internalDictionaryClass [
	^ IdentityDictionary
]
