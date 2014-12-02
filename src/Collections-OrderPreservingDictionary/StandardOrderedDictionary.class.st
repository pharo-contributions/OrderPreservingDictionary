"
This class is a dictionary that uses key insertion order when enumerating, printing, or returing collections of keys/values/associations, but not when testing for equality.

Insertion, updating, and inclusion testing have O(1) complexity while removing has O(n) worst-case.
"
Class {
	#name : #StandardOrderedDictionary,
	#superclass : #Collection,
	#instVars : [
		'dictionary',
		'orderedKeys'
	],
	#category : #'Collections-OrderPreservingDictionary'
}

{ #category : #inspecting }
StandardOrderedDictionary class >> inspectorClass [
	^ Dictionary inspectorClass
]

{ #category : #'instance creation' }
StandardOrderedDictionary class >> new [
	^ self new: 10
]

{ #category : #'instance creation' }
StandardOrderedDictionary class >> new: aCapacity [
	^ self basicNew initialize: aCapacity
]

{ #category : #'instance creation' }
StandardOrderedDictionary class >> newFrom: anAssociationCollection [
	| newDictionary |

	newDictionary := self new: anAssociationCollection size.
	anAssociationCollection associationsDo: [:each |
		newDictionary
			at: each key
			put: each value].
	^ newDictionary.
]

{ #category : #'instance creation' }
StandardOrderedDictionary class >> newFromPairs: aSequenceableCollection [
	| newDictionary |

	newDictionary := self new: (aSequenceableCollection size / 2) floor.
	1 to: aSequenceableCollection size - 1 by: 2 do: [:i |
		newDictionary
			at: (aSequenceableCollection at: i)
			put: (aSequenceableCollection at: i + 1)].
	^ newDictionary.
]

{ #category : #comparing }
StandardOrderedDictionary >> = anObject [
	self == anObject
		ifTrue: [^ true].

	(anObject isDictionary and: [anObject size = self size])
		ifFalse: [^ false].

	dictionary associationsDo: [:each |
		(anObject at: each key ifAbsent: [^ false]) = each value
			ifFalse: [^ false]].
	^ true.
]

{ #category : #adding }
StandardOrderedDictionary >> add: anAssociation [
	| oldSize newSize |

	oldSize := dictionary size.
	dictionary add: anAssociation.
	(newSize := dictionary size) > oldSize
		ifTrue: [
			 newSize > orderedKeys size
				ifTrue: [self growOrderedKeys].
			orderedKeys at: newSize put: anAssociation key].
	^ anAssociation.
]

{ #category : #adding }
StandardOrderedDictionary >> addAll: anAssociationCollection [
	"Since Collection implements #associationsDo, this method can accept any collection
	of associations including Arrays and OrderedCollections and not just Dictionaries"

	anAssociationCollection associationsDo: [:each | self add: each].
	^ anAssociationCollection.
]

{ #category : #accessing }
StandardOrderedDictionary >> associationAt: aKey [
	^ dictionary associationAt: aKey
]

{ #category : #accessing }
StandardOrderedDictionary >> associationAt: aKey ifAbsent: aBlock [
	^ dictionary associationAt: aKey ifAbsent: aBlock
]

{ #category : #accessing }
StandardOrderedDictionary >> associationAt: aKey ifPresent: aBlock [
	"squeak does not have associationAt:ifPresent:"
	^ aBlock cull: (dictionary associationAt: aKey ifAbsent: [^ nil])
]

{ #category : #accessing }
StandardOrderedDictionary >> associations [
	| associations i |

	associations := Array new: self size.
	i := 1.
	self associationsDo: [:each |
		associations at: i put: each.
		i := i + 1].
	^ associations.
]

{ #category : #enumerating }
StandardOrderedDictionary >> associationsDo: aBlock [
	self keysDo: [:each | aBlock value: (self associationAt: each)]
]

{ #category : #enumerating }
StandardOrderedDictionary >> associationsSelect: aBlock [
	^ self speciesNewFrom: (self associations select: aBlock)
]

{ #category : #accessing }
StandardOrderedDictionary >> at: aKey [
	^ dictionary at: aKey
]

{ #category : #accessing }
StandardOrderedDictionary >> at: aKey ifAbsent: aBlock [
	^ dictionary at: aKey ifAbsent: aBlock
]

{ #category : #accessing }
StandardOrderedDictionary >> at: aKey ifAbsentPut: aBlock [
	^ self at: aKey ifAbsent: [self at: aKey put: aBlock value]
]

{ #category : #accessing }
StandardOrderedDictionary >> at: aKey ifPresent: aBlock [
	^ dictionary at: aKey ifPresent: aBlock
]

{ #category : #accessing }
StandardOrderedDictionary >> at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ dictionary
		at: aKey
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock
]

{ #category : #accessing }
StandardOrderedDictionary >> at: aKey put: aValue [
	| oldSize newSize |

	oldSize := dictionary size.
	dictionary at: aKey put: aValue.
	(newSize := dictionary size) > oldSize
		ifTrue: [
			 newSize > orderedKeys size
				ifTrue: [self growOrderedKeys].
			orderedKeys at: newSize put: aKey].
	^ aValue.
]

{ #category : #accessing }
StandardOrderedDictionary >> capacity [
	^ dictionary capacity
]

{ #category : #enumerating }
StandardOrderedDictionary >> collect: aBlock [
	^ self speciesNewFrom:
		(self associations collect: [:each |
			each key -> (aBlock value: each value)])
]

{ #category : #copying }
StandardOrderedDictionary >> copyEmpty [
	"for compatibility with squeak"
	^ self species new
]

{ #category : #private }
StandardOrderedDictionary >> deleteOrderedKey: aKey [
	| index |

	index := self indexOfKey: aKey ifAbsent: [^ self].
	orderedKeys
		replaceFrom: index
		to: self size - 1
		with: orderedKeys
		startingAt: index + 1.
	orderedKeys at: self size put: nil.
]

{ #category : #private }
StandardOrderedDictionary >> dictionary [
	^ dictionary
]

{ #category : #accessing }
StandardOrderedDictionary >> dictionaryClass [
	^ Dictionary
]

{ #category : #enumerating }
StandardOrderedDictionary >> do: aBlock [
	self valuesDo: aBlock
]

{ #category : #private }
StandardOrderedDictionary >> errorInvalidIndex: anIndex [
	"squeak does not have SubscriptOutOfBounds."
	(Smalltalk
		at: #SubscriptOutOfBounds
		ifAbsent: [Error signal: 'Invalid index: ', anIndex printString]) signalFor: anIndex
]

{ #category : #private }
StandardOrderedDictionary >> growOrderedKeys [
	orderedKeys :=
		(Array new: ((orderedKeys size * 1.5) asInteger max: 10))
			replaceFrom: 1
			to: orderedKeys size
			with: orderedKeys
			startingAt: 1.
]

{ #category : #comparing }
StandardOrderedDictionary >> hash [
	^ dictionary hash
]

{ #category : #accessing }
StandardOrderedDictionary >> identityIndexOfKey: aKey ifAbsent: aBlock [
	1 to: self size do: [:i |
		(orderedKeys at: i) == aKey
			ifTrue: [^ i]].
	^ aBlock value.
]

{ #category : #testing }
StandardOrderedDictionary >> includes: anObject [
	^ dictionary includes: anObject
]

{ #category : #testing }
StandardOrderedDictionary >> includesAssociation: anAssociation [
	^ dictionary includesAssociation: anAssociation
]

{ #category : #testing }
StandardOrderedDictionary >> includesIdentity: anObject [
	^ dictionary includesIdentity: anObject
]

{ #category : #testing }
StandardOrderedDictionary >> includesKey: aKey [
	^ dictionary includesKey: aKey
]

{ #category : #accessing }
StandardOrderedDictionary >> indexOfKey: aKey [
	^ self indexOfKey: aKey ifAbsent: [0]
]

{ #category : #accessing }
StandardOrderedDictionary >> indexOfKey: aKey ifAbsent: aBlock [
	1 to: self size do: [:i |
		(orderedKeys at: i) = aKey
			ifTrue: [^ i]].
	^ aBlock value.
]

{ #category : #initialization }
StandardOrderedDictionary >> initialize: aCapacity [
	dictionary := self dictionaryClass new: aCapacity.
	orderedKeys := Array new: aCapacity.
]

{ #category : #testing }
StandardOrderedDictionary >> isDictionary [
	^ true
]

{ #category : #accessing }
StandardOrderedDictionary >> keyAtIdentityValue: aValue [
	^ dictionary keyAtIdentityValue: aValue
]

{ #category : #accessing }
StandardOrderedDictionary >> keyAtIdentityValue: aValue ifAbsent: aBlock [
	^ dictionary keyAtIdentityValue: aValue ifAbsent: aBlock
]

{ #category : #accessing }
StandardOrderedDictionary >> keyAtIndex: anIndex [
	^ self keyAtIndex: anIndex ifAbsent: [self errorInvalidIndex: anIndex]
]

{ #category : #accessing }
StandardOrderedDictionary >> keyAtIndex: anIndex ifAbsent: aBlock [
	(anIndex > 0 and: [anIndex <= self size])
		ifTrue: [^ orderedKeys at: anIndex]
		ifFalse: [^ aBlock value]
]

{ #category : #accessing }
StandardOrderedDictionary >> keyAtValue: aValue [
	^ dictionary keyAtValue: aValue
]

{ #category : #accessing }
StandardOrderedDictionary >> keyAtValue: aValue ifAbsent: aBlock [
	^ dictionary keyAtValue: aValue ifAbsent: aBlock
]

{ #category : #accessing }
StandardOrderedDictionary >> keyForIdentity: anObject [
	^ dictionary keyForIdentity: anObject
]

{ #category : #accessing }
StandardOrderedDictionary >> keys [
	^ orderedKeys copyFrom: 1 to: self size
]

{ #category : #enumerating }
StandardOrderedDictionary >> keysAndValuesDo: aBlock [
	self keysDo: [:each | aBlock value: each value: (self at: each)]
]

{ #category : #removing }
StandardOrderedDictionary >> keysAndValuesRemove: aTwoArgumentBlock [
	| removedAssociations |

	removedAssociations := OrderedCollection new.
	self associationsDo: [:each |
		(aTwoArgumentBlock value: each key value: each value)
			ifTrue: [removedAssociations add: each]].
	removedAssociations do: [:each | self removeKey: each key].
]

{ #category : #enumerating }
StandardOrderedDictionary >> keysDo: aBlock [
	1 to: self size do: [:i | aBlock value: (orderedKeys at: i)]
]

{ #category : #accessing }
StandardOrderedDictionary >> keysSortedSafely [
	^ dictionary keysSortedSafely
]

{ #category : #private }
StandardOrderedDictionary >> orderedKeys [
	^ orderedKeys
]

{ #category : #copying }
StandardOrderedDictionary >> postCopy [
	orderedKeys := orderedKeys copy.
	dictionary := dictionary copy.
]

{ #category : #printing }
StandardOrderedDictionary >> printElementsOn: aStream [
	aStream nextPut: $(.
	self size > 100
		ifTrue: [
			aStream nextPutAll: 'size '.
			self size printOn: aStream]
		ifFalse: [
			self associations doWithIndex: [:associaiton :i |
				aStream
					print: associaiton key;
					nextPutAll: '->';
					print: associaiton value.
				(i < self size)
					ifTrue: [aStream space]]].
	aStream nextPut: $).
]

{ #category : #removing }
StandardOrderedDictionary >> remove: anObject ifAbsent: aBlock [
	self shouldNotImplement
]

{ #category : #removing }
StandardOrderedDictionary >> removeAll [
	1 to: self size do: [:i | orderedKeys at: i put: nil].
	dictionary removeAll.
]

{ #category : #removing }
StandardOrderedDictionary >> removeKey: aKey [
	self deleteOrderedKey: aKey.
	^ dictionary removeKey: aKey.
]

{ #category : #removing }
StandardOrderedDictionary >> removeKey: aKey ifAbsent: aBlock [
	self deleteOrderedKey: aKey.
	^ dictionary removeKey: aKey ifAbsent: aBlock.
]

{ #category : #enumerating }
StandardOrderedDictionary >> select: aBlock [
	^ self speciesNewFrom:
		(self associations select: [:each | aBlock value: each value])
]

{ #category : #accessing }
StandardOrderedDictionary >> size [
	^ dictionary size
]

{ #category : #private }
StandardOrderedDictionary >> speciesNewFrom: anAssociationCollection [
	^ self species newFrom: anAssociationCollection
]

{ #category : #accessing }
StandardOrderedDictionary >> values [
	^ self associations collect: [:each | each value]
]

{ #category : #enumerating }
StandardOrderedDictionary >> valuesDo: aBlock [
	self keysDo: [:each | aBlock value: (self at: each)]
]
