"
A lazy version of StandardOrderedDictionary that only allocates memory when modified.
"
Class {
	#name : #LazyStandardOrderedDictionary,
	#superclass : #Collection,
	#instVars : [
		'orderPreservingDictionary'
	],
	#classVars : [
		'EmptyStandardOrderedDictionary'
	],
	#category : #'Collections-OrderPreservingDictionary'
}

{ #category : #private }
LazyStandardOrderedDictionary class >> emptyOrderPreservingDictionary [
	^ EmptyStandardOrderedDictionary
]

{ #category : #private }
LazyStandardOrderedDictionary class >> emptyOrderPreservingDictionaryClass [
	^ self emptyOrderPreservingDictionary class
]

{ #category : #'class initialization' }
LazyStandardOrderedDictionary class >> initialize [
	"self initialize"

	"directly initialized class vars are used for the empty dictionaries
	to simplify initialization and speed up instance creation"
	EmptyStandardOrderedDictionary := StandardOrderedDictionary new
]

{ #category : #'instance creation' }
LazyStandardOrderedDictionary class >> new [
	^ self basicNew setOrderPreservingDictionary:
		self emptyOrderPreservingDictionary
]

{ #category : #'instance creation' }
LazyStandardOrderedDictionary class >> new: aCapacity [
	^ self new
]

{ #category : #'instance creation' }
LazyStandardOrderedDictionary class >> newFrom: anAssociationCollection [
	^ self basicNew setOrderPreservingDictionary:
		(self emptyOrderPreservingDictionaryClass newFrom:
			anAssociationCollection)
]

{ #category : #'instance creation' }
LazyStandardOrderedDictionary class >> newFromPairs: aSequenceableCollection [
	^ self basicNew setOrderPreservingDictionary:
		(self emptyOrderPreservingDictionaryClass newFromPairs:
			aSequenceableCollection)
]

{ #category : #comparing }
LazyStandardOrderedDictionary >> = anObject [
	^ orderPreservingDictionary = anObject
]

{ #category : #adding }
LazyStandardOrderedDictionary >> add: anAssociation [
	^ self copiedOrderPreservingDictionary add: anAssociation
]

{ #category : #adding }
LazyStandardOrderedDictionary >> addAll: anAssociationCollection [
	^ self copiedOrderPreservingDictionary addAll: anAssociationCollection
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> associationAt: aKey [
	^ orderPreservingDictionary associationAt: aKey
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> associationAt: aKey ifAbsent: aBlock [
	^ orderPreservingDictionary
		associationAt: aKey
		ifAbsent: aBlock
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> associationAt: aKey ifPresent: aBlock [
	^ orderPreservingDictionary
		associationAt: aKey
		ifPresent: aBlock
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> associations [
	^ orderPreservingDictionary associations
]

{ #category : #enumerating }
LazyStandardOrderedDictionary >> associationsDo: aBlock [
	orderPreservingDictionary associationsDo: aBlock
]

{ #category : #enumerating }
LazyStandardOrderedDictionary >> associationsSelect: aBlock [
	^ self copyEmpty setOrderPreservingDictionary:
		(orderPreservingDictionary associationsSelect: aBlock)
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> at: aKey [
	^ orderPreservingDictionary at: aKey
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> at: aKey ifAbsent: aBlock [
	^ orderPreservingDictionary
		at: aKey
		ifAbsent: aBlock
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> at: aKey ifAbsentPut: aBlock [
	^ self copiedOrderPreservingDictionary
		at: aKey
		ifAbsentPut: aBlock
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> at: aKey ifPresent: aBlock [
	^ orderPreservingDictionary
		at: aKey
		ifPresent: aBlock
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ orderPreservingDictionary
		at: aKey
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> at: aKey put: aValue [
	^ self copiedOrderPreservingDictionary
		at: aKey
		put: aValue
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> capacity [
	^ orderPreservingDictionary capacity
]

{ #category : #enumerating }
LazyStandardOrderedDictionary >> collect: aBlock [
	^ self copyEmpty setOrderPreservingDictionary:
		(orderPreservingDictionary collect: aBlock)
]

{ #category : #private }
LazyStandardOrderedDictionary >> copiedOrderPreservingDictionary [
	"replaces the shared, empty order-preserving dictionary with a new
	mutable one ready for modification"
	^ orderPreservingDictionary == self emptyOrderPreservingDictionary
		ifTrue: [orderPreservingDictionary := orderPreservingDictionary copy]
		ifFalse: [orderPreservingDictionary]
]

{ #category : #copying }
LazyStandardOrderedDictionary >> copyEmpty [
	"Squeak and GS don't have Collection>>#copyEmpty:, so it is
	reimplemented for portability"
	^ self species new
]

{ #category : #private }
LazyStandardOrderedDictionary >> dictionary [
	^ orderPreservingDictionary dictionary
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> dictionaryClass [
	^ orderPreservingDictionary dictionaryClass
]

{ #category : #enumerating }
LazyStandardOrderedDictionary >> do: aBlock [
	orderPreservingDictionary do: aBlock
]

{ #category : #private }
LazyStandardOrderedDictionary >> emptyOrderPreservingDictionary [
	^ self class emptyOrderPreservingDictionary
]

{ #category : #comparing }
LazyStandardOrderedDictionary >> hash [
	^ orderPreservingDictionary hash
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> identityIndexOfKey: aKey [
	^ orderPreservingDictionary identityIndexOfKey: aKey
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> identityIndexOfKey: aKey ifAbsent: aBlock [
	^ orderPreservingDictionary
		identityIndexOfKey: aKey
		ifAbsent: aBlock
]

{ #category : #testing }
LazyStandardOrderedDictionary >> includesAssociation: anAssociation [
	^ orderPreservingDictionary includesAssociation: anAssociation
]

{ #category : #testing }
LazyStandardOrderedDictionary >> includesIdentity: anObject [
	^ orderPreservingDictionary includesIdentity: anObject
]

{ #category : #testing }
LazyStandardOrderedDictionary >> includesKey: aKey [
	^ orderPreservingDictionary includesKey: aKey
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> indexOfKey: aKey [
	^ orderPreservingDictionary indexOfKey: aKey
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> indexOfKey: aKey ifAbsent: aBlock [
	^ orderPreservingDictionary
		indexOfKey: aKey
		ifAbsent: aBlock
]

{ #category : #testing }
LazyStandardOrderedDictionary >> isDictionary [
	^ true
]

{ #category : #testing }
LazyStandardOrderedDictionary >> isEmpty [
	"Squeak's Collection>>#isEmpty is inefficient"
	^ orderPreservingDictionary isEmpty
]

{ #category : #testing }
LazyStandardOrderedDictionary >> isIdentityDictionary [
	^ orderPreservingDictionary isIdentityDictionary
]

{ #category : #testing }
LazyStandardOrderedDictionary >> isOrderPreservingDictionary [
	^ true
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> keyAtIdentityValue: aValue [
	^ orderPreservingDictionary keyAtIdentityValue: aValue
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> keyAtIdentityValue: aValue ifAbsent: aBlock [
	^ orderPreservingDictionary
		keyAtIdentityValue: aValue
		ifAbsent: aBlock
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> keyAtIndex: anIndex [
	^ orderPreservingDictionary keyAtIndex: anIndex
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> keyAtIndex: anIndex ifAbsent: aBlock [
	^ orderPreservingDictionary
		keyAtIndex: anIndex
		ifAbsent: aBlock
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> keyAtValue: anObject [
	^ orderPreservingDictionary keyAtValue: anObject
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> keyAtValue: anObject ifAbsent: aBlock [
	^ orderPreservingDictionary
		keyAtValue: anObject
		ifAbsent: aBlock
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> keyForIdentity: anObject [
	^ orderPreservingDictionary keyForIdentity: anObject
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> keys [
	^ orderPreservingDictionary keys
]

{ #category : #enumerating }
LazyStandardOrderedDictionary >> keysAndValuesDo: aBlock [
	orderPreservingDictionary keysAndValuesDo: aBlock
]

{ #category : #removing }
LazyStandardOrderedDictionary >> keysAndValuesRemove: aTwoArgumentBlock [
	self copiedOrderPreservingDictionary keysAndValuesRemove: aTwoArgumentBlock
]

{ #category : #enumerating }
LazyStandardOrderedDictionary >> keysDo: aBlock [
	orderPreservingDictionary keysDo: aBlock
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> keysSortedSafely [
	^ orderPreservingDictionary keysSortedSafely
]

{ #category : #private }
LazyStandardOrderedDictionary >> orderPreservingDictionary [
	^ orderPreservingDictionary
]

{ #category : #private }
LazyStandardOrderedDictionary >> orderedKeys [
	^ orderPreservingDictionary orderedKeys
]

{ #category : #copying }
LazyStandardOrderedDictionary >> postCopy [
	orderPreservingDictionary == self emptyOrderPreservingDictionary
		ifFalse: [orderPreservingDictionary := orderPreservingDictionary copy]
]

{ #category : #printing }
LazyStandardOrderedDictionary >> printElementsOn: aStream [
	orderPreservingDictionary printElementsOn: aStream
]

{ #category : #removing }
LazyStandardOrderedDictionary >> remove: anObject ifAbsent: aBlock [
	self shouldNotImplement
]

{ #category : #removing }
LazyStandardOrderedDictionary >> removeAll [
	orderPreservingDictionary := self emptyOrderPreservingDictionary
]

{ #category : #removing }
LazyStandardOrderedDictionary >> removeKey: aKey [
	^ self copiedOrderPreservingDictionary removeKey: aKey
]

{ #category : #removing }
LazyStandardOrderedDictionary >> removeKey: aKey ifAbsent: aBlock [
	^ self copiedOrderPreservingDictionary
		removeKey: aKey
		ifAbsent: aBlock
]

{ #category : #removing }
LazyStandardOrderedDictionary >> removeKeys: aKeyCollection [
	self copiedOrderPreservingDictionary removeKeys: aKeyCollection
]

{ #category : #enumerating }
LazyStandardOrderedDictionary >> select: aBlock [
	^ self copyEmpty setOrderPreservingDictionary:
		(orderPreservingDictionary select: aBlock)
]

{ #category : #initialization }
LazyStandardOrderedDictionary >> setOrderPreservingDictionary: anOrderPreservingDictionary [
	orderPreservingDictionary := anOrderPreservingDictionary
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> size [
	^ orderPreservingDictionary size
]

{ #category : #accessing }
LazyStandardOrderedDictionary >> values [
	^ orderPreservingDictionary values
]

{ #category : #enumerating }
LazyStandardOrderedDictionary >> valuesDo: aBlock [
	orderPreservingDictionary valuesDo: aBlock
]
