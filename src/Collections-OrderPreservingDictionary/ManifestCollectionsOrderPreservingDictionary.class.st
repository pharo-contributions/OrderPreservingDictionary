"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCollectionsOrderPreservingDictionary,
	#superclass : #PackageManifest,
	#category : #'Collections-OrderPreservingDictionary-Manifest'
}

{ #category : #'code-critics' }
ManifestCollectionsOrderPreservingDictionary class >> ruleBadMessageRule2V1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#'OrderPreservingDictionary class' #newFrom: #true)) #'2023-09-10T01:42:26.147+02:00') )
]

{ #category : #'code-critics' }
ManifestCollectionsOrderPreservingDictionary class >> ruleConsistencyCheckRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#StandardOrderedDictionary #isEmpty #false)) #'2023-09-10T01:37:29.475+02:00') )
]

{ #category : #'code-critics' }
ManifestCollectionsOrderPreservingDictionary class >> ruleLiteralArrayContainsSuspiciousTrueFalseOrNilRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMetaclassDefinition #(#'ManifestCollectionsOrderPreservingDictionary class' #ManifestCollectionsOrderPreservingDictionary)) #'2023-09-10T02:21:15.931+02:00') )
]
