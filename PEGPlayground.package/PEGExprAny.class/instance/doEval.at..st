as yet unclassified
doEval: string at: pos
	^ (pos <= (string size))
		ifTrue: [{
			PEGAbstractSyntaxTreeNode new
				rule: self;
				startPos: pos;
				endPos: pos + 1;
				yourself .
			nil}]
		ifFalse: [{nil . PEGParsingError new: pos with: self}]