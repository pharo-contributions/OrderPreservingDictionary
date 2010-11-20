"
This class is a Dictionary that preserves the order in which associations are added to it. That means #keys, #keysDo:, #keysAndValuesDo:, #values, #valuesDo:, #associations, and #associationsDo: are all ordered based on key insertion order.

This class is not a subclass of HashedCollection due to a belief that relying on the public API of Dictionary is probably a safer long-term bet than relying on the public and private API of a relatively recent addition to Squeak and Pharo.
"
Class {
	#name : #OrderPreservingDictionary,
	#superclass : #Collection,
	#instVars : [
		'dictionary',
		'orderedKeys'
	],
	#category : #'Collections-OrderPreservingDictionary'
}

{ #category : #'instance creation' }
OrderPreservingDictionary class >> new [
	^ self new: 10
]

{ #category : #'instance creation' }
OrderPreservingDictionary class >> new: aSize [
	^ self basicNew initialize: aSize
]

{ #category : #'instance creation' }
OrderPreservingDictionary class >> newFrom: aDictionaryOrArray [
	| newDictionary |

	newDictionary := self new: aDictionaryOrArray size.
	aDictionaryOrArray associationsDo: [:each | newDictionary add: each].
	^ newDictionary.
]

{ #category : #comparing }
OrderPreservingDictionary >> = anObject [
	^ self == anObject
		or: [self class == anObject class
			and: [self dictionary = anObject dictionary]]
]

{ #category : #adding }
OrderPreservingDictionary >> add: anAssociation [
	self addOrderedKeyIfAbsent: anAssociation key.
	^ dictionary add: anAssociation.
]

{ #category : #adding }
OrderPreservingDictionary >> addAll: aKeyedCollection [
	aKeyedCollection associationsDo: [:each | self add: each].
	^ aKeyedCollection.
]

{ #category : #private }
OrderPreservingDictionary >> addOrderedKeyIfAbsent: aString [
	(dictionary includesKey: aString)
		ifFalse: [orderedKeys addLast: aString]
]

{ #category : #accessing }
OrderPreservingDictionary >> associationAt: aKey [
	^ self associationAt: aKey ifAbsent: [self defaultValue]
]

{ #category : #accessing }
OrderPreservingDictionary >> associationAt: aKey ifAbsent: aBlock [
	^ dictionary associationAt: aKey ifAbsent: aBlock
]

{ #category : #accessing }
OrderPreservingDictionary >> associationDeclareAt: aKey [
	self addOrderedKeyIfAbsent: aKey.
	^ dictionary associationDeclareAt: aKey.
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
	^ self at: aKey ifAbsent: [self defaultValue]
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
OrderPreservingDictionary >> at: aKey ifPresentAndInMemory: aBlock [
	^ dictionary at: aKey ifPresentAndInMemory: aBlock
]

{ #category : #accessing }
OrderPreservingDictionary >> at: aKey put: aBlock [
	self addOrderedKeyIfAbsent: aKey.
	^ dictionary at: aKey put: aBlock.
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
	^ self species new
]

{ #category : #adding }
OrderPreservingDictionary >> declare: aKey from: aDictionary [
	self addOrderedKeyIfAbsent: aKey.
	dictionary declare: aKey from: aDictionary.
]

{ #category : #private }
OrderPreservingDictionary >> defaultValue [
	^ ''
]

{ #category : #private }
OrderPreservingDictionary >> dictionary [
	^ dictionary
]

{ #category : #enumerating }
OrderPreservingDictionary >> do: aBlock [
	self valuesDo: aBlock
]

{ #category : #enumerating }
OrderPreservingDictionary >> doWithIndex: aTwoArgumentBlock [
	| i |

	i := 1.
	self
		do: [:each | aTwoArgumentBlock value: each value: i]
		separatedBy: [i := i + 1].
]

{ #category : #testing }
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

{ #category : #initialization }
OrderPreservingDictionary >> initialize: aSize [
	dictionary := Dictionary new: aSize.
	orderedKeys := OrderedCollection new: aSize.
]

{ #category : #inspecting }
OrderPreservingDictionary >> inspectorClass [
	^ DictionaryInspector
]

{ #category : #testing }
OrderPreservingDictionary >> isDictionary [
	^ true
]

{ #category : #accessing }
OrderPreservingDictionary >> keyAtIdentityValue: aValue [
	^ self keyAtIdentityValue: aValue ifAbsent: [self defaultValue]
]

{ #category : #accessing }
OrderPreservingDictionary >> keyAtIdentityValue: aValue ifAbsent: aBlock [
	^ dictionary keyAtIdentityValue: aValue ifAbsent: aBlock
]

{ #category : #accessing }
OrderPreservingDictionary >> keyAtValue: aValue [
	^ self keyAtValue: aValue ifAbsent: [self defaultValue]
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
	^ Array newFrom: orderedKeys
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
	orderedKeys do: aBlock
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
OrderPreservingDictionary >> remove: anObject [
	self shouldNotImplement
]

{ #category : #removing }
OrderPreservingDictionary >> remove: anObject ifAbsent: aBlock [
	self shouldNotImplement
]

{ #category : #removing }
OrderPreservingDictionary >> removeAll [
	orderedKeys removeAll.
	dictionary removeAll.
]

{ #category : #removing }
OrderPreservingDictionary >> removeKey: aKey [
	^ self removeKey: aKey ifAbsent: [self defaultValue]
]

{ #category : #removing }
OrderPreservingDictionary >> removeKey: aKey ifAbsent: aBlock [
	self removeOrderedKeyIfPresent: aKey.
	^ dictionary removeKey: aKey ifAbsent: aBlock.
]

{ #category : #private }
OrderPreservingDictionary >> removeOrderedKeyIfPresent: aKey [
	(self includesKey: aKey)
		ifTrue: [orderedKeys remove: aKey]
]

{ #category : #removing }
OrderPreservingDictionary >> removeUnreferencedKeys [
	^ self unreferencedKeys collect: [:each | self removeKey: each. each]
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

{ #category : #removing }
OrderPreservingDictionary >> unreferencedKeys [
	^ dictionary unreferencedKeys
]

{ #category : #accessing }
OrderPreservingDictionary >> values [
	^ self associations collect: [:each | each value]
]

{ #category : #enumerating }
OrderPreservingDictionary >> valuesDo: aBlock [
	self keysDo: [:each | aBlock value: (self at: each)]
]
