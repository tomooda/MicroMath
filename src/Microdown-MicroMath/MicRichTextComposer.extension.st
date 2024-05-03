Extension { #name : 'MicRichTextComposer' }

{ #category : '*Microdown-MicroMath' }
MicRichTextComposer >> visitMicroMathInline: aMicMicroMathInline [

	| image |
	image := aMicMicroMathInline image.
	canvas << (self
		 textWithImage: image
		 usingAnchor: (TextAnchor new anchoredMorph: image))
]
