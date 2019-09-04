//: [Previous](@previous)

import Foundation

var sharedResource = 10
var lock = NSLock()

//: ## Challenge: Make this thread safe
//: Add lock/unlock statements to protect the sharedResource


func doWorkOnMultipleThreads() -> Bool {
    var x = 5
    sharedResource *= 10
    if sharedResource < 1000 {
        return false
    } else if sharedResource > 1000 && sharedResource < 1500 {
        sharedResource *= 2
        return true
    } else {
        sharedResource -= 100
    }
    sharedResource += 5
    return true
}




//: [Next](@next)
