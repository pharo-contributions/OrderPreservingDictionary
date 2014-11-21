Class {
	#name : #OrderPreservingIdentityDictionaryTest,
	#superclass : #OrderPreservingDictionaryTest,
	#category : #'Collections-Tests-OrderPreservingDictionary'
}

{ #category : #accessing }
OrderPreservingIdentityDictionaryTest >> absentKey [
	^ self identityAbsentKey
]

{ #category : #accessing }
OrderPreservingIdentityDictionaryTest >> dictionaryAssociations [
	^ self identityDictionaryAssociations
]

{ #category : #accessing }
OrderPreservingIdentityDictionaryTest >> dictionaryClass [
	^ OrderPreservingIdentityDictionary
]

{ #category : #accessing }
OrderPreservingIdentityDictionaryTest >> internalDictionaryClass [
	^ IdentityDictionary
]
