"
Unit tests for StandardOrderedIdentityDictionary
"
Class {
	#name : #StandardOrderedIdentityDictionaryTest,
	#superclass : #StandardOrderedDictionaryTest,
	#category : #'Collections-OrderPreservingDictionary-Tests'
}

{ #category : #accessing }
StandardOrderedIdentityDictionaryTest >> dictionaryClass [
	^ StandardOrderedIdentityDictionary
]

{ #category : #testing }
StandardOrderedIdentityDictionaryTest >> isTestingIdentityDictionary [
	^ true
]
