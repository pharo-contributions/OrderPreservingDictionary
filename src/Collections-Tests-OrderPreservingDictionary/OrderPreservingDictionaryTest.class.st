Class {
	#name : #OrderPreservingDictionaryTest,
	#superclass : #StandardOrderedDictionaryTest,
	#category : #'Collections-Tests-OrderPreservingDictionary'
}

{ #category : #testing }
OrderPreservingDictionaryTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> defaultValue [
	^ 'defaultValue'
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> dictionaryClass [
	^ OrderPreservingDictionary
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> newDefaultValue [
	^ 'newDefaultValue'
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAssociationAt [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: (dictionary associationAt: self absentKey) isNil;
		assert: (dictionary associationAt: self singleKey) = self singleAssociation.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAssociationsSelect [
	super testAssociationsSelect.

	self assert:
		(self dictionaryWithAssociations
			defaultValue: self defaultValue;
			associationsSelect: [:each | true]) defaultValue = self defaultValue.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAt [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	dictionary defaultValue: self defaultValue.
	self
		assert: (dictionary at: self absentKey) = self defaultValue;
		assert: (dictionary at: self singleKey) = self singleValue.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testCapacity [
	| defaultCapacity |

	super testCapacity.
	defaultCapacity := self defaultCapacity.
	self
		assert: (self dictionaryClass defaultValue: nil) capacity >= defaultCapacity;
		assert:
			(self dictionaryClass
				new: defaultCapacity * 2
				withDefaultValue: nil) capacity >= (defaultCapacity * 2).
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testCollect [
	super testCollect.

	self assert:
		(self dictionaryWithAssociations
			defaultValue: self defaultValue;
			collect: [:each | each]) defaultValue = self defaultValue.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testCopy [
	| dictionary |

	super testCopy.
	(dictionary := self dictionaryWithAssociations)
		defaultValue: self defaultValue.
	self assert: dictionary copy defaultValue = dictionary defaultValue.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testCopyEmpty [
	| dictionary |

	super testCopyEmpty.
	
	(dictionary := self dictionaryWithAssociations)
		defaultValue: self defaultValue.
	self assert: dictionary copy defaultValue = self defaultValue.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testDefaultValue [
	| dictionary |
	
	dictionary :=  self dictionaryClass new: 10 withDefaultValue: self defaultValue.
	self assert: dictionary defaultValue = self defaultValue.

	dictionary := self dictionaryClass defaultValue: self defaultValue.
	self assert: dictionary defaultValue = self defaultValue.

	dictionary defaultValue: self newDefaultValue.
	self assert: dictionary defaultValue = self newDefaultValue.

	dictionary := (self dictionaryClass newFrom: dictionary).
	self
		assert: dictionary defaultValue = self newDefaultValue;
		assert: dictionary copy defaultValue = self newDefaultValue;
		assert: dictionary copyEmpty defaultValue = self newDefaultValue.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeyAtIdentityValue [
	| dictionary value |

	dictionary := self dictionaryWithSingleAssociation.
	dictionary defaultValue: self defaultValue.
	value := dictionary at: self singleKey.
	self
		assert: (dictionary keyAtIdentityValue: self absentValue) = self defaultValue;
		assert: (dictionary keyAtIdentityValue: value copy) = self defaultValue;
		assert: (dictionary keyAtValue: value) = self singleKey.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeyAtIndex [
	| dictionary |

	(dictionary := self emptyDictionary)
		defaultValue: self defaultValue.
	self
		assert: (dictionary keyAtIndex: 0) = self defaultValue;
		assert: (dictionary keyAtIndex: 1) = self defaultValue.

	(dictionary := self dictionaryWithAssociations)
		defaultValue: self defaultValue.
	self dictionaryKeys withIndexDo: [:each :i |
		self assert: (dictionary keyAtIndex: i) = each].
	self
		assert: (dictionary keyAtIndex: 0) = self defaultValue;
		assert: (dictionary keyAtIndex: dictionary size + 1) = self defaultValue.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeyAtValue [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	dictionary defaultValue: self defaultValue.
	self
		assert: (dictionary keyAtValue: self absentValue) = self defaultValue;
		assert: (dictionary keyAtValue: self singleValue) = self singleKey.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testNewFrom [
	| dictionaryOne dictionaryTwo |

	super testNewFrom.
	(dictionaryOne := self dictionaryClass newFrom: self dictionaryAssociations)
		defaultValue: self defaultValue.
	dictionaryTwo := self dictionaryClass newFrom: dictionaryOne.
	self
		assertIsDictionary: dictionaryTwo withAssociations: self dictionaryAssociations;
		assert: dictionaryTwo defaultValue = self defaultValue.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testRemoveKey [
	| dictionary associationsToRemove |

	(dictionary := self dictionaryWithAssociations)
		defaultValue: self defaultValue.
	self assert: (dictionary removeKey: self absentKey) = self defaultValue.
	associationsToRemove := self dictionaryAssociations asOrderedCollection.
	[associationsToRemove notEmpty]
		whileTrue: [ | removed |
			removed := associationsToRemove removeFirst.
			self
				assert: (dictionary removeKey: removed key) = removed value;
				assert: (dictionary removeKey: removed key) = self defaultValue;
				assertRemovedKey: removed key from: dictionary;
				assert: dictionary keys = (associationsToRemove collect: [:each | each key]) asArray].
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testSelect [
	super testSelect.

	self assert:
		(self dictionaryWithAssociations
			defaultValue: self defaultValue;
			select: [:each | true]) defaultValue = self defaultValue.
]
