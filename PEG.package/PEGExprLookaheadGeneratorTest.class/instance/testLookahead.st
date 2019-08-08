as yet unclassified
testLookahead
	| stringGenerator lookaheadGenerator parser parseString parseResult |
	stringGenerator := PEGExprStringGenerator newString: 'matchstring'.
	lookaheadGenerator := PEGExprLookaheadGenerator new: stringGenerator.

	lookaheadGenerator compile: #rule into: parserClass.
	parser := parserClass new.
	parseString := '123matchstring'.
	
	parseResult := parser perform: #parse_rule:atPos: withArguments: {parseString . 1}.
	self assert: parseResult equals: nil.
	parseResult := parser perform: #parse_rule:atPos: withArguments: {parseString . 2}.
	self assert: parseResult equals: nil.
	parseResult := parser perform: #parse_rule:atPos: withArguments: {parseString . 4}.
	self assert: parseResult startPos equals: 4.
	self assert: parseResult endPos equals: 4.
	parseResult := parser perform: #parse_rule:atPos: withArguments: {parseString . 5}.
	self assert: parseResult equals: nil.