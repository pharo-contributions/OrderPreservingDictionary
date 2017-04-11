"
A lazy version of OrderPreservingDictionary that only allocates memory when modified.
"
Class {
	#name : #LazyOrderPreservingDictionary,
	#superclass : #LazyStandardOrderedDictionary,
	#classVars : [
		'EmptyOrderPreservingDictionary'
	],
	#category : #'Collections-OrderPreservingDictionary'
}

{ #category : #'instance creation' }
LazyOrderPreservingDictionary class >> defaultValue: aDefaultValue [
	^ self basicNew setOrderPreservingDictionary:
		(self emptyOrderPreservingDictionaryClass defaultValue: aDefaultValue)
]

{ #category : #private }
LazyOrderPreservingDictionary class >> emptyOrderPreservingDictionary [
	^ EmptyOrderPreservingDictionary
]

{ #category : #'class initialization' }
LazyOrderPreservingDictionary class >> initialize [
	"self initialize"

	EmptyOrderPreservingDictionary := OrderPreservingDictionary new
]

{ #category : #'instance creation' }
LazyOrderPreservingDictionary class >> new: aCapacity withDefaultValue: aDefaultValue [
	^ self basicNew setOrderPreservingDictionary:
		(self emptyOrderPreservingDictionaryClass
			new: aCapacity
			withDefaultValue: aDefaultValue)
]

{ #category : #accessing }
LazyOrderPreservingDictionary >> defaultValue [
	^ orderPreservingDictionary defaultValue
]

{ #category : #accessing }
LazyOrderPreservingDictionary >> defaultValue: aDefaultValue [
	orderPreservingDictionary defaultValue: aDefaultValue
]

{ #category : #removing }
LazyOrderPreservingDictionary >> removeAll [
	orderPreservingDictionary :=
		orderPreservingDictionary defaultValue ==
			self emptyOrderPreservingDictionary defaultValue
			ifTrue: [self emptyOrderPreservingDictionary]
			ifFalse: [orderPreservingDictionary copyEmpty]
]
