Class {
	#name : #OrderPreservingIdentityDictionaryTest,
	#superclass : #OrderPreservingDictionaryTest,
	#category : #'Collections-Tests-OrderPreservingDictionary'
}

{ #category : #testing }
OrderPreservingIdentityDictionaryTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
OrderPreservingIdentityDictionaryTest >> absentKey [
	^ self singleKey copy
]

{ #category : #accessing }
OrderPreservingIdentityDictionaryTest >> dictionaryAssociations [
	"associations are copied so can be modified in one test without affecting others,
	but the keys and values are identical each time for identity tests."
	associations
		ifNil: [| key |
			key := 'testKey'.
			associations :=
				Array
					with: (key := key copy) -> 'testValue'
					with: (key := key copy) -> 'testValue3'
					with: (key := key copy) -> 'testValue2'
					with: (key := key copy) -> 'testValue4'].
	^ associations collect: [:each | each copy].
]

{ #category : #accessing }
OrderPreservingIdentityDictionaryTest >> dictionaryClass [
	^ OrderPreservingIdentityDictionary
]

{ #category : #accessing }
OrderPreservingIdentityDictionaryTest >> internalDictionaryClass [
	^ IdentityDictionary
]
