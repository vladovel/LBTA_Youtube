import UIKit

var str = "Hello, playground"


enum test: String {
    case Eden = "one"
    case Dva = "two"
    case Tri = "three"
}

let myEnum = test(rawValue: "cetiri")

print(myEnum?.rawValue)


