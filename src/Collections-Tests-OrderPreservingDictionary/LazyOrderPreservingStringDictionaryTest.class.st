Class {
	#name : #LazyOrderPreservingStringDictionaryTest,
	#superclass : #OrderPreservingStringDictionaryTest,
	#category : #'Collections-Tests-OrderPreservingDictionary'
}

{ #category : #accessing }
LazyOrderPreservingStringDictionaryTest >> dictionaryClass [
	^ LazyOrderPreservingStringDictionary
]

{ #category : #testing }
LazyOrderPreservingStringDictionaryTest >> isTestingLazyDictionary [
	^ true
]
