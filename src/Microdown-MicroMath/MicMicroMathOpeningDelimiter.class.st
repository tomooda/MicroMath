"
I'm a delimiter for math inline. An example is $V_i = C_0 - C_3$.
I delimits `MicMathInlineBlock`.
"
Class {
	#name : 'MicMicroMathOpeningDelimiter',
	#superclass : 'MicAbstractDelimiter',
	#category : 'Microdown-MicroMath-Parser',
	#package : 'Microdown-MicroMath',
	#tag : 'Parser'
}

{ #category : 'accessing' }
MicMicroMathOpeningDelimiter class >> associatedInlineBlock [

	^ MicMicroMathInlineBlock
]

{ #category : 'accessing' }
MicMicroMathOpeningDelimiter class >> isCloser [

	^ false
]

{ #category : 'accessing' }
MicMicroMathOpeningDelimiter class >> isOpener [

	^ true
]

{ #category : 'accessing' }
MicMicroMathOpeningDelimiter class >> markup [
	^ '$='
]

{ #category : 'accessing' }
MicMicroMathOpeningDelimiter class >> type [

	^ #micromath
]
