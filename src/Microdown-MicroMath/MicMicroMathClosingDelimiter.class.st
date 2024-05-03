"
I'm a delimiter for math inline. An example is $V_i = C_0 - C_3$.
I delimits `MicMathInlineBlock`.
"
Class {
	#name : 'MicMicroMathClosingDelimiter',
	#superclass : 'MicAbstractDelimiter',
	#category : 'Microdown-MicroMath-Parser',
	#package : 'Microdown-MicroMath',
	#tag : 'Parser'
}

{ #category : 'accessing' }
MicMicroMathClosingDelimiter class >> associatedInlineBlock [

	^ MicMicroMathInlineBlock
]

{ #category : 'accessing' }
MicMicroMathClosingDelimiter class >> isCloser [

	^ true
]

{ #category : 'accessing' }
MicMicroMathClosingDelimiter class >> isOpener [

	^ false
]

{ #category : 'accessing' }
MicMicroMathClosingDelimiter class >> markup [
	^ '=$'
]

{ #category : 'accessing' }
MicMicroMathClosingDelimiter class >> type [

	^ #micromath
]
