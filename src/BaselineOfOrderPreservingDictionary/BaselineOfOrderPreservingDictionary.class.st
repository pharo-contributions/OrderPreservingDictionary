"
A baseline for an order preserving dictionary [https://github.com/pharo-contributions/OrderPreservingDictionary](https://github.com/pharo-contributions/OrderPreservingDictionary)
"
Class {
	#name : #BaselineOfOrderPreservingDictionary,
	#superclass : #BaselineOf,
	#category : #'BaselineOfOrderPreservingDictionary-Base'
}

{ #category : #baselines }
BaselineOfOrderPreservingDictionary >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Packages"
			spec package: 'Collections-OrderPreservingDictionary';
				  package: 'Collections-OrderPreservingDictionary-Tests' with: [ spec requires: #('Collections-OrderPreservingDictionary') ].

			"Groups"
			spec
				group: 'Core' with: #('Collections-OrderPreservingDictionary');
				group: 'Tests' with: #('Collections-OrderPreservingDictionary-Tests');
				group: 'Tools' with: #();
				group: 'CI' with: #('Tests');
				group: 'all' with: #('Core' 'Tools' 'Tests');
				group: 'default' with: #('all') ].

	self baselineGT: spec.
	self baselineGemstone: spec
]

{ #category : #'baselines - legacy' }
BaselineOfOrderPreservingDictionary >> baselineGT: spec [

	spec
		for: #gt
		do: [
			spec package: 'Collections-OrderPreservingDictionary-GTExtensions' with: [ spec requires: #('Collections-OrderPreservingDictionary') ].
			spec group: 'Tools' with: #('Collections-OrderPreservingDictionary-GTExtensions') ]
]

{ #category : #'baselines - gemstone' }
BaselineOfOrderPreservingDictionary >> baselineGemstone: spec [

	spec
		for: #gemstone
		do: [
			spec package: 'Collections-OrderPreservingDictionary' with: [ spec includes: 'Collections-OrderPreservingDictionary-GemstoneCompatibility' ].
			spec package: 'Collections-OrderPreservingDictionary-GemstoneCompatibility' with: [ spec requires: 'Collections-OrderPreservingDictionary' ]]
]

{ #category : #accessing }
BaselineOfOrderPreservingDictionary >> customProjectAttributes [
	"Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttributes "

	(Smalltalk globals includesKey: #GTInspector)
		ifTrue: [ ^ #(gt) ]
		ifFalse: [ ^ #() ]
]
