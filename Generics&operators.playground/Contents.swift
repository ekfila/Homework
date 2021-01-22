import UIKit

//4. Дженерики позволяют писать функции и собственные составные типы, работающие с несколькими типами сразу (типы выступают в качестве параметров). Это очень удобно для избавления от повторяющегося кода и лучшей читаемости.

//5. Ассоциированные типы используются в определении протоколов. Это плейсхолдеры для имен типов. Фактический тип, который будет использоваться вместо ассоциированного типа, не указавается до тех пор, пока не будет принят протокол.

//6.
//a
func equalOrNot<T: Equatable>(_ x: T, _ y: T) {
    x==y ? print("they are equal") : print("they are not equal")
}
equalOrNot(8, 8)

//b
func maxOf<T: Comparable>(_ x: T, _ y: T) {
    x > y ? print(x) : print (y)
}
maxOf(7, 5)

//c
func swapIfAGreaterThanB<T: Comparable>(_ x: inout T, _ y: inout T) {
    if x > y {
        swap(&x, &y)
    }
}
var a = 4
var b = 5
swapIfAGreaterThanB(&b, &a)
a
b

//d
func joinTwoFunctions<T> (_ func1: @escaping (T) -> Void, _ func2: @escaping (T) -> Void) -> (T) -> Void {
    return {
        func1($0)
        func2($0)
    }
}

func printA(_ a: Int) {
    print(a)
}

func printASquared(_ a: Int) {
    print(a * a)
}

let jointFunction = joinTwoFunctions(printA(_:), printASquared(_:))
jointFunction(3)


//7.
//a
extension Array where Element: Comparable{
    var maxElement: Element? {
        //precondition(self.count > 0)
        if self.count == 0 {
            return nil
        }
        var result = self[0]
        for item in self {
            if item > result {
                result = item
            }
        }
        return result
    }
}

let arr = [7, 4, 6, 0, -4, -10]
print("max in this array is \(arr.maxElement!)")

let arr1: [Int] = []
arr1.maxElement

//b
extension Array where Element: Equatable {
    func unique() -> Array<Element> {
        var newArray = Array<Element>()
        if self.count > 0 {
            for item in self {
                var add = true
                if newArray.count > 0 {
                    for newItem in newArray {
                        if item == newItem {
                            add = false
                        }
                    }
                }
                if add {
                    newArray.append(item)
                }
            }
        }
        return newArray
    }
}

var anotherArr = [-5, 3, 2, 0, 3, 0, 2, 4, 3, 5, 5, 6]
print(anotherArr.unique())

var arr2 = [-5]
print(arr2.unique())

//8.
//a
precedencegroup PowerPrecedence {
    higherThan: MultiplicationPrecedence
    associativity: right
}

infix operator ^^: PowerPrecedence
func ^^(_ x: Int, _ y: Int) -> Double {
    precondition(x != 0 || y >= 0)
    if y == 0 {
        return 1
    } else if y > 0 {
        var result = 1
        var remainingDegree = y
        var toSquare = x
        while remainingDegree > 0 {
            if remainingDegree % 2 == 1 {
                result *= toSquare
            }
            remainingDegree /= 2
            toSquare *= toSquare
        }
        return Double(result)
    } else {
        return 1 / x ^^ (-y)
    }
}
print(5^^4, (-5)^^3, 5^^(-2), (-5)^^(-2), 5^^0, 0^^2, 0^^0)

//b
infix operator ~>
func ~>(_ x: Int, _ y: inout Int) {
    y = 2 * x
}
let number1 = 5
var number2 = 4
number1 ~> number2
print(number1, number2)


//c
infix operator <*
func <* (_ myController: UITableViewDelegate, _ tableView: UITableView) {
    tableView.delegate = myController
}
let controller = UITableViewController()
let tableView = UITableView()
controller <* tableView


//d
func + (_ first: CustomStringConvertible, _ second: CustomStringConvertible) -> String {
    return first.description + second.description
}
print(7+" string")

//9.
//a
func changeBackgroundColor(_ view: UIView, _ color: UIColor) {
    UIView.animate(withDuration: 0.3) {view.backgroundColor = color}
}

//b
func changeCenter(_ view: UIView, _ point: CGPoint) {
    UIView.animate(withDuration: 0.3) {view.center = point}
}

//c
func changeScale(_ view: UIView, _ scale: CGFloat) {
    UIView.animate(withDuration: 0.3) {
        view.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
}
