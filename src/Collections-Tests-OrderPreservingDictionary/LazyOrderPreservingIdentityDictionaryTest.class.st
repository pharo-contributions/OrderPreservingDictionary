Class {
	#name : #LazyOrderPreservingIdentityDictionaryTest,
	#superclass : #OrderPreservingIdentityDictionaryTest,
	#category : #'Collections-Tests-OrderPreservingDictionary'
}

{ #category : #accessing }
LazyOrderPreservingIdentityDictionaryTest >> dictionaryClass [
	^ LazyOrderPreservingIdentityDictionary
]

{ #category : #testing }
LazyOrderPreservingIdentityDictionaryTest >> isTestingLazyDictionary [
	^ true
]
