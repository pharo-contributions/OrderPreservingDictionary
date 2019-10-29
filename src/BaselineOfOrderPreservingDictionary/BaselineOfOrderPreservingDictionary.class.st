Class {
	#name : #BaselineOfOrderPreservingDictionary,
	#superclass : #BaselineOf,
	#category : #BaselineOfOrderPreservingDictionary
}

{ #category : #baselines }
BaselineOfOrderPreservingDictionary >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec package: 'Collections-OrderPreservingDictionary'.
			spec
				package: 'Collections-OrderPreservingDictionary-Tests'
				with: [ spec requires: 'Collections-OrderPreservingDictionary' ].
			spec
				group: 'default' with: #('Core');
				group: 'Core' with: #('Collections-OrderPreservingDictionary');
				group: 'Tests' with: #('Collections-OrderPreservingDictionary-Tests') ].
	spec
		for: #gemstone
		do: [ spec
				package: 'Collections-OrderPreservingDictionary'
				with: [ spec includes: 'Collections-OrderPreservingDictionaryGemstoneCompatibility' ].
			spec
				package: 'Collections-OrderPreservingDictionaryGemstoneCompatibility'
				with: [ spec requires: 'Collections-OrderPreservingDictionary' ] ].
	spec
		for: #gt
		do: [ spec
				package: 'Collections-OrderPreservingDictionary'
				with: [ spec includes: 'Collections-OrderPreservingDictionaryGTExtensions' ].
			spec
				package: 'Collections-OrderPreservingDictionaryGTExtensions'
				with: [ spec requires: 'Collections-OrderPreservingDictionary' ] ]
]

{ #category : #accessing }
BaselineOfOrderPreservingDictionary >> customProjectAttributes [
	"Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes "

	(Smalltalk globals includesKey: #GTInspector)
		ifTrue: [ ^ #(gt) ]
		ifFalse: [ ^ #() ]
]
