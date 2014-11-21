Class {
	#name : #StandardOrderedIdentityDictionaryTest,
	#superclass : #StandardOrderedDictionaryTest,
	#category : #'Collections-Tests-OrderPreservingDictionary'
}

{ #category : #testing }
StandardOrderedIdentityDictionaryTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
StandardOrderedIdentityDictionaryTest >> absentKey [
	^ self identityAbsentKey
]

{ #category : #accessing }
StandardOrderedIdentityDictionaryTest >> dictionaryAssociations [
	^ self identityDictionaryAssociations
]

{ #category : #accessing }
StandardOrderedIdentityDictionaryTest >> dictionaryClass [
	^ StandardOrderedIdentityDictionary
]

{ #category : #accessing }
StandardOrderedIdentityDictionaryTest >> internalDictionaryClass [
	^ IdentityDictionary
]
