Class {
	#name : #OrderPreservingStringDictionaryTest,
	#superclass : #StandardOrderedDictionaryTest,
	#category : #'Collections-Tests-OrderPreservingDictionary'
}

{ #category : #testing }
OrderPreservingStringDictionaryTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
OrderPreservingStringDictionaryTest >> dictionaryClass [
	^ OrderPreservingStringDictionary
]

{ #category : #tests }
OrderPreservingStringDictionaryTest >> testAssociationAt [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: (dictionary associationAt: self absentKey) isNil;
		assert: (dictionary associationAt: self singleKey) = self singleAssociation.
]

{ #category : #tests }
OrderPreservingStringDictionaryTest >> testAt [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: (dictionary at: self absentKey) isEmpty;
		assert: (dictionary at: self singleKey) = self singleValue.
]

{ #category : #tests }
OrderPreservingStringDictionaryTest >> testKeyAtIdentityValue [
	| dictionary value |

	dictionary := self dictionaryWithSingleAssociation.
	value := dictionary at: self singleKey.
	self
		assert: (dictionary keyAtIdentityValue: self absentValue) isEmpty;
		assert: (dictionary keyAtIdentityValue: value copy) isEmpty;
		assert: (dictionary keyAtValue: value) = self singleKey.
]

{ #category : #tests }
OrderPreservingStringDictionaryTest >> testKeyAtIndex [
	| dictionary |

	self
		assert: (self emptyDictionary keyAtIndex: 0) isEmpty;
		assert: (self emptyDictionary keyAtIndex: 1) isEmpty.

	dictionary := self dictionaryWithAssociations.
	self dictionaryKeys withIndexDo: [:each :i |
		self assert: (dictionary keyAtIndex: i) = each].
	self
		assert: (dictionary keyAtIndex: 0) isEmpty;
		assert: (dictionary keyAtIndex: dictionary size + 1) isEmpty.
]

{ #category : #tests }
OrderPreservingStringDictionaryTest >> testKeyAtValue [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: (dictionary keyAtValue: self absentValue) isEmpty;
		assert: (dictionary keyAtValue: self singleValue) = self singleKey.
]

{ #category : #tests }
OrderPreservingStringDictionaryTest >> testRemoveKey [
	| dictionary associationsToRemove |

	dictionary := self dictionaryWithAssociations.
	self assert: (dictionary removeKey: self absentKey) isEmpty.
	associationsToRemove := self dictionaryAssociations asOrderedCollection.
	[associationsToRemove notEmpty]
		whileTrue: [ | removed |
			removed := associationsToRemove removeFirst.
			self
				assert: (dictionary removeKey: removed key) = removed value;
				assert: (dictionary removeKey: removed key) isEmpty;
				assertRemovedKey: removed key from: dictionary;
				assert: dictionary keys = (associationsToRemove collect: [:each | each key]) asArray].
]
