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
StandardOrderedIdentityDictionaryTest >> dictionaryClass [
	^ StandardOrderedIdentityDictionary
]

{ #category : #testing }
StandardOrderedIdentityDictionaryTest >> isTestingIdentityDictionary [
	^ true
]
