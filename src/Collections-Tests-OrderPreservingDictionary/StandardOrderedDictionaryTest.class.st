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
	^ 'absentKey'
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
StandardOrderedDictionaryTest >> assertIsDictionary: anObject includesAll: anAssociationCollection [
	self
		assert: (anObject isMemberOf: self dictionaryClass);
		assert: (anAssociationCollection allSatisfy: [:each | anObject includesAssociation: each])
]

{ #category : #assertions }
StandardOrderedDictionaryTest >> assertIsDictionary: anObject withAssociations: anAssociationCollection [
	self
		assert: (anObject isMemberOf: self dictionaryClass);
		assert: anObject associations = anAssociationCollection
]

{ #category : #assertions }
StandardOrderedDictionaryTest >> assertSelector: aSelector collects: aCollection from: aDictionary [
	self
		assert: (self emptyDictionary perform: aSelector) asArray = #();
		assert: (aDictionary perform: aSelector) asArray = aCollection asArray
]

{ #category : #assertions }
StandardOrderedDictionaryTest >> assertSelector: aSelector enumerates: aFirstCollection and: aSecondCollection from: aDictionary [
	| firstEnumerated secondEnumerated|

	firstEnumerated := OrderedCollection new.
	secondEnumerated := OrderedCollection new.
	self emptyDictionary perform: aSelector with: [:first :second |
		firstEnumerated add: first.
		secondEnumerated add: second].
	self
		assert: firstEnumerated isEmpty;
		assert: secondEnumerated isEmpty.

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
	self emptyDictionary perform: aSelector with: [:each | enumerated add: each].
	self assert: enumerated isEmpty.

	aDictionary perform: aSelector with: [:each | enumerated add: each].
	self assert: enumerated asArray = aCollection asArray.
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> defaultCapacity [
	^ self internalDictionaryClass new capacity
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> dictionaryAssociations [
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
	^ Dictionary
]

{ #category : #accessing }
StandardOrderedDictionaryTest >> internalDictionaryWithAssociations [
	^ self internalDictionaryClass newFrom: self dictionaryAssociations
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
	| dictionary |

	dictionary := self emptyDictionary.
	self deny:
		(self dictionaryAssociations anySatisfy: [:each |
			dictionary includesAssociation: each]).

	self
		assert: (dictionary addAll: self dictionaryAssociations) = self dictionaryAssociations;
		assert: dictionary associations = self dictionaryAssociations.

	"ensure adding the same associations doesn't change the order"
	self assert:
		(dictionary addAll: self dictionaryAssociations reversed) =
			self dictionaryAssociations reversed.
	self assertIsDictionary: dictionary withAssociations: self dictionaryAssociations.
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
		collects: self dictionaryAssociations
		from: self dictionaryWithAssociations
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testAssociationsDo [
	self
		assertSelector: #associationsDo:
		enumerates: self dictionaryAssociations
		from: self dictionaryWithAssociations
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
StandardOrderedDictionaryTest >> testDo [
	self
		assertSelector: #do:
		enumerates: self dictionaryValues
		from: self dictionaryWithAssociations
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
	| orderedDictionary unorderedDictionary |

	"only works on Pharo"
	orderedDictionary := self emptyDictionary.
	unorderedDictionary := self internalDictionaryClass new.
	unorderedDictionary = orderedDictionary
		ifFalse: [^ self].

	self assertDictionary: orderedDictionary equals: unorderedDictionary.
	orderedDictionary addAll: self dictionaryAssociations.
	self assertDictionary: orderedDictionary doesNotEqual: unorderedDictionary.
	
	"Dictionary>>addAll: can only accept keyed collections as an argument, so newFrom: is
	used instead."
	unorderedDictionary := self internalDictionaryWithAssociations.
	self assertDictionary: orderedDictionary equals: unorderedDictionary.
	unorderedDictionary := self internalDictionaryClass newFrom: self dictionaryAssociations reversed.
	self assertDictionary: orderedDictionary equals: unorderedDictionary.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testHash [
	self assert: self emptyDictionary hash = self emptyDictionary hash.
	self assert:
		self dictionaryWithSingleAssociation hash =
			self dictionaryWithSingleAssociation hash.
	self assert:
		self dictionaryWithAssociations hash =
			self dictionaryWithAssociations hash.
	self assert:
		self dictionaryWithAssociations hash =
			(self dictionaryClass newFrom: self dictionaryAssociations reversed) hash.

	self
		deny: self emptyDictionary hash = self dictionaryWithSingleAssociation hash;
		deny: self emptyDictionary hash = self dictionaryWithAssociations hash;
		deny: self dictionaryWithSingleAssociation hash = self dictionaryWithAssociations hash.
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
		self assert: (dictionary indexOfKey: each ifAbsent: [self newValue]) = i].

	self assert:
		(dictionary
			indexOfKey: self absentKey
			ifAbsent: [self newValue]) = self newValue.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testIsDictionary [
	self assert: self dictionaryClass new isDictionary
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testKeyAtIdentityValue [
	| dictionary value |

	dictionary := self dictionaryWithSingleAssociation.
	value := dictionary at: self singleKey.
	self
		should: [dictionary keyAtIdentityValue: self absentValue] raise: Error;
		should: [dictionary keyAtIdentityValue: value copy] raise: Error;
		assert: (dictionary keyAtValue: value) = self singleKey.
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testKeyAtIdentityValueIfAbsent [
	| dictionary value |

	dictionary := self dictionaryWithSingleAssociation.
	value := dictionary at: self singleKey.
	self
		assert: (dictionary keyAtIdentityValue: self absentValue ifAbsent: [self absentKey]) = self absentKey;
		assert: (dictionary keyAtIdentityValue: value copy ifAbsent: [self absentKey]) = self absentKey;
		assert: (dictionary keyAtValue: value) = self singleKey.
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
		collects: self dictionaryKeys
		from: self dictionaryWithAssociations
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testKeysAndValuesDo [
	self
		assertSelector: #keysAndValuesDo:
		enumerates: self dictionaryKeys
		and: self dictionaryValues
		from: self dictionaryWithAssociations
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
		enumerates: self dictionaryKeys
		from: self dictionaryWithAssociations
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testKeysSortedSafely [
	"The keys are all strings, so the default #sorted implementation will suffice."
	self
		assertSelector: #keysSortedSafely
		collects: self dictionaryKeys sorted
		from: self dictionaryWithAssociations
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testNewFrom [
	| dictionaryOne dictionaryTwo dictionaryThree |
	
	dictionaryOne := self dictionaryClass newFrom: self dictionaryAssociations.
	dictionaryTwo := self dictionaryClass newFrom: dictionaryOne.
	dictionaryThree := self dictionaryClass newFrom: self internalDictionaryWithAssociations.
	self
		assertIsDictionary: dictionaryOne withAssociations: self dictionaryAssociations;
		assertIsDictionary: dictionaryTwo withAssociations: self dictionaryAssociations;
		assertIsDictionary: dictionaryThree includesAll: self dictionaryAssociations.

	(self dictionaryClass newFrom: dictionaryOne)
		at: self singleKey put: self newValue.
	self deny: (dictionaryOne at: self singleKey) = self newValue.
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
				deny: (dictionary includesKey: removed key);
				deny: (dictionary keys identityIncludes: removed key);
				deny: (dictionary orderedKeys identityIncludes: removed key);
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
		collects: self dictionaryValues
		from: self dictionaryWithAssociations
]

{ #category : #tests }
StandardOrderedDictionaryTest >> testValuesDo [
	self
		assertSelector: #valuesDo:
		enumerates: self dictionaryValues
		from: self dictionaryWithAssociations
]
