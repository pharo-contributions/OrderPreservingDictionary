"
This class is a Dictionary that preserves the order of its aassociations. That means messages that return collections of keys, values or associations and messages that enumerate those collections all operate based on the order that the underlying associations were added to the receiver. Association order is not, however, considered when comparing dictionaries for equality. As a result, instances can be compared safely with regular Dictionaries, and if they contain the same associations, regardless of the order, they wil be considered equal. Instances also return a configurable default value, which is nil by default, when an absent key or value is requested from it rather than raising an exception. Other than those differences, this class can generally be used the same way Dictionary can.

(This class is not a subclass of HashedCollection due to a belief that relying on the public API of Dictionary is probably a safer long-term bet than relying on the public and private API of a relatively recent addition to Squeak and Pharo.)
"
Class {
	#name : #OrderPreservingDictionary,
	#superclass : #Collection,
	#instVars : [
		'dictionary',
		'orderedKeys',
		'defaultValue'
	],
	#category : #'Collections-OrderPreservingDictionary'
}

{ #category : #'instance creation' }
OrderPreservingDictionary class >> defaultValue: aDefaultValue [
	^ self new defaultValue: aDefaultValue
]

{ #category : #inspecting }
OrderPreservingDictionary class >> inspectorClass [
	^ Dictionary inspectorClass
]

{ #category : #'instance creation' }
OrderPreservingDictionary class >> new [
	^ self new: 10
]

{ #category : #'instance creation' }
OrderPreservingDictionary class >> new: aCapacity [
	^ self new: aCapacity withDefaultValue: nil
]

{ #category : #'instance creation' }
OrderPreservingDictionary class >> new: aCapacity withDefaultValue: aDefaultValue [
	^ self basicNew initialize: aCapacity withDefaultValue: aDefaultValue
]

{ #category : #'instance creation' }
OrderPreservingDictionary class >> newFrom: aDictionaryOrArray [
	| newDictionary |

	newDictionary := self new: aDictionaryOrArray size.
	aDictionaryOrArray associationsDo: [:each | newDictionary add: each].
	(aDictionaryOrArray respondsTo: #defaultValue)
		ifTrue: [newDictionary defaultValue: aDictionaryOrArray defaultValue].
	^ newDictionary.
]

{ #category : #comparing }
OrderPreservingDictionary >> = anObject [
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
OrderPreservingDictionary >> add: anAssociation [
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
OrderPreservingDictionary >> addAll: aKeyedCollection [
	"This method can accept any collection of associations, not just Dictionaries, because is uses
	#associationsDo rather than #keysAndValuesDo:, and #associationsDo: has a default implementation in
	Collection that just sends #do:. Since this is an order-preserving dictionary, you should be able to add
	multiple associations at once from a SequenceableCollection and have their order be preserved."

	aKeyedCollection associationsDo: [:each | self add: each].
	^ aKeyedCollection.
]

{ #category : #accessing }
OrderPreservingDictionary >> associationAt: aKey [
	^ self associationAt: aKey ifAbsent: [nil]
]

{ #category : #accessing }
OrderPreservingDictionary >> associationAt: aKey ifAbsent: aBlock [
	^ dictionary associationAt: aKey ifAbsent: aBlock
]

{ #category : #accessing }
OrderPreservingDictionary >> associationAt: aKey ifPresent: aBlock [
	"squeak does not have associationAt:ifPresent:"
	^ aBlock cull: (dictionary associationAt: aKey ifAbsent: [^ nil])
]

{ #category : #accessing }
OrderPreservingDictionary >> associations [
	| associations i |

	associations := Array new: self size.
	i := 1.
	self associationsDo: [:each |
		associations at: i put: each.
		i := i + 1].
	^ associations.
]

{ #category : #enumerating }
OrderPreservingDictionary >> associationsDo: aBlock [
	self keysDo: [:each | aBlock value: (self associationAt: each)]
]

{ #category : #enumerating }
OrderPreservingDictionary >> associationsSelect: aBlock [
	^ self species newFrom: (self associations select: aBlock)
]

{ #category : #accessing }
OrderPreservingDictionary >> at: aKey [
	^ self at: aKey ifAbsent: [defaultValue]
]

{ #category : #accessing }
OrderPreservingDictionary >> at: aKey ifAbsent: aBlock [
	^ dictionary at: aKey ifAbsent: aBlock
]

{ #category : #accessing }
OrderPreservingDictionary >> at: aKey ifAbsentPut: aBlock [
	^ self at: aKey ifAbsent: [self at: aKey put: aBlock value]
]

{ #category : #accessing }
OrderPreservingDictionary >> at: aKey ifPresent: aBlock [
	^ dictionary at: aKey ifPresent: aBlock
]

{ #category : #accessing }
OrderPreservingDictionary >> at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ dictionary
		at: aKey
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock
]

{ #category : #accessing }
OrderPreservingDictionary >> at: aKey put: aValue [
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
OrderPreservingDictionary >> capacity [
	^ dictionary capacity
]

{ #category : #enumerating }
OrderPreservingDictionary >> collect: aBlock [
	^ self species newFrom:
		(self associations collect: [:each |
			each key -> (aBlock value: each value)])
]

{ #category : #copying }
OrderPreservingDictionary >> copyEmpty [
	^ self species defaultValue: defaultValue
]

{ #category : #accessing }
OrderPreservingDictionary >> defaultValue [
	^ defaultValue
]

{ #category : #accessing }
OrderPreservingDictionary >> defaultValue: aDefaultValue [
	defaultValue := aDefaultValue
]

{ #category : #private }
OrderPreservingDictionary >> dictionary [
	^ dictionary
]

{ #category : #accessing }
OrderPreservingDictionary >> dictionaryClass [
	^ Dictionary
]

{ #category : #enumerating }
OrderPreservingDictionary >> do: aBlock [
	self valuesDo: aBlock
]

{ #category : #private }
OrderPreservingDictionary >> growOrderedKeys [
	orderedKeys :=
		(Array new: (dictionary capacity max: orderedKeys size + 5))
			replaceFrom: 1
			to: orderedKeys size
			with: orderedKeys
			startingAt: 1.
]

{ #category : #comparing }
OrderPreservingDictionary >> hash [
	^ dictionary hash
]

{ #category : #testing }
OrderPreservingDictionary >> includes: anObject [
	^ dictionary includes: anObject
]

{ #category : #testing }
OrderPreservingDictionary >> includesAssociation: anAssociation [
	^ dictionary includesAssociation: anAssociation
]

{ #category : #testing }
OrderPreservingDictionary >> includesIdentity: anObject [
	^ dictionary includesIdentity: anObject
]

{ #category : #testing }
OrderPreservingDictionary >> includesKey: aKey [
	^ dictionary includesKey: aKey
]

{ #category : #accessing }
OrderPreservingDictionary >> indexOfKey: aKey [
	^ self indexOfKey: aKey ifAbsent: [0]
]

{ #category : #accessing }
OrderPreservingDictionary >> indexOfKey: aKey ifAbsent: aBlock [
	^ orderedKeys indexOf: aKey ifAbsent: aBlock
]

{ #category : #initialization }
OrderPreservingDictionary >> initialize: aCapacity withDefaultValue: aDefaultValue [
	dictionary := self dictionaryClass new: aCapacity.
	orderedKeys := Array new: aCapacity.
	defaultValue := aDefaultValue.
]

{ #category : #testing }
OrderPreservingDictionary >> isDictionary [
	^ true
]

{ #category : #accessing }
OrderPreservingDictionary >> keyAtIdentityValue: aValue [
	^ self keyAtIdentityValue: aValue ifAbsent: [defaultValue]
]

{ #category : #accessing }
OrderPreservingDictionary >> keyAtIdentityValue: aValue ifAbsent: aBlock [
	^ dictionary keyAtIdentityValue: aValue ifAbsent: aBlock
]

{ #category : #accessing }
OrderPreservingDictionary >> keyAtIndex: anIndex [
	^ self keyAtIndex: anIndex ifAbsent: [defaultValue]
]

{ #category : #accessing }
OrderPreservingDictionary >> keyAtIndex: anIndex ifAbsent: aBlock [
	(anIndex >= 1 and: [anIndex <= self size])
		ifTrue: [^ orderedKeys at: anIndex]
		ifFalse: [^ aBlock value]
]

{ #category : #accessing }
OrderPreservingDictionary >> keyAtValue: aValue [
	^ self keyAtValue: aValue ifAbsent: [defaultValue]
]

{ #category : #accessing }
OrderPreservingDictionary >> keyAtValue: aValue ifAbsent: aBlock [
	^ dictionary keyAtValue: aValue ifAbsent: aBlock
]

{ #category : #accessing }
OrderPreservingDictionary >> keyForIdentity: anObject [
	^ dictionary keyForIdentity: anObject
]

{ #category : #accessing }
OrderPreservingDictionary >> keys [
	^ orderedKeys copyFrom: 1 to: self size
]

{ #category : #enumerating }
OrderPreservingDictionary >> keysAndValuesDo: aBlock [
	self keysDo: [:each | aBlock value: each value: (self at: each)]
]

{ #category : #removing }
OrderPreservingDictionary >> keysAndValuesRemove: aTwoArgumentBlock [
	| removedAssociations |

	removedAssociations := OrderedCollection new.
	self associationsDo: [:each |
		(aTwoArgumentBlock value: each key value: each value)
			ifTrue: [removedAssociations add: each]].
	removedAssociations do: [:each | self removeKey: each key].
]

{ #category : #enumerating }
OrderPreservingDictionary >> keysDo: aBlock [
	1 to: self size do: [:i | aBlock value: (orderedKeys at: i)]
]

{ #category : #accessing }
OrderPreservingDictionary >> keysSortedSafely [
	^ dictionary keysSortedSafely
]

{ #category : #testing }
OrderPreservingDictionary >> occurrencesOf: anObject [
	^ self values
		inject: 0
		into: [:total :each |
			each = anObject
				ifTrue: [total + 1]
				ifFalse: [total]]
]

{ #category : #private }
OrderPreservingDictionary >> orderedKeys [
	^ orderedKeys
]

{ #category : #copying }
OrderPreservingDictionary >> postCopy [
	orderedKeys := orderedKeys copy.
	dictionary := dictionary copy.
]

{ #category : #printing }
OrderPreservingDictionary >> printElementsOn: aStream [
	self ifEmpty: [^ self].

	aStream nextPut: $(.
	self associations doWithIndex: [:associaiton :i |
		aStream
			print: associaiton key;
			nextPutAll: '->';
			print: associaiton value.
		(i < self size)
			ifTrue: [aStream space]].
	aStream nextPut: $).
]

{ #category : #printing }
OrderPreservingDictionary >> printNameOn: aStream [
	aStream
		nextPutAll: 'an';
		space;
		nextPutAll: self class name
]

{ #category : #removing }
OrderPreservingDictionary >> remove: anObject ifAbsent: aBlock [
	self shouldNotImplement
]

{ #category : #removing }
OrderPreservingDictionary >> removeAll [
	orderedKeys copyEmpty.
	dictionary removeAll.
]

{ #category : #removing }
OrderPreservingDictionary >> removeKey: aKey [
	^ self removeKey: aKey ifAbsent: [defaultValue]
]

{ #category : #removing }
OrderPreservingDictionary >> removeKey: aKey ifAbsent: aBlock [
	| value keyIndex |

	value := dictionary removeKey: aKey ifAbsent: [^ aBlock value].
	keyIndex := self indexOfKey: aKey.
	[keyIndex <= orderedKeys size]
		whileTrue: [
			orderedKeys
				at: keyIndex
				put: (orderedKeys at:  keyIndex + 1 ifAbsent: [nil]).
			keyIndex := keyIndex + 1].
	^ value.
]

{ #category : #enumerating }
OrderPreservingDictionary >> select: aBlock [
	^ self species newFrom:
		(self associations select: [:each | aBlock value: each value])
]

{ #category : #accessing }
OrderPreservingDictionary >> size [
	^ dictionary size
]

{ #category : #private }
OrderPreservingDictionary >> species [
	^ self class
]

{ #category : #accessing }
OrderPreservingDictionary >> values [
	^ self associations collect: [:each | each value]
]

{ #category : #enumerating }
OrderPreservingDictionary >> valuesDo: aBlock [
	self keysDo: [:each | aBlock value: (self at: each)]
]
