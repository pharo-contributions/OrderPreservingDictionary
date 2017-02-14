"
(ConfigurationOfOrderPreservingDictionary project version: #stable) load

(ConfigurationOfOrderPreservingDictionary project version: #stable) load: #('Tests')
"
Class {
	#name : #ConfigurationOfOrderPreservingDictionary,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfOrderPreservingDictionary
}

{ #category : #'development support' }
ConfigurationOfOrderPreservingDictionary class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>
]

{ #category : #private }
ConfigurationOfOrderPreservingDictionary class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #'ConfigurationOf'
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #'ConfigurationOf' ifAbsent: aBlock ].
]

{ #category : #catalog }
ConfigurationOfOrderPreservingDictionary class >> catalogDescription [

^ 'This package has two ordered dictionary classes that behave like OrderedDictionary and OrderedIdentityDictionary in Pharo but are portable to Squeak and Gemstone, and other ordered dictionary classes needed by XMLParser.'
]

{ #category : #catalog }
ConfigurationOfOrderPreservingDictionary class >> catalogKeywords [
	^ #( collection dictionary ordered #'order-preserving' )
]

{ #category : #catalog }
ConfigurationOfOrderPreservingDictionary class >> catalogLicense [
	^ 'The MIT License (MIT)

Copyright (c) 2016 PharoExtras Team.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.'
]

{ #category : #private }
ConfigurationOfOrderPreservingDictionary class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfOrderPreservingDictionary class >> ensureMetacelloBaseConfiguration [
  Smalltalk
    at: #'ConfigurationOf'
    ifAbsent: [ 
      | repository version |
      repository := MCHttpRepository
        location: 'http://smalltalkhub.com/mc/dkh/metacello/main'
        user: ''
        password: ''.
      repository
        versionReaderForFileNamed: 'Metacello-Base-dkh.107'
        do: [ :reader | 
          version := reader version.
          version load.
          version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfOrderPreservingDictionary class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfOrderPreservingDictionary class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfOrderPreservingDictionary class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfOrderPreservingDictionary class >> loadDefault [
	"self loadDefault"

	^ self loadMostRecentCoreWithTests
]

{ #category : #loading }
ConfigurationOfOrderPreservingDictionary class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #loading }
ConfigurationOfOrderPreservingDictionary class >> loadMostRecentCoreWithTests [
	^self project lastVersion load: #('Core' 'Tests')
]

{ #category : #accessing }
ConfigurationOfOrderPreservingDictionary class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfOrderPreservingDictionary class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfOrderPreservingDictionary >> baseline100: spec [ 
	<version: '1.0-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://smalltalkhub.com/mc/PharoExtras/OrderPreservingDictionary/main'.	
		spec description: 'Imported from SqueakSource'.
		spec package: 'Collections-OrderPreservingDictionary'.
		spec 
			package: 'Collections-Tests-OrderPreservingDictionary' 
			with: [spec requires: 'Collections-OrderPreservingDictionary'].
			
		spec
			group: 'default' with: #('Core');
			group: 'Core' with: #('Collections-OrderPreservingDictionary');
			group: 'Tests' with: #('Collections-Tests-OrderPreservingDictionary'). ].
		
	"loads gemstone compatibility methods"
	spec
		for: #gemstone
		do: [
			spec
				package: 'Collections-OrderPreservingDictionary'
				with: [ spec includes: 'Collections-OrderPreservingDictionary-GemstoneCompatibility' ].
			spec
				package: 'Collections-OrderPreservingDictionary-GemstoneCompatibility'
				with: [ spec requires: 'Collections-OrderPreservingDictionary' ] ].

	"load GT extensions"
	spec
		for: #gt
		do: [
			spec
				package: 'Collections-OrderPreservingDictionary'
				with: [ spec includes: 'Collections-OrderPreservingDictionary-GTExtensions' ].
			spec
				package: 'Collections-OrderPreservingDictionary-GTExtensions'
				with: [ spec requires: 'Collections-OrderPreservingDictionary' ] ].
]

{ #category : #baselines }
ConfigurationOfOrderPreservingDictionary >> baseline131: spec [
	<version: '1.3.1-baseline' imports: #('1.0-baseline')>
	spec
		for: #gemstone
		do: [
			spec blessing: #baseline.
			spec
				package: 'Collections-OrderPreservingDictionary-GemstoneCompatibility'
				with: 'Collections-OrderPreservingDictionary-GemstoneCompatibility-monty.1' ].
	spec
		for: #gt
		do: [
			spec
				package: 'Collections-OrderPreservingDictionary-GTExtensions'
				with: 'Collections-OrderPreservingDictionary-GTExtensions-monty.1' ]
]

{ #category : #accessing }
ConfigurationOfOrderPreservingDictionary >> customProjectAttributes [
    "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes "

	(Smalltalk includesKey: #GTInspector)
		ifTrue: [ ^ #(gt) ]
		ifFalse: [ ^ #() ]
]

{ #category : #'symbolic versions' }
ConfigurationOfOrderPreservingDictionary >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '1.3.1-baseline'.

]

{ #category : #accessing }
ConfigurationOfOrderPreservingDictionary >> project [
    ^ project
        ifNil: [ 
            "Bootstrap Metacello if it is not already loaded"
            self class ensureMetacello.
            project := MetacelloMCProject new projectAttributes: self customProjectAttributes.	"Create the Metacello project"
            (Smalltalk at: #'MetacelloVersionConstructor') on: self project: project.	"Construct the project"
            project loadType: #'linear'.	"change to #atomic if desired"
            project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfOrderPreservingDictionary >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.3.6'.

]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version100: spec [ 
	<version: '1.0' imports: #('1.0-baseline') >
	
	spec for: #common do: [
		spec blessing: #release.
		spec description: 'Latest versions from Squeaksource'.
		
		spec package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-JAA.7'.
		spec package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-JAAyer.7'
		]
	


]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version110: spec [ 
	<version: '1.1' imports: #('1.0-baseline') >
	
	spec for: #common do: [
		spec blessing: #release.
		
		spec package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-monty.9'.
		spec package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-JAAyer.7'
		]
	


]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version120: spec [
	<version: '1.2' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #release.
		spec description: 'version 1.2'.
		spec author: 'GuillaumeLarcheveque'.
		spec timestamp: '6/27/2014 16:03'.
		spec 
			package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-monty.9';
			package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-JAAyer.7'. ].

]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version121: spec [
	<version: '1.2.1' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #release.
		spec 
			package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-monty.10';
			package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-JAAyer.7'. ].

]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version122: spec [
	<version: '1.2.2' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #release.
		spec 
			package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-monty.12';
			package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-monty.9'. ].

]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version123: spec [
	<version: '1.2.3' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #release.
		spec 
			package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-monty.13';
			package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-monty.10'. ].

]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version124: spec [
	<version: '1.2.4' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #release.
		spec 
			package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-monty.15';
			package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-monty.10'. ].

]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version125: spec [
	<version: '1.2.5' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #release.
		spec 
			package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-monty.16';
			package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-monty.11'. ].

]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version126: spec [ 
        <version: '1.2.6' imports: #('1.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-monty.17'.
			spec package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-monty.12'.
                ].
]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version127: spec [ 
        <version: '1.2.7' imports: #('1.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-monty.18'.
			spec package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-monty.12'.
                ].
]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version128: spec [ 
        <version: '1.2.8' imports: #('1.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-monty.19'.
			spec package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-monty.13'.
                ].
]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version129: spec [ 
        <version: '1.2.9' imports: #('1.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-monty.20'.
			spec package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-monty.14'.
                ].
]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version130: spec [ 
	<version: '1.3.0' imports: #('1.0-baseline')>

	spec for: #common do: [
		spec blessing: #release.
		spec package: 'Collections-OrderPreservingDictionary' with: 			'Collections-OrderPreservingDictionary-monty.21'.
		spec package: 'Collections-Tests-OrderPreservingDictionary' with: 			'Collections-Tests-OrderPreservingDictionary-monty.14']
]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version131: spec [ 
	<version: '1.3.1' imports: #('1.3.1-baseline')>

	spec for: #common do: [
		spec blessing: #release.
		spec
			package: 'Collections-OrderPreservingDictionary'
			with: 'Collections-OrderPreservingDictionary-monty.22'.
		spec
			package: 'Collections-Tests-OrderPreservingDictionary'
			with: 'Collections-Tests-OrderPreservingDictionary-monty.15'. ].
]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version132: spec [ 
        <version: '1.3.2' imports: #('1.3.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-monty.22'.
			spec package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-monty.16'.
                ].
]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version133: spec [ 
        <version: '1.3.3' imports: #('1.3.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-monty.23'.
			spec package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-monty.17'.
                ].
]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version134: spec [ 
        <version: '1.3.4' imports: #('1.3.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-monty.24'.
			spec package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-monty.18'.
                ].
]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version135: spec [ 
        <version: '1.3.5' imports: #('1.3.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-monty.25'.
			spec package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-monty.20'.
                ].
]

{ #category : #versions }
ConfigurationOfOrderPreservingDictionary >> version136: spec [ 
        <version: '1.3.6' imports: #('1.3.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'Collections-OrderPreservingDictionary' with: 'Collections-OrderPreservingDictionary-monty.30'.
			spec package: 'Collections-Tests-OrderPreservingDictionary' with: 'Collections-Tests-OrderPreservingDictionary-monty.25'.
                ].
]
