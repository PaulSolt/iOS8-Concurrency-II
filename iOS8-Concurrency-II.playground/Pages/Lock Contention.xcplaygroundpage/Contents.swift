//: [Previous](@previous)

import Foundation

// GCD
// DispatchQueue = grocery store checkout line
// serial = 1 lane
// concurrent = 2+ lanes (12 lanes = 6 core CPU)

// DispatchGroup = chaporone - count the heads of all the kids on the field

var sharedResource = 0
let lock = NSLock()
let group = DispatchGroup() // .init() // Option-click to see QuickHelp

let numberOfIterations = 20_000 // 20,000  20000

var startTime = Date()

// Do work
print("Start")
for _ in 0 ..< numberOfIterations {
    group.enter()   // entering the field trip destination
    
    // Lock vs. DispatchQueue
    lock.lock()
    
    sharedResource += 1
    
    lock.unlock()
    
    group.leave()   // get on the bus to go home
}

print("Waiting")
group.wait()        // wait until all the kids are on the bus


var endTime = Date()
var elapsedTime = endTime.timeIntervalSinceReferenceDate - startTime.timeIntervalSinceReferenceDate
print("Time elapsed to add \(numberOfIterations): \(elapsedTime) seconds")


// Test with DispatchQueue

startTime = Date()

let serialQueue = DispatchQueue(label: "Serial Queue to Test Performance")


print("Start2")
for _ in 0 ..< numberOfIterations {
    group.enter()   // entering the field trip destination
    
    // Lock vs. DispatchQueue
    serialQueue.sync {
        sharedResource += 1
    }
    
    group.leave()   // get on the bus to go home
}

print("Waiting2")
group.wait()        // wait until all the kids are on the bus


endTime = Date()
elapsedTime = endTime.timeIntervalSinceReferenceDate - startTime.timeIntervalSinceReferenceDate
print("Time elapsed to add \(numberOfIterations): \(elapsedTime) seconds")



//: [Next](@next)
