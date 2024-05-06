Class {
	#name : 'BaselineOfMicroMath',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfMicroMath',
	#package : 'BaselineOfMicroMath'
}

{ #category : 'baselines' }
BaselineOfMicroMath >> baseline: spec [

	<baseline>
	spec package: #'Microdown-MicroMath'.
	spec
		group: 'Core' with: #( 'Microdown-MicroMath' );
		group: 'default' with: #( 'Core' );
		group: 'All' with: #( 'Core' )
]
