parsing
parse: parseString startingFrom: ruleName
	| methodSignature parseResult |
	string := parseString.
	memoization := (1 to: parseString size + 1) collect: [:index | IdentityDictionary new].
	heads := Array new: parseString size + 1.
	leftRecursionStack := LinkedList new.
	rightmostFailure := PEGParserFailure newAt: 0.
	
	methodSignature := ('apply_' , ruleName , ':') asSymbol.
	parseResult := self perform: methodSignature with: 1.


	parseResult == nil ifFalse: [
		(parseResult endPos == (string size + 1) or: [(self skipSpaces: parseResult endPos) == (string size + 1)]) ifTrue: [
			^ PEGMatchResult new
				cst: parseResult;
				yourself]].
		
	^ PEGFailedMatchResult new
		cst: parseResult;
		failure: self rightmostFailure;
		yourself