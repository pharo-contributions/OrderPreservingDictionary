"
This class tests the OrderPreservingDictionary class using an empty dictionary, one with a single association and one with multiple associations.
"
Class {
	#name : #OrderPreservingDictionaryTest,
	#superclass : #TestCase,
	#category : #'Collections-Tests-OrderPreservingDictionary'
}

{ #category : #accessing }
OrderPreservingDictionaryTest >> absentKey [
	^ 'absentKey'
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> absentValue [
	^ 'absentValue'
]

{ #category : #assertions }
OrderPreservingDictionaryTest >> assertDictionary: aDictionary doesNotEqual: aSecondDictionary [
	self
		deny: aDictionary = aSecondDictionary;
		deny: aSecondDictionary = aDictionary
]

{ #category : #assertions }
OrderPreservingDictionaryTest >> assertDictionary: aDictionary equals: aSecondDictionary [
	self
		assert: aDictionary = aDictionary;
		assert: aSecondDictionary = aSecondDictionary;
		assert: aDictionary = aSecondDictionary;
		assert: aSecondDictionary = aDictionary
]

{ #category : #assertions }
OrderPreservingDictionaryTest >> assertIsDictionary: anObject includesAll: anAssociationCollection [
	self
		assert: (anObject isMemberOf: self dictionaryClass);
		assert: (anAssociationCollection allSatisfy: [:each | anObject includesAssociation: each])
]

{ #category : #assertions }
OrderPreservingDictionaryTest >> assertIsDictionary: anObject withAssociations: anAssociationCollection [
	self
		assert: (anObject isMemberOf: self dictionaryClass);
		assert: anObject associations = anAssociationCollection
]

{ #category : #assertions }
OrderPreservingDictionaryTest >> assertSelector: aSelector collects: aCollection from: aDictionary [
	self
		assert: (self emptyDictionary perform: aSelector) = #();
		assert: (aDictionary perform: aSelector) = aCollection asArray
]

{ #category : #assertions }
OrderPreservingDictionaryTest >> assertSelector: aSelector enumerates: aFirstCollection and: aSecondCollection from: aDictionary [
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
OrderPreservingDictionaryTest >> assertSelector: aSelector enumerates: aCollection from: aDictionary [
	| enumerated |

	enumerated := OrderedCollection new.
	self emptyDictionary perform: aSelector with: [:each | enumerated add: each].
	self assert: enumerated isEmpty.

	aDictionary perform: aSelector with: [:each | enumerated add: each].
	self assert: enumerated asArray = aCollection asArray.
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> defaultValue [
	^ 'defaultValue'
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> dictionaryAssociations [
	"Associations are grouped out of their natural sort order"

	^ Array
		with: 'testKey'->'testValue'
		with: 'testKey3'->'testValue3'
		with: 'testKey2'->'testValue2'
		with: 'testKey4'->'testValue4'
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> dictionaryClass [
	^ OrderPreservingDictionary
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> dictionaryKeys [
	^ self dictionaryAssociations collect: [:each | each key]
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> dictionaryValues [
	^ self dictionaryAssociations collect: [:each | each value]
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> dictionaryWithAssociations [
	^ self dictionaryClass newFrom: self dictionaryAssociations
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> dictionaryWithSingleAssociation [
	^ self dictionaryClass with: self singleAssociation
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> emptyDictionary [
	^ self dictionaryClass new
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> internalDictionaryClass [
	^ Dictionary
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> internalDictionaryWithAssociations [
	^ self internalDictionaryClass newFrom: self dictionaryAssociations
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> newDefaultValue [
	^ 'newDefaultValue'
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> newKey [
	^ 'newKey'
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> newValue [
	^ 'newValue'
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> singleAssociation [
	^ self dictionaryAssociations first
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> singleKey [
	^ self singleAssociation key
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> singleValue [
	^ self singleAssociation value
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAdd [
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
OrderPreservingDictionaryTest >> testAddAll [
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
OrderPreservingDictionaryTest >> testAssociationAt [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: (dictionary associationAt: self absentKey) = nil;
		assert: (dictionary associationAt: self singleKey) = self singleAssociation.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAssociationAtIfAbsent [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: (dictionary associationAt: self absentKey ifAbsent: [self absentValue]) = self absentValue;
		assert: (dictionary associationAt: self singleKey ifAbsent: [self absentValue]) = self singleAssociation.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAssociations [
	self
		assertSelector: #associations
		collects: self dictionaryAssociations
		from: self dictionaryWithAssociations
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAssociationsDo [
	self
		assertSelector: #associationsDo:
		enumerates: self dictionaryAssociations
		from: self dictionaryWithAssociations
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAssociationsSelelct [
	| dictionary selectedAssociations rejectedAssociation |

	rejectedAssociation := self dictionaryAssociations anyOne.
	selectedAssociations := self dictionaryAssociations copyWithout: rejectedAssociation.
	dictionary :=
		self dictionaryWithAssociations
			associationsSelect: [:each | each ~= rejectedAssociation].
	self
		assertIsDictionary: dictionary withAssociations: selectedAssociations;
		deny: (dictionary includesAssociation: rejectedAssociation)
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
OrderPreservingDictionaryTest >> testAtIfAbsent [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: (dictionary at: self absentKey ifAbsent: [self absentValue]) = self absentValue;
		assert: (dictionary at: self singleKey ifAbsent: [self absentValue]) = self singleValue.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAtIfAbsentPut [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: (dictionary at: self singleKey ifAbsentPut: [self newValue]) = self singleValue;
		assert: (dictionary at: self newKey ifAbsentPut: [self newValue]) = self newValue.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAtIfPresent [
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
OrderPreservingDictionaryTest >> testAtPut [
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
OrderPreservingDictionaryTest >> testCapacity [
	"The current Dictionary implementation allocations more than specified; the amount allocated may
	change in the future, but it likely won't ever be less than specified, so a >= test is used instead."

	self
		assert: (self dictionaryClass new: 31) capacity >= 31;
		assert: (self dictionaryClass new: 57 withDefaultValue: nil) capacity >= 57;
		assert: (self dictionaryClass defaultValue: nil) capacity >= 10;
		assert: (self dictionaryClass new) capacity >= 10;
		assert:
			(self dictionaryClass newFrom: self dictionaryAssociations)
				capacity >= self dictionaryAssociations size.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testCollect [
	self
		assertIsDictionary:
			(self dictionaryWithAssociations collect: [:each | self newValue])
		withAssociations:
			(self dictionaryAssociations collect: [:each | each value: self newValue])
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testCopying [
	| dictionary copy |

	dictionary := self dictionaryWithAssociations.
	copy := dictionary copy.
	self
		assert: dictionary = copy;
		deny: dictionary == copy.

	copy := dictionary copyEmpty.
	self
		deny: dictionary = copy;
		assert: copy isEmpty.
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
OrderPreservingDictionaryTest >> testDo [
	self
		assertSelector: #do:
		enumerates: self dictionaryValues
		from: self dictionaryWithAssociations
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testEquals [
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
OrderPreservingDictionaryTest >> testEqualsDictionary [
	| orderedDictionary unorderedDictionary |

	"Comparisons with Dictionaries that contain the same associations should work too"
	orderedDictionary := self emptyDictionary.
	unorderedDictionary := self internalDictionaryClass new.
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
OrderPreservingDictionaryTest >> testHash [
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
OrderPreservingDictionaryTest >> testIncludes [
	| dictionary |

	dictionary := self emptyDictionary.
	self deny: (self dictionaryValues anySatisfy: [:each | dictionary includes: each]).

	dictionary addAll: self dictionaryAssociations.
	self assert: (self dictionaryValues allSatisfy: [:each | dictionary includes: each]).
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testIncludesAssociation [
	| dictionary |

	dictionary := self emptyDictionary.
	self deny: (self dictionaryAssociations anySatisfy: [:each | dictionary includesAssociation: each]).

	dictionary addAll: self dictionaryAssociations.
	self assert: (self dictionaryAssociations allSatisfy: [:each | dictionary includesAssociation: each])
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testIncludesIdentity [
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
OrderPreservingDictionaryTest >> testIncludesKey [
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
OrderPreservingDictionaryTest >> testIsDictionary [
	self assert: self dictionaryClass new isDictionary
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
OrderPreservingDictionaryTest >> testKeyAtIdentityValueIfAbsent [
	| dictionary value |

	dictionary := self dictionaryWithSingleAssociation.
	value := dictionary at: self singleKey.
	self
		assert: (dictionary keyAtIdentityValue: self absentValue ifAbsent: [self absentKey]) = self absentKey;
		assert: (dictionary keyAtIdentityValue: value copy ifAbsent: [self absentKey]) = self absentKey;
		assert: (dictionary keyAtValue: value) = self singleKey.
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
OrderPreservingDictionaryTest >> testKeyAtValueIfAbsent [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: (dictionary keyAtValue: self absentValue ifAbsent: [self absentKey]) = self absentKey;
		assert: (dictionary keyAtValue: self singleValue ifAbsent: [self absentKey]) = self singleKey.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeyForIdentity [
	| dictionary value |

	dictionary := self dictionaryWithSingleAssociation.
	value := dictionary at: self singleKey.
	self
		assert: (dictionary keyForIdentity: value) = self singleKey;
		assert: (dictionary keyForIdentity: value copy) isNil;
		assert: (dictionary keyForIdentity: self absentValue) isNil.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeys [
	self
		assertSelector: #keys
		collects: self dictionaryKeys
		from: self dictionaryWithAssociations
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeysAndValuesDo [
	self
		assertSelector: #keysAndValuesDo:
		enumerates: self dictionaryKeys
		and: self dictionaryValues
		from: self dictionaryWithAssociations
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeysDo [
	self
		assertSelector: #keysDo:
		enumerates: self dictionaryKeys
		from: self dictionaryWithAssociations
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeysSortedSafely [
	"The keys are all strings, so the default #sorted implementation will suffice."
	self
		assertSelector: #keysSortedSafely
		collects: self dictionaryKeys sorted
		from: self dictionaryWithAssociations
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testNewFrom [
	| dictionaryOne dictionaryTwo dictionaryThree |
	
	dictionaryOne := self dictionaryClass newFrom: self dictionaryAssociations.
	dictionaryTwo := self dictionaryClass newFrom: dictionaryOne.
	dictionaryThree := self dictionaryClass newFrom: self internalDictionaryWithAssociations.

	self
		assertIsDictionary: dictionaryOne withAssociations: self dictionaryAssociations;
		assertIsDictionary: dictionaryTwo withAssociations: self dictionaryAssociations;
		assertIsDictionary: dictionaryThree includesAll: self dictionaryAssociations.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testOccurancesOf [
	| dictionary |

	dictionary := self emptyDictionary.
	self assert: (dictionary occurrencesOf: self absentValue) isZero.

	dictionary add: (self dictionaryAssociations first value: self newValue).
	self assert: (dictionary occurrencesOf: self newValue) = 1.

	dictionary add: (self dictionaryAssociations second value: self newValue) .
	self assert: (dictionary occurrencesOf: self newValue) = 2.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testRemoveAll [
	| dictionary |

	dictionary := self dictionaryWithAssociations.
	self deny: dictionary isEmpty.
	dictionary removeAll.
	self assert: dictionary isEmpty.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testRemoveKey [
	| dictionary removedKey keys |

	dictionary := self dictionaryWithAssociations.

	dictionary defaultValue: self defaultValue.
	self assert: (dictionary removeKey: self absentKey) = self defaultValue.

	keys := dictionary keys asOrderedCollection.
	removedKey := keys removeAt: 2.
	self
		assert: (dictionary removeKey: removedKey) = self dictionaryValues second;
		assert: (dictionary removeKey: removedKey) = self defaultValue;
		deny: (dictionary includesKey: removedKey);
		deny: (dictionary keys identityIncludes: removedKey);
		assert: dictionary keys = keys asArray.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testRemoveKeyIfAbsent [
	| dictionary |

	dictionary := self dictionaryWithSingleAssociation.
	self
		assert: (dictionary removeKey: self absentKey ifAbsent: [self absentValue]) = self absentValue;
		assert: (dictionary removeKey: self singleKey ifAbsent: [self absentValue]) = self singleValue;
		deny: (dictionary includesKey: self singleKey).
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testSelect [
	self
		assertIsDictionary:
			(self dictionaryWithAssociations select: [:each | each ~= self singleValue])
		withAssociations:
			(self dictionaryAssociations copyWithout: self singleAssociation)
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testSize [
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
OrderPreservingDictionaryTest >> testValues [
	self
		assertSelector: #values
		collects: self dictionaryValues
		from: self dictionaryWithAssociations
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testValuesDo [
	self
		assertSelector: #valuesDo:
		enumerates: self dictionaryValues
		from: self dictionaryWithAssociations
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testsKeysAndValuesRemove [
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
