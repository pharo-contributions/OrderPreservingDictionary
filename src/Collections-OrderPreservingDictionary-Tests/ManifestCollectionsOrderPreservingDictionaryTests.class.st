"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCollectionsOrderPreservingDictionaryTests,
	#superclass : #PackageManifest,
	#category : #'Collections-OrderPreservingDictionary-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestCollectionsOrderPreservingDictionaryTests class >> ruleRBCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#OrderPreservingStringDictionaryTest #testAssociationAt #false)) #'2019-10-30T00:19:04.368257+01:00') #(#(#RGPackage #(#'Collections-OrderPreservingDictionary-Tests')) #'2019-10-30T00:21:02.013257+01:00') )
]

{ #category : #'code-critics' }
ManifestCollectionsOrderPreservingDictionaryTests class >> ruleRBUsesAddRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'Collections-OrderPreservingDictionary-Tests')) #'2019-10-30T00:21:13.902257+01:00') )
]
