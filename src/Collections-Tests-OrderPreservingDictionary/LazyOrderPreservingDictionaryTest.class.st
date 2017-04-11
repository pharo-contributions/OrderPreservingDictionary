Class {
	#name : #LazyOrderPreservingDictionaryTest,
	#superclass : #OrderPreservingDictionaryTest,
	#category : #'Collections-Tests-OrderPreservingDictionary'
}

{ #category : #accessing }
LazyOrderPreservingDictionaryTest >> dictionaryClass [
	^ LazyOrderPreservingDictionary
]

{ #category : #testing }
LazyOrderPreservingDictionaryTest >> isTestingLazyDictionary [
	^ true
]
