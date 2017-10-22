
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
import Foundation

let numbers : Set<String> = ["0","1","2","3","4","5","6","7","8","9"]

let operations: Set<String> = ["+","-","x","/"]
                               //"√","sin","cos","tan","sinh","cosh","tanh","ln","log","x!","%","+/-","1/x","x²","x³","xʸ","eˣ","10ˣ","ʸ√x","³√x"]

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
	case x_1     = "1/x"
	case x2      = "x²"
	case x3      = "x³"
	case xy      = "xʸ"
	case ex      = "eˣ"
	case x10      = "10ˣ"
	case y_root_x = "ʸ√x"
	case root3_x = "³√x"
	
}

enum Memory: String {
	case memoryClean  = "mc"
	case memoryAdd    = "m+"
	case memoryRemove = "m-"
	case clean        = "C"
	case allClean     = "AC"
}

enum Utility: String {
	//case dot          = "."
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
	var  displayValue:String{get set}
	func display(_ result: String)
}

protocol CalculatorDelegate {
	func input(_ symbol:String)
}

protocol CalculatorInterface {
	func digit(_ value: Double)
	func operation(_ operation: Operation)
	func function(_ function: Function)
	func memory(_ memory: Memory, _ number: Double?)
	func utility(_ utility: Utility)
	var resultClosure: ((Double?, Error?) -> Void) { get set }
}

// MARK: Extensions
extension Double {
	var clean: String {
		return self.truncatingRemainder(dividingBy: 1) == 0 ?
			String(format: "%.0f", self) : String(self)
	}

	private static let arc4randomMax = Double(UInt32.max)
	
	static func random0to1() -> Double {
		return Double(arc4random()) / arc4randomMax
	}
}

