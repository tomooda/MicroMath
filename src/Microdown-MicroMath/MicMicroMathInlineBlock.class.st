"
Microdown supports in text math expression as in LaTeX using `$ 1 + 2 $`. Each exporter is then responsible to map the contents to the correct output. For PDF based on LaTeX mathInlineBlock can contain LaTeX, for HTML we expect the same using corresponding math library in JS.

Here are several examples:

#### Example 1
Code: `$V_i = C_0 - C_3$`

$V_i = C_0 - C_3$

#### Example 2
Code: `$a^2 + b^2 = c^2$`

$a^2 + b^2 = c^2$

#### Example 3
Code: `$\sin(x) = \sum_{n=0}^{\infty} \frac{(-1)^{n}x^{2n+1}}{(2n+1)!}$`

$\sin(x) = \sum_{n=0}^{\infty} \frac{(-1)^{n}x^{2n+1}}{(2n+1)!}$

#### Example 4
Code: `$f(a) = \frac{1}{2\pi i} \oint_{\gamma} \frac{f(z)}{z - a} dz$`

$f(a) = \frac{1}{2\pi i} \oint_{\gamma} \frac{f(z)}{z - a} dz$

"
Class {
	#name : 'MicMicroMathInlineBlock',
	#superclass : 'MicInlineElement',
	#instVars : [
		'keywords',
		'tokenStream'
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
	form offset: 0 @ (height1 + gapHeight + 1) negated.
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
	form2 := originalForm2 magnifyBy: 0.7.
	rect1 := form1 offset extent: form1 extent.
	rect2 := originalForm2 offset * 0.7 + (0 @ rect1 bottom) extent:
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
			  (((aString asText addAttribute: TextEmphasis italic) asMorph
				    backgroundColor: Color white;
				    asForm) collectColors: [ :c |
				   c = Color white
					   ifTrue: [ Color transparent ]
					   ifFalse: [ c ] ])
				  offset: 0 @ TextStyle defaultFont ascent negated;
				  yourself ]
		  ifEmpty: [
			  (Form extent: 0 @ TextStyle defaultFont height depth: 32)
				  offset: 0 @ TextStyle defaultFont ascent negated;
				  yourself ]
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

	| image |
	image := self emptyImage.
	[ self tokenStream atEnd ] whileFalse: [
		image := self processToken: self tokenStream next image: image ].
	^ image
]

{ #category : 'processing' }
MicMicroMathInlineBlock >> processBrace [

	| image |
	image := self emptyImage.
	[ self tokenStream atEnd ] whileFalse: [
		| token |
		token := self tokenStream next.
		token = #rbrace ifTrue: [ ^ image ].
		token = #fraction ifTrue: [
			| image2 |
			image2 := self processBrace.
			^ self image: image fraction: image2 ].
		image := self processToken: token image: image ].
	^ image
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
MicMicroMathInlineBlock >> tokenStream [

	^ tokenStream ifNil: [ tokenStream := self tokens readStream ]
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
