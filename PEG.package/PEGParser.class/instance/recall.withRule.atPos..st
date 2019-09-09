as yet unclassified
recall: string withRule: ruleName atPos: pos
	| memoizationResult head |
	memoizationResult := (memoization at: pos ifAbsent: [^nil]) at: ruleName.
	head := heads at: pos.
	
	head ifNil: [^ memoizationResult].
	
	(memoizationResult == nil and: [ruleName ~~ head ruleName] and: [(head involvedSet includes: ruleName) not])
		ifTrue: [^ nil].
	
	(head evalSet includes: ruleName)
		ifTrue: [
			| result |
			head evalSet remove: ruleName.
			result := self perform: ruleName withArguments: {string . pos}.
			memoization at: pos put: result.
			^ result].
	
	^ memoizationResult