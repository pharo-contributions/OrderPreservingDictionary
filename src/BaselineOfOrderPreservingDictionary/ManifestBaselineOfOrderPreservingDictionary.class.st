"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestBaselineOfOrderPreservingDictionary,
	#superclass : #PackageManifest,
	#category : #'BaselineOfOrderPreservingDictionary-Manifest'
}

{ #category : #'code-critics' }
ManifestBaselineOfOrderPreservingDictionary class >> ruleClassNotReferencedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#BaselineOfOrderPreservingDictionary)) #'2023-09-10T01:50:19.337+02:00') )
]
