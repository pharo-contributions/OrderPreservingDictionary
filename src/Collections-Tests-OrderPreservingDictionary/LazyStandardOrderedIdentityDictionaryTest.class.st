Class {
	#name : #LazyStandardOrderedIdentityDictionaryTest,
	#superclass : #StandardOrderedIdentityDictionaryTest,
	#category : #'Collections-Tests-OrderPreservingDictionary'
}

{ #category : #accessing }
LazyStandardOrderedIdentityDictionaryTest >> dictionaryClass [
	^ LazyStandardOrderedIdentityDictionary
]

{ #category : #testing }
LazyStandardOrderedIdentityDictionaryTest >> isTestingLazyDictionary [
	^ true
]
