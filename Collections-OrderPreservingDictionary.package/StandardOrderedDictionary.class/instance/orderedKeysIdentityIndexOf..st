private
orderedKeysIdentityIndexOf: aKey
	"GS does not have #identityIndexOf:"
	1 to: orderedKeys size do: [:i |
		(orderedKeys at: i) == aKey
			ifTrue: [^ i]].
	^ 0.