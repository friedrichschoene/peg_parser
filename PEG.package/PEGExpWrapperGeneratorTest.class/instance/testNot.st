as yet unclassified
testNot
	| stringGenerator notGenerator parser parseString parseResult |
	
	stringGenerator := PEGExprStringGenerator newString: 'matchstring'.
	notGenerator := PEGExprNotGenerator new: stringGenerator.

	notGenerator compile: #parse_rule into: parserClass.

	parser := parserClass new.
	parseString := '123matchstring'.
	
	"prepare parser for parsing"
	parser instVarAt: 1 put: parseString. "string"
	parser instVarAt: 5 put: (PEGParserFailure newAt: 0). "rightmostFailure"
	
	
	parseResult := parser perform: #parse_rule: with: 1.
	self assert: parseResult startPos equals: 1.
	self assert: parseResult endPos equals: 1.
	parseResult := parser perform: #parse_rule: with: 2.
	self assert: parseResult startPos equals: 2.
	self assert: parseResult endPos equals: 2.
	parseResult := parser perform: #parse_rule: with: 4.
	self assert: parseResult equals: nil.
	parseResult := parser perform: #parse_rule: with: 5.
	self assert: parseResult startPos equals: 5.
	self assert: parseResult endPos equals: 5.