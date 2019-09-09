as yet unclassified
methodBodyMock
	^ '| skipPos currentPos currentResult children |
	currentPos := pos.
	children := OrderedCollection new.
	[
		skipPos := self skipSpaces: string atPos: currentPos.
		currentResult := self {1}: string atPos: skipPos.
		currentResult ifNotNil: [
			currentPos := currentResult endPos.
			children add: currentResult]
	] doWhileTrue: [(currentResult == nil) not].

	^ PEGAbstractSyntaxTreeNode new
		rule: #zeroOrMore;
		startPos: pos;
		endPos: currentPos;
		children: (children collect: #nodeList) flatten;
		yourself'