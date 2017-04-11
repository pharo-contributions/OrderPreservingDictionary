Class {
	#name : #LazyStandardOrderedDictionaryTest,
	#superclass : #StandardOrderedDictionaryTest,
	#category : #'Collections-Tests-OrderPreservingDictionary'
}

{ #category : #accessing }
LazyStandardOrderedDictionaryTest >> dictionaryClass [
	^ LazyStandardOrderedDictionary
]

{ #category : #testing }
LazyStandardOrderedDictionaryTest >> isTestingLazyDictionary [
	^ true
]
