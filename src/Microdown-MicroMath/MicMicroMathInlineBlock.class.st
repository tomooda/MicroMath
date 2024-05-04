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
		'symbols'
	],
	#category : 'Microdown-MicroMath-ModelInline',
	#package : 'Microdown-MicroMath',
	#tag : 'ModelInline'
}

{ #category : 'class initialization' }
MicMicroMathInlineBlock class >> initialize [

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
MicMicroMathInlineBlock >> defaultSymbols [

	^ {
		  ('{' -> #lbrace).
		  ('}' -> #rbrace).
		  ('_' -> #suffix).
		  ('^' -> #exponent).
		  ('}/{' -> #fraction).
		  ('&pi;' -> 'π') } asSortedCollection: [ :longer :shorter |
		  shorter key size <= longer key size ]
]

{ #category : 'accessing' }
MicMicroMathInlineBlock >> image [

	| text |
	text := substring asText addAttribute: TextEmphasis italic.
	^ text asMorph asForm
]

{ #category : 'processing' }
MicMicroMathInlineBlock >> imageFromString: aString [

	| text |
	text := aString asText addAttribute: TextEmphasis italic.
	^ text asMorph
		  backgroundColor: Color yellow;
		  asForm
]

{ #category : 'initialization' }
MicMicroMathInlineBlock >> initialize [

	super initialize.
	symbols := self defaultSymbols
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
MicMicroMathInlineBlock >> tokenize: aString with: anotherString token: aSymbol into: aStream [

	| lastIndex index |
	lastIndex := index := 1.
	[
	index := aString findString: anotherString startingAt: lastIndex.
	index > 0 ] whileTrue: [
		(index + anotherString size - 1 <= aString size and: [
			 (1 to: anotherString size) allSatisfy: [ :i |
				 (aString at: index + i - 1) = (anotherString at: i) ] ]) ifTrue: [
			(aString copyFrom: lastIndex to: index - 1) ifNotEmpty: [ :string |
				aStream nextPut: string ].
			aStream nextPut: aSymbol.
			lastIndex := index + anotherString size ] ].
	(aString copyFrom: lastIndex to: aString size) ifNotEmpty: [ :string |
		aStream nextPut: string ]
]
