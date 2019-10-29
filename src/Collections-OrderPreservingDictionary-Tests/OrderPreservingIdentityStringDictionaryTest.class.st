Class {
	#name : #OrderPreservingIdentityStringDictionaryTest,
	#superclass : #OrderPreservingStringDictionaryTest,
	#category : #'Collections-OrderPreservingDictionary-Tests'
}

{ #category : #accessing }
OrderPreservingIdentityStringDictionaryTest >> dictionaryClass [
	^ OrderPreservingIdentityStringDictionary
]

{ #category : #testing }
OrderPreservingIdentityStringDictionaryTest >> isTestingIdentityDictionary [
	^ true
]
