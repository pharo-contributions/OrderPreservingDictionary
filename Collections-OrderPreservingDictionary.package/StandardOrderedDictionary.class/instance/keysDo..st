enumerating
keysDo: aBlock
	"use to:do: for speed"
	1 to: self size do: [:i |
		aBlock value: (orderedKeys at: i)]