Class {
	#name : #LazyOrderPreservingIdentityStringDictionaryTest,
	#superclass : #OrderPreservingIdentityStringDictionaryTest,
	#category : #'Collections-Tests-OrderPreservingDictionary'
}

{ #category : #accessing }
LazyOrderPreservingIdentityStringDictionaryTest >> dictionaryClass [
	^ LazyOrderPreservingIdentityStringDictionary
]

{ #category : #testing }
LazyOrderPreservingIdentityStringDictionaryTest >> isTestingLazyDictionary [
	^ true
]
