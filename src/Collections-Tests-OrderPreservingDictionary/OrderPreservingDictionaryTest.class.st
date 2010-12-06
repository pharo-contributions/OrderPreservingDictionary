"
This class tests the forwarding protocol of OrderPreservingDictionary using an empty dictionary, one with a single key-value asssociation and one with multiple associations.
"
Class {
	#name : #OrderPreservingDictionaryTest,
	#superclass : #TestCase,
	#category : #'Collections-Tests-OrderPreservingDictionary'
}

{ #category : #assertions }
OrderPreservingDictionaryTest >> assertDictionary: aDictionary commutativelyEquals: aSecondDictioanry [
	self
		assert: aDictionary = aSecondDictioanry;
		assert: aSecondDictioanry = aDictionary
]

{ #category : #assertions }
OrderPreservingDictionaryTest >> assertDictionary: aDictionary doesNotEqual: aSecondDictionary [
	self
		deny: aDictionary = aSecondDictionary;
		deny: aSecondDictionary = aDictionary
]

{ #category : #assertions }
OrderPreservingDictionaryTest >> assertIsDictionary: anObject withAssociations: anAssociationCollection [
	self
		assert: (anObject isMemberOf: self dictionaryClass);
		assert: (anAssociationCollection allSatisfy: [:each | anObject includesAssociation: each])
]

{ #category : #assertions }
OrderPreservingDictionaryTest >> assertSelector: aSelector collects: aCollection [
	| dictionary |

	dictionary := self emptyDictionary.
	self
		assert: (dictionary perform: aSelector) isArray;
		assert: (dictionary perform: aSelector) isEmpty.

	dictionary addAll: self dictionaryAssociations.
	self assert: (dictionary perform: aSelector) = aCollection asArray.
]

{ #category : #assertions }
OrderPreservingDictionaryTest >> assertSelector: aSelector enumerates: aCollection [
	| dictionary enumerated |

	dictionary := self emptyDictionary.
	enumerated := OrderedCollection new.
	dictionary perform: aSelector with: [:each | enumerated add: each].
	self assert: enumerated isEmpty.

	dictionary addAll: self dictionaryAssociations.
	dictionary perform: aSelector with: [:each | enumerated add: each].
	self assert: enumerated asArray = aCollection asArray
]

{ #category : #assertions }
OrderPreservingDictionaryTest >> assertSelector: aSelector enumerates: aFirstCollection and: aSecondCollection [
	| dictionary firstEnumerated secondEnumerated|

	dictionary := self emptyDictionary.
	firstEnumerated := OrderedCollection new.
	secondEnumerated := OrderedCollection new.
	dictionary perform: aSelector with: [:first :second |
		firstEnumerated add: first.
		secondEnumerated add: second].
	self
		assert: firstEnumerated isEmpty;
		assert: secondEnumerated isEmpty.

	dictionary addAll: self dictionaryAssociations.
	dictionary perform: aSelector with: [:first :second |
		firstEnumerated add: first.
		secondEnumerated add: second].
	self
		assert: firstEnumerated asArray = aFirstCollection asArray;
		assert: secondEnumerated asArray = aSecondCollection asArray.
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> dictionaryAssociations [
	"Associations are returned out of their natural sort order"

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
OrderPreservingDictionaryTest >> dictionaryWithTestKeyValue [
	^ self dictionaryClass with: 'testKey'->'testValue'
]

{ #category : #accessing }
OrderPreservingDictionaryTest >> emptyDictionary [
	^ self dictionaryClass new
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAdd [
	| dictionary firstAssoc secondAssoc |

	dictionary := self emptyDictionary.
	firstAssoc := 'testKey'->'testValue'.
	secondAssoc := 'testKey'->'testValue2'.
	self
		deny: (dictionary includesAssociation: firstAssoc);
		deny: (dictionary includesAssociation: secondAssoc).

	self
		assert: (dictionary add: firstAssoc copy) = firstAssoc;
		assert: (dictionary includesAssociation: firstAssoc).
	self
		assert: (dictionary add: secondAssoc copy) = secondAssoc;
		assert: (dictionary includesAssociation: secondAssoc);
		deny: (dictionary includesAssociation: firstAssoc).
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAddAll [
	| dictionary |

	dictionary := self emptyDictionary.
	self deny:
		(self dictionaryAssociations
			anySatisfy: [:each | dictionary includesAssociation: each]).

	self
		assert: (dictionary addAll: self dictionaryAssociations) = self dictionaryAssociations;
		assert: dictionary associations = self dictionaryAssociations.

	"ensure adding the same associations doesn't change the order"
	self
		assert: (dictionary addAll: self dictionaryAssociations reversed) = self dictionaryAssociations reversed;
		assert: dictionary associations = self dictionaryAssociations.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAssociationAt [
	| dictionary |

	dictionary := self dictionaryWithTestKeyValue.
	self
		assert: (dictionary associationAt: 'absent') isNil;
		assert: (dictionary associationAt: 'testKey') = ('testKey'->'testValue').
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAssociationAtIfAbsent [
	| dictionary |

	dictionary := self dictionaryWithTestKeyValue.
	self
		assert: (dictionary associationAt: 'absent' ifAbsent: 'not present') = 'not present';
		assert: (dictionary associationAt: 'testKey' ifAbsent: 'not present') = ('testKey'->'testValue').
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAssociationDeclareAt [
	| dictionary firstAssoc secondAssoc |

	dictionary := self dictionaryWithTestKeyValue.
	firstAssoc := dictionary associationAt: 'testKey'.
	self assert: (dictionary associationDeclareAt: 'testKey') == firstAssoc.

	secondAssoc := 'testKey2'->false.
	self
		deny: (dictionary includesAssociation: secondAssoc);
		assert: (dictionary associationDeclareAt: 'testKey2') = secondAssoc;
		assert: (dictionary includesAssociation: secondAssoc).
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAssociations [
	self assertSelector: #associations collects: self dictionaryAssociations.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAssociationsDo [
	self assertSelector: #associationsDo: enumerates: self dictionaryAssociations.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAssociationsSelelct [
	| dictionary associations |

	associations :=
		self dictionaryAssociations
			select: [:each | each key = 'testKey2' or: [each key = 'testKey3']].
	dictionary :=
		self dictionaryWithAssociations
			associationsSelect: [:each | associations includes: each].
	self assertIsDictionary: dictionary withAssociations: associations.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAt [
	| dictionary |

	dictionary := self dictionaryWithTestKeyValue.
	dictionary defaultValue: 'defaultValue'.
	self
		assert: (dictionary at: 'absent') = 'defaultValue';
		assert: (dictionary at: 'testKey') = 'testValue'.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAtIfAbsent [
	| dictionary |

	dictionary := self dictionaryWithTestKeyValue.
	self
		assert: (dictionary at: 'absent' ifAbsent: ['not present']) = 'not present';
		assert: (dictionary at: 'testKey' ifAbsent: ['not present']) = 'testValue'
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAtIfAbsentPut [
	| dictionary |

	dictionary := self dictionaryWithTestKeyValue.
	self
		assert: (dictionary at: 'testKey' ifAbsentPut: ['differentTestValue']) = 'testValue';
		assert: (dictionary at: 'testKey2' ifAbsentPut: ['testValue2']) = 'testValue2'.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAtIfPresent [
	| dictionary |

	dictionary := self dictionaryWithTestKeyValue.
	self
		assert: (dictionary at: 'testKey' ifPresent: [:each | each = 'testValue']);
		assert: (dictionary at: 'testKey2' ifPresent: ['present']) isNil.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testAtPut [
	| dictionary |

	dictionary := self emptyDictionary.
	self assert:
		(self dictionaryAssociations allSatisfy: [:each |
			(dictionary at: each key put: each value) = each value]).
	self assert: dictionary associations = self dictionaryAssociations.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testCapacity [
	"The current implementation allocations more than specified; the amount allocated may change in the
	future, but it likely won't ever be less than specified, so a >= test is used instead."

	self
		assert: (self dictionaryClass new: 31) capacity >= 31;
		assert: (self dictionaryClass new: 57 withDefaultValue: nil) capacity >= 57;
		assert: (self dictionaryClass defaultValue: nil) capacity >= 10;
		assert: (self dictionaryClass new) capacity >= 10;
		assert:
			(self dictionaryClass newFrom: self dictionaryAssociations) capacity >=
				self dictionaryAssociations size.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testCollect [
	self
		assertIsDictionary:
			(self dictionaryWithAssociations
				collect: [:each | each copyReplaceAll: 'testValue' with: 'newValue'])
		withAssociations:
			(self dictionaryAssociations 
				collect: [:each | each value: (each value copyReplaceAll: 'testValue' with: 'newValue')])
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testCopying [
	| dictionary copy |

	dictionary := self dictionaryWithAssociations.
	copy := dictionary copy.
	self
		assert: dictionary = copy;
		deny: dictionary == copy;
		deny: (dictionary instVarNamed: 'orderedKeys') == (copy instVarNamed: 'orderedKeys');
		deny: (dictionary instVarNamed: 'dictionary') == (copy instVarNamed: 'dictionary').

	copy := dictionary copyEmpty.
	self
		deny: dictionary = copy;
		assert: copy isEmpty.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testDeclareFrom [
	| dictionary |

	dictionary := self dictionaryWithTestKeyValue.
	dictionary declare: 'testKey' from: self emptyDictionary.
	self assert: (dictionary at: 'testKey') = 'testValue'.

	dictionary declare: 'testKey2' from: self emptyDictionary.
	self assert: (dictionary at: 'testKey2') isNil.

	dictionary declare: 'testKey3' from: self dictionaryWithAssociations.
	self assert: (dictionary at: 'testKey3') = 'testValue3'.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testDefaultValue [
	| dictionary |
	
	dictionary :=  self dictionaryClass new: 10 withDefaultValue: 'defaultValue'.
	self assert: dictionary defaultValue = 'defaultValue'.

	dictionary := self dictionaryClass defaultValue: 'defaultValue'.
	self assert: dictionary defaultValue = 'defaultValue'.

	dictionary defaultValue: 'differentDefaultValue'.
	self assert: dictionary defaultValue = 'differentDefaultValue'.
	self
		assert: (self dictionaryClass newFrom: dictionary) defaultValue = 'differentDefaultValue';
		assert: dictionary copy defaultValue = 'differentDefaultValue';
		assert: dictionary copyEmpty defaultValue = 'differentDefaultValue'.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testDo [
	self assertSelector: #do: enumerates: self dictionaryValues
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testDoWithIndex [
	self
		assertSelector: #doWithIndex:
		enumerates: (self dictionaryAssociations collect: [:each | each value])
		and: (1 to: self dictionaryAssociations size)
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testEquals [
	| dictionaryOne dictionaryTwo |

	self assertDictionary: self emptyDictionary commutativelyEquals: self emptyDictionary.

	dictionaryOne := self dictionaryWithTestKeyValue.
	dictionaryTwo := self dictionaryWithTestKeyValue.
	self
		assertDictionary: dictionaryOne doesNotEqual: self emptyDictionary;
		assertDictionary: dictionaryOne commutativelyEquals: dictionaryOne;
		assertDictionary: dictionaryOne commutativelyEquals: dictionaryTwo.

	"For equality, order will not matter"
	dictionaryOne at: 'testKey2' put: 'testValue2'.
	self assertDictionary: dictionaryOne doesNotEqual: dictionaryTwo.
	dictionaryOne at: 'testKey3' put: 'testValue3'.
	self assertDictionary: dictionaryOne doesNotEqual: dictionaryTwo.
	dictionaryTwo at: 'testKey3' put: 'testValue3'.
	self assertDictionary: dictionaryOne doesNotEqual: dictionaryTwo.
	dictionaryTwo at: 'testKey2' put: 'testValue2'.
	self assertDictionary: dictionaryOne commutativelyEquals: dictionaryTwo.
	
	"Comparisons with Dictionaries that contain the same associations should work too"
	self assertDictionary: self emptyDictionary commutativelyEquals: Dictionary new.
	self
		assertDictionary: dictionaryOne
		commutativelyEquals: (Dictionary newFrom: dictionaryOne associations)
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testHash [
	self
		assert: self emptyDictionary hash = self emptyDictionary hash;
		assert: self dictionaryWithTestKeyValue hash = self dictionaryWithTestKeyValue hash;
		assert: self dictionaryWithAssociations hash = self dictionaryWithAssociations hash;
		assert:
			self dictionaryWithAssociations hash =
				(self dictionaryClass newFrom: self dictionaryAssociations reversed) hash;
		assert:
			self dictionaryWithAssociations hash =
				(Dictionary newFrom: self dictionaryAssociations) hash;
		assert:
			self dictionaryWithAssociations hash =
				(Dictionary newFrom: self dictionaryAssociations reversed) hash.

	self
		deny: self emptyDictionary hash = self dictionaryWithTestKeyValue hash;
		deny: self emptyDictionary hash = self dictionaryWithAssociations hash;
		deny: self dictionaryWithTestKeyValue hash = self dictionaryWithAssociations hash.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testIncludes [
	| dictionary |

	dictionary := self emptyDictionary.
	self deny: (self dictionaryAssociations anySatisfy: [:each | dictionary includes: each value]).

	dictionary addAll: self dictionaryAssociations.
	self assert: (self dictionaryAssociations allSatisfy: [:each | dictionary includes: each value])
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
	| dictionary |

	dictionary := self emptyDictionary.
	self deny: (self dictionaryAssociations anySatisfy: [:each | dictionary includesIdentity: each value]).

	dictionary addAll: self dictionaryAssociations.
	self assert: (self dictionaryAssociations allSatisfy: [:each | dictionary includesIdentity: each value]).

	self deny: (self dictionaryAssociations anySatisfy: [:each | dictionary includesIdentity: each value copy]).
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testIncludesKey [
	| dictionary |

	dictionary := self emptyDictionary.
	self deny: (self dictionaryAssociations anySatisfy: [:each | dictionary includesKey: each key]).

	dictionary addAll: self dictionaryAssociations.
	self assert: (self dictionaryAssociations allSatisfy: [:each | dictionary includesKey: each key]).
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testIsDictionary [
	self assert: self emptyDictionary isDictionary
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeyAtIdentityValue [
	| dictionary value |

	dictionary := self dictionaryWithTestKeyValue.
	dictionary defaultValue: 'defaultValue'.
	value := dictionary at: 'testKey'.	
	self
		assert: (dictionary keyAtIdentityValue: 'testValue2') = 'defaultValue';
		assert: (dictionary keyAtIdentityValue: value copy) = 'defaultValue';
		assert: (dictionary keyAtValue: value) = 'testKey'.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeyAtIdentityValueIfAbsent [
	| dictionary value |

	dictionary := self dictionaryWithTestKeyValue.
	value := dictionary at: 'testKey'.	
	self
		assert: (dictionary keyAtIdentityValue: 'testValue2' ifAbsent: ['absent']) = 'absent';
		assert: (dictionary keyAtIdentityValue: value copy ifAbsent: ['absent']) = 'absent';
		assert: (dictionary keyAtValue: value) = 'testKey'.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeyAtValue [
	| dictionary |

	dictionary := self dictionaryWithTestKeyValue.
	dictionary defaultValue: 'defaultValue'.
	self
		assert: (dictionary keyAtValue: 'testValue2') = 'defaultValue';
		assert: (dictionary keyAtValue: 'testValue') = 'testKey'.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeyAtValueIfAbsent [
	| dictionary |

	dictionary := self dictionaryWithTestKeyValue.
	self
		assert: (dictionary keyAtValue: 'testValue2' ifAbsent: ['absent']) = 'absent';
		assert: (dictionary keyAtValue: 'testValue' ifAbsent: ['absent']) = 'testKey'.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeyForIdentity [
	| dictionary value |

	dictionary := self dictionaryWithTestKeyValue.
	value := dictionary at: 'testKey'.
	self
		assert: (dictionary keyForIdentity: value) = 'testKey';
		assert: (dictionary keyForIdentity: value copy) isNil;
		assert: (dictionary keyForIdentity: 'testValue2') isNil.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeys [
	self assertSelector: #keys collects: self dictionaryKeys
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeysAndValuesDo [
	self
		assertSelector: #keysAndValuesDo:
		enumerates: self dictionaryKeys
		and: self dictionaryValues
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeysDo [
	self assertSelector: #keysDo: enumerates: self dictionaryKeys
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testKeysSortedSafely [
	"The keys are all strings, so the default #sorted implementation will suffice."

	self
		assertSelector: #keysSortedSafely
		collects: self dictionaryKeys sorted
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testNewFrom [
	| dictionaryOne dictionaryTwo dictionaryThree |
	
	dictionaryOne := self dictionaryClass newFrom: self dictionaryAssociations.
	dictionaryTwo := self dictionaryClass newFrom: dictionaryOne.
	dictionaryThree := self dictionaryClass newFrom: (Dictionary newFrom: self dictionaryAssociations).

	self
		assertIsDictionary: dictionaryOne withAssociations: self dictionaryAssociations;
		assertIsDictionary: dictionaryTwo withAssociations: self dictionaryAssociations;
		assertIsDictionary: dictionaryThree withAssociations: self dictionaryAssociations.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testOccurancesOf [
	| dictionary |

	dictionary := self emptyDictionary.
	self assert: (dictionary occurrencesOf: 'testValue') isZero.

	dictionary at: 'testKey' put: 'testValue'.
	self assert: (dictionary occurrencesOf: 'testValue') = 1.

	dictionary at: 'testKey2' put: 'testValue'.
	self assert: (dictionary occurrencesOf: 'testValue') = 2.
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
	| dictionary |

	dictionary := self dictionaryWithTestKeyValue.
	dictionary defaultValue: 'defaultValue'.
	self
		assert: (dictionary removeKey: 'testKey2') = 'defaultValue';
		assert: (dictionary removeKey: 'testKey') = 'testValue';
		deny: (dictionary includesKey: 'testKey').

	"Ensure ordering is otherwise preserved:"
	dictionary addAll: self dictionaryAssociations.
	dictionary removeKey: 'testKey2'.
	dictionary removeKey: 'testKey4'.
	self assert:
		dictionary associations =
			(self dictionaryAssociations reject: [:each | #('testKey2' 'testKey4') includes: each key])
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testRemoveKeyIfAbsent [
	| dictionary |

	dictionary := self dictionaryWithTestKeyValue.
	self
		assert: (dictionary removeKey: 'testKey2' ifAbsent: ['absent']) = 'absent';
		assert: (dictionary removeKey: 'testKey' ifAbsent: ['absent']) = 'testValue';
		deny: (dictionary includesKey: 'testKey').
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testSelect [
	self
		assertIsDictionary:
			(self dictionaryWithAssociations select: [:each | each last isDigit])
		withAssociations:
			(self dictionaryAssociations  copyWithout: 'testKey'->'testValue')
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testSize [
	self
		assert: self emptyDictionary size isZero;
		assert: self dictionaryWithTestKeyValue size = 1;
		assert: self dictionaryWithAssociations size = self dictionaryAssociations size.
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testValues [
	self assertSelector: #values collects: self dictionaryValues
]

{ #category : #tests }
OrderPreservingDictionaryTest >> testValuesDo [
	self assertSelector: #valuesDo: enumerates: self dictionaryValues
]
