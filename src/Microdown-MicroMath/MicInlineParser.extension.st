Extension { #name : 'MicInlineParser' }

{ #category : '*Microdown-MicroMath' }
MicInlineParser >> identifyMarkupFor: aString [

	(self class keyBeginSet includes: aString first) ifFalse: [ ^ 1 ].
	keys ifNotEmpty: [
		(keys collect: #size) max to: 1 by: -1 do: [ :l |
			keys do: [ :key |
				(key size = l and: [ aString beginsWith: key ]) ifTrue: [
					delimiterClass := allDelimiters at: key.
					self delimiterFoundProcess.
					^ key size ] ] ] ].
	^ 1
]
