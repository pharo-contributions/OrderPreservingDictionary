"
Unit tests for OrderPreservingIdentityStringDictionary
"
Class {
	#name : #OrderPreservingIdentityStringDictionaryTest,
	#superclass : #OrderPreservingStringDictionaryTest,
	#category : #'Collections-OrderPreservingDictionary-Tests-Base'
}

{ #category : #accessing }
OrderPreservingIdentityStringDictionaryTest >> dictionaryClass [
	^ OrderPreservingIdentityStringDictionary
]

{ #category : #testing }
OrderPreservingIdentityStringDictionaryTest >> isTestingIdentityDictionary [
	^ true
]
