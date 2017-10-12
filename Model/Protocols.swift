
// =======
// Requirements: (* - is required, o - optional)
// (*) 1. Implement given interfaces
// (*) 2. Implement CalculatorInterface using:
//        - Reverse Polish notation algorithm
//        - NSExpression
//        - other ways are also possible
// (*) 3. Use child view controllers (input and output contollers)
// (o) 4. Cover BL with Unit tests
// (o) 5. Use UIStackView for buttons layout
// (o) 6. Additional panel with functions in landscape. Implement using Size Classes
// (*) 7. Add animation on button press (using CoreAnimation)
// (o) 8. Graphics of Function.sin, Function.cos, Function.tan (using CoreGraphics)


// MARK: Enums
enum Operation: String {
	case plus  = "+"
	case minus = "-"
	case mult  = "x"
	case div   = "/"
	case exp   = "^"
	case equal = "="
}

enum Function: String {
	case sqrt    = "√"
	case sin     = "sin"
	case cos     = "cos"
	case tan     = "tan"
	case sinh    = "sinh"
	case cosh    = "cosh"
	case tanh    = "tanh"
	case ln      = "ln"
	case log     = "log"
	case fact    = "x!"
	case percent = "%"
	case sign    = "+/-"
}

enum Memory: String {
	case memoryClean  = "mc"
	case memoryAdd    = "m+"
	case memoryRemove = "m-"
	case clean        = "C"
	case allClean     = "AC"
}

enum Utility: String {
	case dot          = "."
	case leftBracket  = "("
	case rightBracket = ")"
}

enum Constants: String {
	case pi = "π"
	case e  = "e"
}

// MARK: Protocols

protocol InputInterface {
	func symbolPressed(_ symbol: String)
}

protocol OutputInterface {
	var displayValue:String{get set}
	
	func display(_ result: String)
}

protocol CalculatorDelegate {
	func input(_ symbol:String)
}

protocol CalculatorInterface {
	mutating func digit(_ value: Double)
	mutating func operation(_ operation: Operation)
	func function(_ function: Function)
	func memory(_ memory: Memory)
	func utility(_ utility: Utility)
	var resultClosure: ((Double?, Error?) -> Void) { get set }
}

// MARK: Extensions
extension Double {
	var clean: String {
		return self.truncatingRemainder(dividingBy: 1) == 0 ?
			String(format: "%.0f", self) : String(self)
	}
}

