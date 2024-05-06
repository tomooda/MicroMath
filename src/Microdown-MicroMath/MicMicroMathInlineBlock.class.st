"
MicroMath adds to Microdown supports in simple text math expressions $=ax^{2}+bx+c=d=$.

Here are several examples:

#### Example 1
Code: `$=V_{i} = C_{0} - C_{3}=$`

$=V_{i} = C_{0} - C_{3}=$

#### Example 2
Code: `$=a^{2} + b^{2} = c^{2}=$`

$=a^{2} + b^{2} = c^{2}=$

#### Example 3
Code: `$={a}/{b} + {{c}/{d}}/{e}=$`

$={a}/{b} + {{c}/{d}}/{e}=$

"
Class {
	#name : 'MicMicroMathInlineBlock',
	#superclass : 'MicInlineElement',
	#instVars : [
		'keywords',
		'imagesAndTokens'
	],
	#category : 'Microdown-MicroMath-ModelInline',
	#package : 'Microdown-MicroMath',
	#tag : 'ModelInline'
}

{ #category : 'class initialization' }
MicMicroMathInlineBlock class >> initialize [

	MicInlineParser initialize.
	Delimiters
		add: MicMicroMathOpeningDelimiter markup;
		add: MicMicroMathClosingDelimiter markup
]

{ #category : 'visiting' }
MicMicroMathInlineBlock >> accept: aVisitor [
	^ aVisitor visitMicroMathInline: self
]

{ #category : 'operations' }
MicMicroMathInlineBlock >> cleanSubstring [

	
]

{ #category : 'accessing' }
MicMicroMathInlineBlock >> closingDelimiter [

 	^ '=$'
]

{ #category : 'defaults' }
MicMicroMathInlineBlock >> defaultKeywords [

	^ ({
		   ('{' -> #lbrace).
		   ('}' -> #rbrace).
		   ('_{' -> #suffix).
		   ('^{' -> #exponent).
		   ('}/{' -> #fraction) } asSortedCollection: [ :longer :shorter |
		   shorter key size <= longer key size ]) , { ('&pi;' -> 'π') }
		  asSortedCollection: [ :longer :shorter |
		  shorter key size <= longer key size ]
]

{ #category : 'rendering' }
MicMicroMathInlineBlock >> emptyImage [

	^ self imagePlain: ''
]

{ #category : 'accessing' }
MicMicroMathInlineBlock >> image [

	^ self process
		  mapColor: Color white to: Color transparent;
		  offset: 0 @ 0;
		  yourself
]

{ #category : 'rendering' }
MicMicroMathInlineBlock >> image: form1 concatenate: form2 [

	| rect1 rect2 left top bottom right form |
	rect1 := form1 offset extent: form1 extent.
	rect2 := form2 offset extent: form2 extent.
	left := rect1 left.
	right := rect1 right + form2 width.
	top := rect1 top min: rect2 top.
	bottom := rect1 bottom max: rect2 bottom.
	form := Form extent: right - left @ (bottom - top) depth: 32.
	form offset: left @ top.
	form getCanvas
		fillColor: Color transparent;
		paintImage: form1 at: form1 offset - (left @ top);
		paintImage: form2
		at: form2 offset - (left @ top) + (form1 width @ 0).
	^ form
]

{ #category : 'rendering' }
MicMicroMathInlineBlock >> image: form1 exponent: originalForm2 [

	| scale form2 rect1 rect2 left top bottom right form |
	scale := form1 height * 1.2 / originalForm2 height min: 0.8.
	form2 := originalForm2 magnifyBy: scale.
	rect1 := form1 offset extent: form1 extent.
	rect2 := originalForm2 offset * 0.6 + (0 @ rect1 top) extent:
		         form2 extent.
	form2 offset: rect2 origin.
	left := rect1 left.
	right := rect1 right + form2 width.
	top := rect1 top min: rect2 top.
	bottom := rect1 bottom max: rect2 bottom.
	form := Form extent: right - left @ (bottom - top) depth: 32.
	form offset: left @ top.
	form getCanvas
		fillColor: Color transparent;
		paintImage: form1 at: form1 offset - (left @ top);
		paintImage: form2
		at: form2 offset - (left @ top) + (form1 width @ 0).
	^ form
]

{ #category : 'rendering' }
MicMicroMathInlineBlock >> image: form1 fraction: form2 [

	| width1 height1 width2 height2 width gapHeight form |
	width1 := form1 width.
	height1 := form1 height.
	width2 := form2 width.
	height2 := form2 height.
	width := (width1 max: width2) + 4.
	gapHeight := 1.
	form := Form
		        extent: width @ (height1 + height2 + (gapHeight * 2) + 1)
		        depth: 32.
	form offset:
		0 @ (height1 + gapHeight + 1 + (TextStyle defaultFont ascent // 8))
			negated.
	form getCanvas
		fillColor: Color transparent;
		paintImage: form1 at: width - width1 // 2 @ 0;
		line: 0 @ (height1 + gapHeight)
		to: width @ (height1 + gapHeight)
		width: 1
		color: Color black;
		paintImage: form2
		at: width - width2 // 2 @ (height1 + gapHeight + 1 + gapHeight).
	^ form
]

{ #category : 'rendering' }
MicMicroMathInlineBlock >> image: form1 suffix: originalForm2 [

	| form2 rect1 rect2 left top bottom right form |
	form2 := originalForm2 magnifyBy: 0.8.
	rect1 := form1 offset extent: form1 extent.
	rect2 := originalForm2 offset * 0.8 + (0 @ rect1 bottom) extent:
		         form2 extent.
	form2 offset: rect2 origin.
	left := rect1 left.
	right := rect1 right + form2 width.
	top := rect1 top min: rect2 top.
	bottom := rect1 bottom max: rect2 bottom.
	form := Form extent: right - left @ (bottom - top) depth: 32.
	form offset: left @ top.
	form getCanvas
		fillColor: Color transparent;
		paintImage: form1 at: form1 offset - (left @ top);
		paintImage: form2
		at: form2 offset - (left @ top) + (form1 width @ 0).
	^ form
]

{ #category : 'rendering' }
MicMicroMathInlineBlock >> imagePlain: aString [

	^ aString
		  ifNotEmpty: [
			  ((aString asText addAttribute: TextEmphasis italic) asMorph
				   backgroundColor: Color white;
				   asForm)
				  offset: 0 @ TextStyle defaultFont ascent negated;
				  yourself ]
		  ifEmpty: [
			  (Form extent: 0 @ TextStyle defaultFont height depth: 32)
				  offset: 0 @ TextStyle defaultFont ascent negated;
				  yourself ]
]

{ #category : 'processing' }
MicMicroMathInlineBlock >> imagesAndTokens [

	^ imagesAndTokens ifNil: [
		  imagesAndTokens := self tokens collect: [ :stringOrSymbol |
			                     stringOrSymbol isSymbol
				                     ifTrue: [ stringOrSymbol ]
				                     ifFalse: [ self imagePlain: stringOrSymbol ] ] ]
]

{ #category : 'initialization' }
MicMicroMathInlineBlock >> initialize [

	super initialize.
	keywords := self defaultKeywords
]

{ #category : 'accessing' }
MicMicroMathInlineBlock >> kind [

 	^ #micromath
]

{ #category : 'accessing' }
MicMicroMathInlineBlock >> openingDelimiter [

 	^ '$='
]

{ #category : 'processing' }
MicMicroMathInlineBlock >> process [

	self processStrings.
	[ self processOne ] whileTrue.
	^ imagesAndTokens detect: #isForm ifNone: [ self emptyImage ]
]

{ #category : 'processing' }
MicMicroMathInlineBlock >> processBrace [
	"replace (#lbrace image #rbrace) pattern in imagesAndTokens with image and answers true if applied"

	1 to: imagesAndTokens size - 2 do: [ :index |
		((imagesAndTokens at: index) = #lbrace and: [
			 (imagesAndTokens at: index + 1) isForm and: [
				 (imagesAndTokens at: index + 2) = #rbrace ] ]) ifTrue: [
			imagesAndTokens := (imagesAndTokens first: index - 1)
			                   , { (imagesAndTokens at: index + 1) }
			                   , (imagesAndTokens allButFirst: index + 2).
			^ true ] ].
	^ false
]

{ #category : 'processing' }
MicMicroMathInlineBlock >> processConcatenate [
	"replace (image image) pattern in imagesAndTokens with the concatenated image and answers true if applied"

	1 to: imagesAndTokens size - 1 do: [ :index |
		| image1 image2 |
		image1 := imagesAndTokens at: index.
		image2 := imagesAndTokens at: index + 1.
		(image1 isForm and: [ image2 isForm ]) ifTrue: [
			imagesAndTokens := (imagesAndTokens first: index - 1)
			                   , { (self image: image1 concatenate: image2) }
			                   , (imagesAndTokens allButFirst: index + 1).
			^ true ] ].
	^ false
]

{ #category : 'processing' }
MicMicroMathInlineBlock >> processExponent [
	"replace (image #exponent image) pattern in imagesAndTokens with image and answers true if applied"

	1 to: imagesAndTokens size - 3 do: [ :index |
		| image1 exponent image2 rbrace |
		image1 := imagesAndTokens at: index.
		exponent := imagesAndTokens at: index + 1.
		image2 := imagesAndTokens at: index + 2.
		rbrace := imagesAndTokens at: index + 3.
		(image1 isForm and: [
			 exponent = #exponent and: [
				 image2 isForm and: [ rbrace = #rbrace ] ] ]) ifTrue: [
			imagesAndTokens := (imagesAndTokens first: index - 1)
			                   , { (self image: image1 exponent: image2) }
			                   , (imagesAndTokens allButFirst: index + 3).
			^ true ] ].
	^ false
]

{ #category : 'processing' }
MicMicroMathInlineBlock >> processFraction [
	"replace (#lbrace image #exponent image #rbrace) pattern in imagesAndTokens with image and answers true if applied"

	1 to: imagesAndTokens size - 4 do: [ :index |
		| lbrace image1 fraction image2 rbrace |
		lbrace := imagesAndTokens at: index.
		image1 := imagesAndTokens at: index + 1.
		fraction := imagesAndTokens at: index + 2.
		image2 := imagesAndTokens at: index + 3.
		rbrace := imagesAndTokens at: index + 4.
		(lbrace = #lbrace and: [
			 image1 isForm and: [
				 fraction = #fraction and: [
					 image2 isForm and: [ rbrace = #rbrace ] ] ] ]) ifTrue: [
			imagesAndTokens := (imagesAndTokens first: index - 1)
			                   , { (self image: image1 fraction: image2) }
			                   , (imagesAndTokens allButFirst: index + 4).
			^ true ] ].
	^ false
]

{ #category : 'processing' }
MicMicroMathInlineBlock >> processOne [

	^ self processBrace or: [
		  self processSuffix or: [
			  self processExponent or: [
				  self processFraction or: [ self processConcatenate ] ] ] ]
]

{ #category : 'processing' }
MicMicroMathInlineBlock >> processStrings [

	imagesAndTokens := self tokens collect: [ :stringOrSymbol |
		                   stringOrSymbol isSymbol
			                   ifTrue: [ stringOrSymbol ]
			                   ifFalse: [ self imagePlain: stringOrSymbol ] ]
]

{ #category : 'processing' }
MicMicroMathInlineBlock >> processSuffix [
	"replace (image #suffix image) pattern in imagesAndTokens with image and answers true if applied"

	1 to: imagesAndTokens size - 3 do: [ :index |
		| image1 suffix image2 rbrace |
		image1 := imagesAndTokens at: index.
		suffix := imagesAndTokens at: index + 1.
		image2 := imagesAndTokens at: index + 2.
		rbrace := imagesAndTokens at: index + 3.
		(image1 isForm and: [
			 suffix = #suffix and: [ image2 isForm and: [ rbrace = #rbrace ] ] ])
			ifTrue: [
				imagesAndTokens := (imagesAndTokens first: index - 1)
				                   , { (self image: image1 suffix: image2) }
				                   , (imagesAndTokens allButFirst: index + 3).
				^ true ] ].
	^ false
]

{ #category : 'processing' }
MicMicroMathInlineBlock >> processToken: aStringOrSymbol image: aForm [

	aStringOrSymbol = #lbrace ifTrue: [
		^ self image: aForm concatenate: self processBrace ].
	aStringOrSymbol = #rbrace ifTrue: [ ^ aForm ].
	aStringOrSymbol = #fraction ifTrue: [
		^ self image: aForm fraction: self processBrace ].
	aStringOrSymbol = #suffix ifTrue: [
		^ self image: aForm suffix: self processBrace ].
	aStringOrSymbol = #exponent ifTrue: [
		^ self image: aForm exponent: self processBrace ].
	aStringOrSymbol isSymbol ifFalse: [
		^ self image: aForm concatenate: (self imagePlain: aStringOrSymbol) ].
	^ aForm
]

{ #category : 'processing' }
MicMicroMathInlineBlock >> removeEscape: aString [

	^ aString isSymbol
		  ifTrue: [ aString ]
		  ifFalse: [
			  String streamContents: [ :writeStream |
				  aString readStreamDo: [ :readStream |
					  [ readStream atEnd ] whileFalse: [
						  writeStream nextPutAll: (readStream upTo: $\) ] ] ] ]
]

{ #category : 'processing' }
MicMicroMathInlineBlock >> tokenize: aString with: anotherString token: aSymbol into: aStream [

	| lastIndex index |
	lastIndex := 1.
	index := 0.
	[
	index := aString findString: anotherString startingAt: index + 1.
	index > 0 ] whileTrue: [
		(index > 1 and: [ (aString at: index - 1) = $\ ]) not ifTrue: [
			lastIndex < index ifTrue: [
				(aString copyFrom: lastIndex to: index - 1) ifNotEmpty: [ :string |
					aStream nextPut: string ] ].
			aStream nextPut: aSymbol.
			lastIndex := index + anotherString size ] ].
	(aString copyFrom: lastIndex to: aString size) ifNotEmpty: [ :string |
		aStream nextPut: string ]
]

{ #category : 'processing' }
MicMicroMathInlineBlock >> tokens [

	^ (keywords inject: { self substring } into: [ :array :assoc |
		   | substr token |
		   substr := assoc key.
		   token := assoc value.
		   Array streamContents: [ :stream |
			   array do: [ :stringOrToken |
				   stringOrToken isSymbol
					   ifTrue: [ stream nextPut: stringOrToken ]
					   ifFalse: [
						   self
							   tokenize: stringOrToken
							   with: substr
							   token: token
							   into: stream ] ] ] ]) collect: [ :stringOrToken |
		  stringOrToken isSymbol
			  ifTrue: [ stringOrToken ]
			  ifFalse: [ self removeEscape: stringOrToken ] ]
]
