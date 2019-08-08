as yet unclassified
methodBodyMockWith: childCount
	| headerCode elementCode footerCode code |
	headerCode := '| currentPos currentResult children |
	currentPos := pos.
	children := OrderedCollection new: ' , childCount , '.'.
	elementCode := 'currentResult := self parse_{1}: string atPos: currentPos.
	currentResult
		ifNil: [^ nil]
		ifNotNil: [
			currentPos := currentResult endPos.
			children add: currentResult].'.
	footerCode := '^ PEGShadowAbstractSyntaxTreeNode new
		rule: #sequence;
		startPos: pos;
		endPos: currentPos;
		children: children;
		yourself'.

	code := headerCode , Character lf , Character lf.
	1 to: childCount do: [:index | code := code , (elementCode format: {'{' , index , '}'}) , Character lf , Character lf].
	code := code , footerCode.
	
	^ code