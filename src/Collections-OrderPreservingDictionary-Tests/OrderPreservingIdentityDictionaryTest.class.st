"
Unit tests for OrderPreservingIdentityDictionary
"
Class {
	#name : #OrderPreservingIdentityDictionaryTest,
	#superclass : #OrderPreservingDictionaryTest,
	#category : #'Collections-OrderPreservingDictionary-Tests-Base'
}

{ #category : #accessing }
OrderPreservingIdentityDictionaryTest >> dictionaryClass [
	^ OrderPreservingIdentityDictionary
]

{ #category : #testing }
OrderPreservingIdentityDictionaryTest >> isTestingIdentityDictionary [
	^ true
]
