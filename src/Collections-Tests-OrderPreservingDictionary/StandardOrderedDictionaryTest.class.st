"
This class tests the OrderPreservingDictionary class using an empty dictionary, one with a single association and one with multiple associations.
"
Class {
	#name : #StandardOrderedDictionaryTest,
	#superclass : #TestCase,
	#instVars : [
		'dictionaryAssociations'
	],
	#category : #'Collections-Tests-OrderPreservingDictionary'
}

{ #category : #accessing }
StandardOrderedDictionaryTest >> absentKey [
	self isTestingIdentityDictionary
		ifTrue: [^ self identityAbsentKey]
		ifFalse: [^ self nonIdentityAbsentKey]
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> absentValue [
	^ 'absentValue'
]

{ #category : #assertions }
StandardOrderedDictionaryTest >> assertDictionary: aDictionary doesNotEqual: aSecondDictionary [
	self
		deny: aDictionary = aSecondDictionary;
		deny: aSecondDictionary = aDictionary
]

{ #category : #assertions }
StandardOrderedDictionaryTest >> assertDictionary: aDictionary equals: aSecondDictionary [
	self
		assert: aDictionary = aDictionary;
		assert: aSecondDictionary = aSecondDictionary;
		assert: aDictionary = aSecondDictionary;
		assert: aSecondDictionary = aDictionary
]

{ #category : #assertions }
StandardOrderedDictionaryTest >> assertIsDictionary: anObject withAssociations: anAssociationCollection [
	"tests that anObject is an instance of the correct dictionary class
	with the specified ordered associations"
	self
		assert: anObject class == self dictionaryClass;
		assert: anObject associations asArray = anAssociationCollection asArray
]

{ #category : #assertions }
StandardOrderedDictionaryTest >> assertIsDictionary: anObject withUnorderedAssociations: anAssociationCollection [
	"tests that anObject is an instance of the correct dictionary class
	with the specified associations, but ignoring the order"
	self
		assert: anObject class == self dictionaryClass;
		assert: anObject size = anAssociationCollection size.
	anAssociationCollection do: [:each |
		self assert: (anObject includesAssociation: each)].
]

{ #category : #assertions }
StandardOrderedDictionaryTest >> assertRemovedKey: aKey from: aDictionary [
	self deny: (aDictionary includesKey: aKey).
	aDictionary keys asArray, aDictionary orderedKeys asArray do: [:each |
		self deny:
			(self isTestingIdentityDictionary
				ifTrue: [each == aKey]
				ifFalse: [each = aKey])].
]

{ #category : #assertions }
StandardOrderedDictionaryTest >> assertSelector: aSelector collects: aCollection from: aDictionary [
	| collected |

	collected := aDictionary perform: aSelector.
	self
		assert: collected class == self collectClass;
		assert: collected asArray = aCollection asArray.
]

{ #category : #assertions }
StandardOrderedDictionaryTest >> assertSelector: aSelector enumerates: aFirstCollection and: aSecondCollection from: aDictionary [
	| firstEnumerated secondEnumerated|

	firstEnumerated := OrderedCollection new.
	secondEnumerated := OrderedCollection new.
	aDictionary perform: aSelector with: [:first :second |
		firstEnumerated add: first.
		secondEnumerated add: second].
	self
		assert: firstEnumerated asArray = aFirstCollection asArray;
		assert: secondEnumerated asArray = aSecondCollection asArray.
]

{ #category : #assertions }
StandardOrderedDictionaryTest >> assertSelector: aSelector enumerates: aCollection from: aDictionary [
	| enumerated |

	enumerated := OrderedCollection new.
	aDictionary perform: aSelector with: [:each | enumerated add: each].
	self assert: enumerated asArray = aCollection asArray.
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> collectClass [
	^ Array
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> defaultCapacity [
	^ self emptyInternalDictionary capacity
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> dictionaryAssociations [
	self isTestingIdentityDictionary
		ifTrue: [^ self identityDictionaryAssociations]
		ifFalse: [^ self nonIdentityDictionaryAssociations]
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> dictionaryClass [
	^ StandardOrderedDictionary
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> dictionaryKeys [
	^ self dictionaryAssociations collect: [:each | each key]
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> dictionaryValues [
	^ self dictionaryAssociations collect: [:each | each value]
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> dictionaryWithAssociations [
	^ self dictionaryClass newFrom: self dictionaryAssociations
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> dictionaryWithSingleAssociation [
	^ self dictionaryClass with: self singleAssociation
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> emptyDictionary [
	^ self dictionaryClass new
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> emptyInternalDictionary [
	^ self internalDictionaryClass new
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> identityAbsentKey [
	^ self singleKey copy
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> identityDictionaryAssociations [
	"associations are copied so can be modified in one test without affecting others,
	but the keys and values are identical each time for identity tests."
	dictionaryAssociations
		ifNil: [| key |
			key := 'testKey'.
			dictionaryAssociations :=
				Array
					with: (key := key copy) -> 'testValue'
					with: (key := key copy) -> 'testValue3'
					with: (key := key copy) -> 'testValue2'
					with: (key := key copy) -> 'testValue4'].
	^ dictionaryAssociations collect: [:each | each copy].
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> internalDictionaryClass [
	self isTestingIdentityDictionary
		ifTrue: [^ IdentityDictionary]
		ifFalse: [^ Dictionary]
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> internalDictionaryWithAssociations [
	^ self internalDictionaryClass newFrom: self dictionaryAssociations
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> internalDictionaryWithSingleAssociation [
	^ self internalDictionaryClass with: self singleAssociation
]

{ #category : #testing }
StandardOrderedDictionaryTest >> isTestingIdentityDictionary [
	^ false
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> newKey [
	^ 'newKey'
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> newValue [
	^ 'newValue'
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> nonIdentityAbsentKey [
	^ 'absentKey'
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> nonIdentityDictionaryAssociations [
	"Associations are grouped out of their natural sort order and
	are copied so can be modified in one test without affecting others,
	but the keys and values are identical each time for identity tests."
	dictionaryAssociations ifNil: [
		dictionaryAssociations :=
		Array
			with: 'testKey'->'testValue'
			with: 'testKey3'->'testValue3'
			with: 'testKey2'->'testValue2'
			with: 'testKey4'->'testValue4'].
	^ dictionaryAssociations collect: [:each | each copy].
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> otherOrderPreservingDictionaryClasses [
	^ StandardOrderedDictionary withAllSubclasses copyWithout: self dictionaryClass
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> singleAssociation [
	^ self dictionaryAssociations first
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> singleKey [
	^ self singleAssociation key
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> singleValue [
	^ self singleAssociation value
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testAdd [
	| dictionary associationToReplace replacementAssociation |

	dictionary := self emptyDictionary.
	self
		deny: (self dictionaryAssociations anySatisfy: [:each | dictionary includesAssociation: each]);
		assert: (self dictionaryAssociations allSatisfy: [:each | (dictionary add: each) == each]);
		assert: (self dictionaryAssociations allSatisfy: [:each | dictionary includesAssociation: each]);
		assert: dictionary associations = self dictionaryAssociations.

	associationToReplace := self dictionaryAssociations anyOne.
	replacementAssociation := associationToReplace copy.
	replacementAssociation value: self newValue.
	self
		assert: (dictionary add: replacementAssociation) == replacementAssociation;
		assert: (dictionary includesAssociation: replacementAssociation);
		deny: (dictionary includesAssociation: associationToReplace).
	self
		assertIsDictionary: dictionary
		withAssociations: 
			(self dictionaryAssociations
				replaceAll: associationToReplace
				with: replacementAssociation).
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testAddAll [
	| dictionary addedAssociations |

	dictionary := self emptyDictionary.
	self deny:
		(self dictionaryAssociations anySatisfy: [:each |
			dictionary includesAssociation: each]).

	addedAssociations := self dictionaryAssociations.
	self assert: (dictionary addAll: addedAssociations) == addedAssociations.
	self
		assertIsDictionary: dictionary
		withAssociations: addedAssociations.

	"ensure adding the same associations doesn't change the order"
	addedAssociations := self dictionaryAssociations reversed.
	self assert: (dictionary addAll: addedAssociations) == addedAssociations.
	self
		assertIsDictionary: dictionary
		withAssociations: self dictionaryAssociations.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testAssociationAt [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		should: [dictionary associationAt: self absentKey] raise: Error;
		assert: (dictionary associationAt: self singleKey) = self singleAssociation.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testAssociationAtIfAbsent [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: (dictionary associationAt: self absentKey ifAbsent: [self absentValue]) = self absentValue;
		assert: (dictionary associationAt: self singleKey ifAbsent: [self absentValue]) = self singleAssociation.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testAssociationAtIfPresent [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: (dictionary associationAt: self absentKey ifPresent: [self absentValue]) isNil;
		assert: (dictionary associationAt: self singleKey ifPresent: [self newValue]) = self newValue.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testAssociations [
	self
		assertSelector: #associations
		collects: #()
		from: self emptyDictionary.
	self
		assertSelector: #associations
		collects: self dictionaryAssociations
		from: self dictionaryWithAssociations.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testAssociationsDo [
	self
		assertSelector: #associationsDo:
		enumerates: #()
		from: self emptyDictionary.
	self
		assertSelector: #associationsDo:
		enumerates: self dictionaryAssociations
		from: self dictionaryWithAssociations.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testAssociationsSelect [
	| dictionary selectedAssociations rejectedAssociation |

	rejectedAssociation := self dictionaryAssociations anyOne.
	selectedAssociations := self dictionaryAssociations copyWithout: rejectedAssociation.
	dictionary :=
		self dictionaryWithAssociations
			associationsSelect: [:each | each ~= rejectedAssociation].
	self
		assertIsDictionary: dictionary withAssociations: selectedAssociations;
		deny: (dictionary includesAssociation: rejectedAssociation).

	(dictionary associationsSelect: [:each | true])
		at: selectedAssociations anyOne key
		put: self newValue.
	self assertIsDictionary: dictionary withAssociations: selectedAssociations.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testAt [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		should: [dictionary at: self absentKey] raise: Error;
		assert: (dictionary at: self singleKey) = self singleValue.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testAtIfAbsent [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: (dictionary at: self absentKey ifAbsent: [self absentValue]) = self absentValue;
		assert: (dictionary at: self singleKey ifAbsent: [self absentValue]) = self singleValue.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testAtIfAbsentPut [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: (dictionary at: self singleKey ifAbsentPut: [self newValue]) = self singleValue;
		assert: (dictionary at: self newKey ifAbsentPut: [self newValue]) = self newValue.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testAtIfPresent [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self assert:
		(dictionary
			at: self singleKey
			ifPresent: [:each |
				each = self singleValue
					ifTrue: [self newValue]
					ifFalse: [nil]]) = self newValue.
	self assert:
		(dictionary
			at: self absentKey
			ifPresent: [:each | self signalFailure: 'Block should not have been evaluated']) isNil.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testAtIfPresentIfAbsent [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self assert:
		(dictionary
			at: self singleKey
			ifPresent: [:value |
				value = self singleValue
					ifTrue: [self newValue]
					ifFalse: [nil]]
			ifAbsent: [self signalFailure: 'Block should not have been evaluated']) = self newValue.
	self assert:
		(dictionary
			at: self absentKey
			ifPresent: [self signalFailure: 'Block should not have been evaluated']
			ifAbsent: [self newValue]) = self newValue.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testAtPut [
	| dictionary keyToUpdate oldValue |

	dictionary := self emptyDictionary.
	self assert:
		(self dictionaryAssociations allSatisfy: [:each |
			(dictionary at: each key put: each value) = each value]).
	self assert: dictionary associations = self dictionaryAssociations.

	keyToUpdate := self dictionaryKeys anyOne.
	oldValue := dictionary at: keyToUpdate.
	self
		assert: (dictionary at: keyToUpdate put: self newValue) = self newValue;
		assert: (dictionary at: keyToUpdate) = self newValue;
		assert:
			(dictionary associations =
				(self dictionaryAssociations collect: [:each |
					(each value = oldValue)
						ifTrue: [each key -> self newValue]
						ifFalse: [each]])).
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testCapacity [
	"The current Dictionary implementation allocations more than specified; the amount allocated may
	change in the future, but it likely won't ever be less than specified, so a >= test is used instead."
	| defaultCapacity |

	defaultCapacity := self defaultCapacity.
	self
		assert: (self dictionaryClass new) capacity >= defaultCapacity;
		assert:
			(self dictionaryClass new: (defaultCapacity / 2) asInteger) capacity >=
				(defaultCapacity / 2) asInteger;
		assert:
			(self dictionaryClass newFrom: self dictionaryAssociations)
				capacity >= self dictionaryAssociations size.

	0 to: self dictionaryAssociations size - 1 do: [:i |
		self
			shouldnt: [(self dictionaryClass new: i) addAll: self dictionaryAssociations]
			raise: Error].
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testCollect [
	| dictionary |

	dictionary := self dictionaryWithAssociations.
	self
		assertIsDictionary: (dictionary collect: [:each | self newValue])
		withAssociations:
			(self dictionaryAssociations collect: [:each | each value: self newValue]).
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testCopy [
	| dictionary copy |

	dictionary := self dictionaryWithAssociations.
	copy := dictionary copy.
	self
		assertDictionary: dictionary equals: copy;
		deny: dictionary == copy;
		deny: dictionary dictionary == copy dictionary;
		deny: dictionary orderedKeys == copy orderedKeys.

	dictionary at: self singleKey put: self newValue.
	self deny: (copy at: self singleKey) = self newValue.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testCopyEmpty [
	| dictionary copy |

	dictionary := self dictionaryWithAssociations.
	copy := dictionary copyEmpty.
	self
		assertDictionary: dictionary doesNotEqual: copy;
		assert: copy isEmpty;
		deny: dictionary isEmpty.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testDictionary [
	| dictionary |

	dictionary := self emptyDictionary.
	self
		assert: dictionary dictionary class == self internalDictionaryClass;
		assert: dictionary dictionary = self emptyInternalDictionary.
	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: dictionary dictionary class == self internalDictionaryClass;
		assert: dictionary dictionary = self internalDictionaryWithSingleAssociation.
	dictionary := self dictionaryWithAssociations.
	self
		assert: dictionary dictionary class == self internalDictionaryClass;
		assert: dictionary dictionary = self internalDictionaryWithAssociations.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testDo [
	self
		assertSelector: #do:
		enumerates: #()
		from: self emptyDictionary.
	self
		assertSelector: #do:
		enumerates: self dictionaryValues
		from: self dictionaryWithAssociations.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testEquals [
	| dictionaryOne dictionaryTwo |

	dictionaryOne := self emptyDictionary.
	dictionaryTwo := self emptyDictionary.
	self assertDictionary: dictionaryOne equals: dictionaryTwo.

	"For equality, order will not matter"
	self dictionaryAssociations
		with: self dictionaryAssociations reversed
		do: [:firstAssociation :secondAssociation |
			dictionaryOne add: firstAssociation.
			dictionaryTwo add: secondAssociation.
			self
				assertDictionary: dictionaryOne doesNotEqual: self emptyDictionary;
				assertDictionary: dictionaryTwo doesNotEqual: self emptyDictionary.
			dictionaryOne size < self dictionaryAssociations size
				ifTrue: [self assertDictionary: dictionaryOne doesNotEqual: dictionaryTwo]].

	self assertDictionary: dictionaryOne equals: dictionaryTwo.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testEqualsDictionary [
	"cannot use assertDictionary:doesNotEqual: for backwards compatibility with
	older Pharo images where Dictionary>>= uses #isDictionary to test the argument
	because these classes also implement isDictionary"
	self
		deny: self emptyDictionary = self emptyInternalDictionary;
		deny: self dictionaryWithAssociations = self internalDictionaryWithAssociations
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testEqualsOtherOrderPreservingDictionaries [
	self otherOrderPreservingDictionaryClasses do: [:otherClass | | dictionary otherDictionary |
		dictionary := self dictionaryClass new.
		otherDictionary := otherClass new.
		dictionary isIdentityDictionary = otherDictionary isIdentityDictionary
			ifTrue: [
				self
					assertDictionary: dictionary
					equals: otherDictionary.
				self dictionaryAssociations do: [:each |
					dictionary add: each.
					self
						assertDictionary: dictionary
						doesNotEqual: otherDictionary.
					otherDictionary add: each copy.
					self
						assertDictionary: dictionary
						equals: otherDictionary]]
			ifFalse: [
				self
					assertDictionary: dictionary
					doesNotEqual: otherDictionary.
				self dictionaryAssociations do: [:each |
					dictionary add: each.
					otherDictionary add: each copy.
					self
						assertDictionary: dictionary
						doesNotEqual: otherDictionary]]]
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testHash [
	| dictionary otherDictionary internalDictionary otherInternalDictionary |

	dictionary := self emptyDictionary.
	otherDictionary := self emptyDictionary.
	internalDictionary := self emptyInternalDictionary.
	otherInternalDictionary := self emptyInternalDictionary.
	self assert: dictionary hash = otherDictionary hash.
	self dictionaryAssociations do: [:each |
		dictionary add: each.
		internalDictionary add: each copy.
		"if the internal hashes differ after adding to one, the external should too"
		internalDictionary hash = otherInternalDictionary hash
			ifFalse: [self deny: dictionary hash = otherDictionary hash].

		otherDictionary add: each copy.
		otherInternalDictionary add: each copy.
		"should be equal regardless now"
		self assert: dictionary hash = otherDictionary hash].
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testHashOtherOrderPreservingDictionaries [
	self otherOrderPreservingDictionaryClasses do: [:otherClass | | dictionary otherDictionary |
		dictionary := self dictionaryClass new.
		otherDictionary := otherClass new.
		dictionary isIdentityDictionary = otherDictionary isIdentityDictionary
			ifTrue: [
				self assert: dictionary hash = otherDictionary hash.
				self dictionaryAssociations do: [:each |
					dictionary add: each.
					otherDictionary add: each copy.
					self assert: dictionary hash = otherDictionary hash]]]
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testIdentityIndexOfKey [
	| dictionary |

	dictionary := self dictionaryWithAssociations.
	dictionary keys withIndexDo: [:each :i |
		self
			assert: (dictionary identityIndexOfKey: each) = i;
			assert: (dictionary identityIndexOfKey: each copy) isZero].
	self assert: (dictionary identityIndexOfKey: self absentKey) isZero.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testIdentityIndexOfKeyIfAbsent [
	| dictionary |

	dictionary := self dictionaryWithAssociations.
	dictionary keys withIndexDo: [:each :i |
		self
			assert: (dictionary identityIndexOfKey: each ifAbsent: [self absentValue]) = i;
			assert:
				(dictionary
					identityIndexOfKey: each copy
					ifAbsent: [self absentValue]) = self absentValue].

	self assert:
		(dictionary
			identityIndexOfKey: self absentKey
			ifAbsent: [self absentValue]) = self absentValue.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testIncludes [
	| dictionary |

	dictionary := self emptyDictionary.
	self deny: (self dictionaryValues anySatisfy: [:each | dictionary includes: each]).

	dictionary addAll: self dictionaryAssociations.
	self assert: (self dictionaryValues allSatisfy: [:each | dictionary includes: each]).
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testIncludesAssociation [
	| dictionary |

	dictionary := self emptyDictionary.
	self deny: (self dictionaryAssociations anySatisfy: [:each | dictionary includesAssociation: each]).

	dictionary addAll: self dictionaryAssociations.
	self assert: (self dictionaryAssociations allSatisfy: [:each | dictionary includesAssociation: each])
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testIncludesIdentity [
	| dictionary associations values |

	dictionary := self emptyDictionary.

	"Need to save references to the exact objects for identity tests"
	associations := self dictionaryAssociations.
	values := associations collect: [:each | each value].
	self deny: (values anySatisfy: [:each | dictionary includesIdentity: each ]).

	dictionary addAll: associations.
	self
		assert: (values allSatisfy: [:each | dictionary includesIdentity: each]);
		deny: (values anySatisfy: [:each | dictionary includesIdentity: each copy]).
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testIncludesKey [
	| dictionary associations |

	dictionary := self emptyDictionary.
	self deny: (self dictionaryKeys anySatisfy: [:each | dictionary includesKey: each]).

	associations := self dictionaryAssociations asOrderedCollection.
	[associations notEmpty]
		whileTrue: [| addedAssociation |
			addedAssociation := dictionary add: associations removeFirst.
			self assert: (dictionary includesKey: addedAssociation key).

			associations do: [:each |
				self deny: (dictionary includesKey: each key)]].
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testIndexOfKey [
	| dictionary |

	dictionary := self dictionaryWithAssociations.
	dictionary keys withIndexDo: [:each :i |
		self assert: (dictionary indexOfKey: each) = i].
	self assert: (dictionary indexOfKey: self absentKey) isZero.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testIndexOfKeyIfAbsent [
	| dictionary |

	dictionary := self dictionaryWithAssociations.
	dictionary keys withIndexDo: [:each :i |
		self assert: (dictionary indexOfKey: each ifAbsent: [self absentValue]) = i].

	self assert:
		(dictionary
			indexOfKey: self absentKey
			ifAbsent: [self absentValue]) = self absentValue.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testIsDictionary [
	self assert: self dictionaryClass new isDictionary
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testIsIdentityDictionary [
	self assert: self emptyDictionary isIdentityDictionary = self isTestingIdentityDictionary
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testKeyAtIdentityValue [
	| dictionary singleValue |

	dictionary := self dictionaryWithSingleAssociation.
	singleValue := dictionary at: self singleKey.
	self
		should: [dictionary keyAtIdentityValue: self absentValue] raise: Error;
		should: [dictionary keyAtIdentityValue: singleValue copy] raise: Error;
		assert: (dictionary keyAtIdentityValue: singleValue) = self singleKey.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testKeyAtIdentityValueIfAbsent [
	| dictionary singleValue |

	dictionary := self dictionaryWithSingleAssociation.
	singleValue := dictionary at: self singleKey.
	self assert:
		(dictionary
			keyAtIdentityValue: self absentValue
			ifAbsent: [self absentKey]) = self absentKey.
	self assert:
		(dictionary
			keyAtIdentityValue: singleValue copy
			ifAbsent: [self absentKey]) = self absentKey.
	self assert:
		(dictionary
			keyAtValue: singleValue
			ifAbsent: [self absentKey]) = self singleKey.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testKeyAtIndex [
	| dictionary |

	self
		should: [self emptyDictionary keyAtIndex: 0] raise: Error;
		should: [self emptyDictionary keyAtIndex: 1] raise: Error.

	dictionary := self dictionaryWithAssociations.
	self dictionaryKeys withIndexDo: [:each :i |
		self assert: (dictionary keyAtIndex: i) = each].
	self
		should: [dictionary keyAtIndex: 0] raise: Error;
		should: [dictionary keyAtIndex: dictionary size + 1] raise: Error.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testKeyAtIndexIfAbsent [
	| dictionary |

	dictionary := self emptyDictionary.
	self
		assert: (dictionary keyAtIndex: 0 ifAbsent: [self newKey]) = self newKey;
		assert: (dictionary keyAtIndex: 1 ifAbsent: [self newKey]) = self newKey.

	dictionary := self dictionaryWithAssociations.
	self dictionaryKeys withIndexDo: [:each :i |
		self assert: (dictionary keyAtIndex: i ifAbsent: [self newKey]) = each].
	self assert:
		(dictionary
			keyAtIndex: 0
			ifAbsent: [self newKey]) = self newKey.
	self assert:
			(dictionary
				keyAtIndex: dictionary size + 1
				ifAbsent: [self newKey]) = self newKey.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testKeyAtValue [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		should: [dictionary keyAtValue: self absentValue] raise: Error;
		assert: (dictionary keyAtValue: self singleValue) = self singleKey.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testKeyAtValueIfAbsent [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: (dictionary keyAtValue: self absentValue ifAbsent: [self absentKey]) = self absentKey;
		assert: (dictionary keyAtValue: self singleValue ifAbsent: [self absentKey]) = self singleKey.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testKeyForIdentity [
	| dictionary value |

	dictionary := self dictionaryWithSingleAssociation.
	value := dictionary at: self singleKey.
	self
		assert: (dictionary keyForIdentity: value) = self singleKey;
		assert: (dictionary keyForIdentity: value copy) isNil;
		assert: (dictionary keyForIdentity: self absentValue) isNil.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testKeys [
	self
		assertSelector: #keys
		collects: #()
		from: self emptyDictionary.
	self
		assertSelector: #keys
		collects: self dictionaryKeys
		from: self dictionaryWithAssociations.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testKeysAndValuesDo [
	self
		assertSelector: #keysAndValuesDo:
		enumerates: #()
		and: #()
		from: self emptyDictionary.
	self
		assertSelector: #keysAndValuesDo:
		enumerates: self dictionaryKeys
		and: self dictionaryValues
		from: self dictionaryWithAssociations.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testKeysAndValuesRemove [
	| dictionary keys |

	dictionary := self dictionaryWithAssociations.
	keys := self dictionaryKeys.
	dictionary keysAndValuesRemove: [:key :value | keys first = key or: [keys third = key]].

	self
		deny: (dictionary includesKey: keys first);
		deny: (dictionary includesKey: keys third);
		assert:
			(((keys copyWithout: keys first) copyWithout: keys third)
				allSatisfy: [:each | dictionary includesKey: each]).
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testKeysDo [
	self
		assertSelector: #keysDo:
		enumerates: #()
		from: self emptyDictionary.
	self
		assertSelector: #keysDo:
		enumerates: self dictionaryKeys
		from: self dictionaryWithAssociations.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testKeysSortedSafely [
	self
		assertSelector: #keysSortedSafely
		collects: #()
		from: self emptyDictionary.
	"The keys are all strings, so the default #sorted implementation is OK."
	self
		assertSelector: #keysSortedSafely
		collects: self dictionaryKeys sorted
		from: self dictionaryWithAssociations.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testNewFrom [
	| dictionary |
	
	dictionary := self dictionaryClass newFrom: self dictionaryAssociations.
	self
		assertIsDictionary: dictionary
		withAssociations: self dictionaryAssociations.
	self
		assertIsDictionary: (self dictionaryClass newFrom: dictionary)
		withAssociations: self dictionaryAssociations.
	self
		assertIsDictionary:
			(self dictionaryClass newFrom: self internalDictionaryWithAssociations)
		withUnorderedAssociations: self dictionaryAssociations.

	self
		assertDictionary: dictionary
		doesNotEqual:
			((self dictionaryClass newFrom: dictionary)
				at: self singleKey put: self newValue;
				yourself).
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testNewFromPairs [
	| pairs |

	pairs := OrderedCollection new.
	self dictionaryAssociations do: [:each |
		pairs
			add: each key;
			add: each value].
	0 to: pairs size do: [:i |
		self
			assertDictionary:
				(self dictionaryClass newFromPairs: (pairs copyFrom: 1 to: i))
			equals:
				(self dictionaryClass newFrom:
					(self dictionaryAssociations copyFrom: 1 to: (i / 2) floor))].
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testOccurancesOf [
	| dictionary |

	dictionary := self emptyDictionary.
	self assert: (dictionary occurrencesOf: self absentValue) isZero.

	dictionary add: (self dictionaryAssociations first value: self newValue).
	self assert: (dictionary occurrencesOf: self newValue) = 1.

	dictionary add: (self dictionaryAssociations second value: self newValue) .
	self assert: (dictionary occurrencesOf: self newValue) = 2.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testRemoveAll [
	| dictionary |

	dictionary := self dictionaryWithAssociations.
	self deny: dictionary isEmpty.
	dictionary removeAll.
	self
		assert: dictionary isEmpty;
		assert: (dictionary orderedKeys allSatisfy: [:each | each isNil]).
	dictionary addAll: self dictionaryAssociations.
	self deny: dictionary isEmpty.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testRemoveKey [
	| dictionary associationsToRemove |

	dictionary := self dictionaryWithAssociations.
	self should: [dictionary removeKey: self absentKey] raise: Error.
	associationsToRemove := self dictionaryAssociations asOrderedCollection.
	[associationsToRemove notEmpty]
		whileTrue: [ | removed |
			removed := associationsToRemove removeFirst.
			self
				assert: (dictionary removeKey: removed key) = removed value;
				should: [dictionary removeKey: removed key] raise: Error;
				assertRemovedKey: removed key from: dictionary;
				assert: dictionary keys = (associationsToRemove collect: [:each | each key]) asArray].
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testRemoveKeyIfAbsent [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: (dictionary removeKey: self absentKey ifAbsent: [self absentValue]) = self absentValue;
		assert: (dictionary removeKey: self singleKey ifAbsent: [self absentValue]) = self singleValue;
		deny: (dictionary includesKey: self singleKey).
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testRemoveKeys [
	0 to: self dictionaryKeys size do: [:i | | dictionary keysToRemove dictionaryWithoutKeys |
		dictionary := self dictionaryWithAssociations.
		keysToRemove := (self dictionaryKeys copyFrom: 1 to: i) asSet.
		self assert: (dictionary removeKeys: keysToRemove) == dictionary.
	
		dictionaryWithoutKeys := self dictionaryWithAssociations.
		keysToRemove do: [:each | dictionaryWithoutKeys removeKey: each].
		self
			assertDictionary: dictionary
			equals: dictionaryWithoutKeys.
		self assert: dictionary keys = dictionaryWithoutKeys keys]
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testSelect [
	| dictionary |

	dictionary := self dictionaryWithAssociations.
	self
		assertIsDictionary: (dictionary select: [:each | each ~= self singleValue])
		withAssociations: (self dictionaryAssociations copyWithout: self singleAssociation).

	(dictionary select: [:each | true]) at: self singleKey put: self newValue.
	self deny: (dictionary at: self singleKey) = self newValue.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testSize [
	| dictionary |

	dictionary := self emptyDictionary.
	self assert: dictionary size isZero.

	self dictionaryAssociations doWithIndex: [:each :i |
		dictionary add: each.
		self assert: dictionary size = i].

	self dictionaryAssociations size to: 1 by: -1 do: [:i |
		dictionary removeKey: (self dictionaryKeys at: i).
		self assert: dictionary size = (i - 1)].
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testValues [
	self
		assertSelector: #values
		collects: #()
		from: self emptyDictionary.
	self
		assertSelector: #values
		collects: self dictionaryValues
		from: self dictionaryWithAssociations.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testValuesDo [
	self
		assertSelector: #valuesDo:
		enumerates: #()
		from: self emptyDictionary.
	self
		assertSelector: #valuesDo:
		enumerates: self dictionaryValues
		from: self dictionaryWithAssociations.
]
