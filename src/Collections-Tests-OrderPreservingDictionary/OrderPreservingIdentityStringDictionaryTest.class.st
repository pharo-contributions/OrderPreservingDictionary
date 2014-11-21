Class {
	#name : #OrderPreservingIdentityStringDictionaryTest,
	#superclass : #OrderPreservingStringDictionaryTest,
	#category : #'Collections-Tests-OrderPreservingDictionary'
}

{ #category : #accessing }
OrderPreservingIdentityStringDictionaryTest >> absentKey [
	^ self identityAbsentKey
]

{ #category : #accessing }
OrderPreservingIdentityStringDictionaryTest >> dictionaryAssociations [
	^ self identityDictionaryAssociations
]

{ #category : #accessing }
OrderPreservingIdentityStringDictionaryTest >> dictionaryClass [
	^ OrderPreservingIdentityStringDictionary
]

{ #category : #accessing }
OrderPreservingIdentityStringDictionaryTest >> internalDictionaryClass [
	^ IdentityDictionary
]
