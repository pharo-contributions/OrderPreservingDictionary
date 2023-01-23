"
Unit tests for OrderPreservingStringDictionary
"
Class {
	#name : #OrderPreservingStringDictionaryTest,
	#superclass : #StandardOrderedDictionaryTest,
	#category : #'Collections-OrderPreservingDictionary-Tests-Base'
}

{ #category : #accessing }
OrderPreservingStringDictionaryTest >> dictionaryClass [
	^ OrderPreservingStringDictionary
]

{ #category : #tests }
OrderPreservingStringDictionaryTest >> testAssociationAt [
	| dictionary |

	dictionary := self emptyDictionary.
	self orderedAssociations do: [:each |
		self assert: (dictionary associationAt: each key) isNil.

		dictionary add: each.
		self assert: (dictionary associationAt: each key) equals: each]
]

{ #category : #tests }
OrderPreservingStringDictionaryTest >> testAt [
	| dictionary |

	dictionary := self emptyDictionary.
	self orderedAssociations do: [:each |
		self assert: (dictionary at: each key) equals: ''.

		dictionary add: each.
		self assert: (dictionary at: each key) equals: each value]
]

{ #category : #tests }
OrderPreservingStringDictionaryTest >> testKeyAtIdentityValue [
	| dictionary |

	dictionary := self emptyDictionary.
	self orderedAssociations do: [:each |
		self assert: (dictionary keyAtIdentityValue: each value) equals: ''.

		dictionary add: each.
		self
			assert: (dictionary keyAtIdentityValue: each value) equals: each key;
			assert: (dictionary keyAtIdentityValue: each value copy) equals: '']
]

{ #category : #tests }
OrderPreservingStringDictionaryTest >> testKeyAtIndex [
	| dictionary |

	dictionary := self emptyDictionary.
	self assert: (dictionary keyAtIndex: 0) equals: ''.
	self orderedAssociations withIndexDo: [:each :i |
		self assert: (dictionary keyAtIndex: i) equals: ''.

		dictionary add: each.
		self assert: (dictionary keyAtIndex: i) equals: each key]
]

{ #category : #tests }
OrderPreservingStringDictionaryTest >> testKeyAtValue [
	| dictionary |

	dictionary := self emptyDictionary.
	self orderedAssociations do: [:each |
		self assert: (dictionary keyAtValue: each value) equals: ''.

		dictionary add: each.
		self assert: (dictionary keyAtValue: each value) equals: each key]
]

{ #category : #tests }
OrderPreservingStringDictionaryTest >> testRemoveKey [
	| dictionary |

	dictionary := self dictionaryWithOrderedAssociations.
	self orderedAssociations withIndexDo: [:each :i |
		self assert: (dictionary removeKey: each key) equals: each value.
		self
			assertKey: each key
			wasRemovedfrom: dictionary.
		self
			assertIsDictionary: dictionary
			withOrderedAssociations: (self orderedAssociationsAllButFirst: i).

		self assert: (dictionary removeKey: each key) equals: '']
]
