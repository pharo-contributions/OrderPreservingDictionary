"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCollectionsOrderPreservingDictionaryTests,
	#superclass : #PackageManifest,
	#category : #'Collections-OrderPreservingDictionary-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestCollectionsOrderPreservingDictionaryTests class >> ruleCollectionProtocolRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#OrderPreservingDictionaryTest #testKeyAtValue #false)) #'2023-09-10T01:59:15.221+02:00') #(#(#RGMethodDefinition #(#OrderPreservingDictionaryTest #testKeyAtIdentityValue #false)) #'2023-09-10T01:59:27.185+02:00') #(#(#RGMethodDefinition #(#OrderPreservingDictionaryTest #testAt #false)) #'2023-09-10T01:59:36.666+02:00') #(#(#RGMethodDefinition #(#OrderPreservingDictionaryTest #testAssociationAt #false)) #'2023-09-10T01:59:45.236+02:00') #(#(#RGMethodDefinition #(#StandardOrderedDictionaryTest #testKeyForIdentity #false)) #'2023-09-10T02:00:21.727+02:00') #(#(#RGMethodDefinition #(#StandardOrderedDictionaryTest #testKeyAtValueIfAbsent #false)) #'2023-09-10T02:00:26.851+02:00') #(#(#RGMethodDefinition #(#StandardOrderedDictionaryTest #testKeyAtValue #false)) #'2023-09-10T02:00:31.282+02:00') #(#(#RGMethodDefinition #(#StandardOrderedDictionaryTest #testKeyAtIdentityValueIfAbsent #false)) #'2023-09-10T02:00:39.288+02:00') #(#(#RGMethodDefinition #(#StandardOrderedDictionaryTest #testKeyAtIdentityValue #false)) #'2023-09-10T02:00:45.515+02:00') #(#(#RGMethodDefinition #(#StandardOrderedDictionaryTest #testIncludesKey #false)) #'2023-09-10T02:01:42.251+02:00') #(#(#RGMethodDefinition #(#StandardOrderedDictionaryTest #testIncludesIdentity #false)) #'2023-09-10T02:01:46.79+02:00') #(#(#RGMethodDefinition #(#StandardOrderedDictionaryTest #testIncludesAssociation #false)) #'2023-09-10T02:01:51.471+02:00') #(#(#RGMethodDefinition #(#StandardOrderedDictionaryTest #testIncludes #false)) #'2023-09-10T02:01:56.92+02:00') #(#(#RGMethodDefinition #(#StandardOrderedDictionaryTest #testHashOtherOrderPreservingDictionaries #false)) #'2023-09-10T02:02:06.054+02:00') #(#(#RGMethodDefinition #(#StandardOrderedDictionaryTest #testHash #false)) #'2023-09-10T02:02:32.353+02:00') )
]

{ #category : #'code-critics' }
ManifestCollectionsOrderPreservingDictionaryTests class >> ruleLiteralArrayContainsSuspiciousTrueFalseOrNilRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMetaclassDefinition #(#'ManifestCollectionsOrderPreservingDictionaryTests class' #ManifestCollectionsOrderPreservingDictionaryTests)) #'2023-09-10T02:20:05.099+02:00') )
]

{ #category : #'code-critics' }
ManifestCollectionsOrderPreservingDictionaryTests class >> ruleModifiesCollectionRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#StandardOrderedDictionaryTest #testSelect #false)) #'2023-09-10T02:00:09.493+02:00') #(#(#RGMethodDefinition #(#StandardOrderedDictionaryTest #testAssociationsSelect #false)) #'2023-09-10T02:03:29.017+02:00') )
]

{ #category : #'code-critics' }
ManifestCollectionsOrderPreservingDictionaryTests class >> ruleRBCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#OrderPreservingStringDictionaryTest #testAssociationAt #false)) #'2019-10-30T00:19:04.368257+01:00') #(#(#RGPackage #(#'Collections-OrderPreservingDictionary-Tests')) #'2019-10-30T00:21:02.013257+01:00') )
]

{ #category : #'code-critics' }
ManifestCollectionsOrderPreservingDictionaryTests class >> ruleRBUsesAddRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'Collections-OrderPreservingDictionary-Tests')) #'2019-10-30T00:21:13.902257+01:00') )
]

{ #category : #'code-critics' }
ManifestCollectionsOrderPreservingDictionaryTests class >> ruleUsesAddRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#StandardOrderedDictionaryTest #testAdd #false)) #'2023-09-10T01:54:36.325+02:00') #(#(#RGMethodDefinition #(#StandardOrderedDictionaryTest #testAddAll #false)) #'2023-09-10T01:54:52.176+02:00') )
]
