Class {
	#name : 'MicMicroMathInlineBlockTest',
	#superclass : 'TestCase',
	#category : 'Microdown-MicroMath-Tests',
	#package : 'Microdown-MicroMath',
	#tag : 'Tests'
}

{ #category : 'tests' }
MicMicroMathInlineBlockTest >> testTokenizeWithTokenInto [

	| micromath |
	micromath := MicMicroMathInlineBlock new.
	self
		assert: (Array streamContents: [ :stream |
				 micromath
					 tokenize: '/-//-/abc/-/def/-/'
					 with: '/-/'
					 token: #t
					 into: stream ])
		equals: #( t t 'abc' t 'def' t ).
	self
		assert: (Array streamContents: [ :stream |
				 micromath
					 tokenize: '\/-//-/abc/\-/def\/-/'
					 with: '/-/'
					 token: #t
					 into: stream ])
		equals: #( '\/-/' t 'abc/\-/def\/-/' )
]

{ #category : 'tests' }
MicMicroMathInlineBlockTest >> testTokens [

	| micromath |
	micromath := MicMicroMathInlineBlock new.
	micromath substring: 'abc{def}/{x\{yz}'.
	self assert: micromath substring equals: 'abc{def}/{x\{yz}'.
	self
		assert: micromath tokens
		equals: { 'abc'. #lbrace. 'def'. #fraction. 'x{yz'. #rbrace }
]
