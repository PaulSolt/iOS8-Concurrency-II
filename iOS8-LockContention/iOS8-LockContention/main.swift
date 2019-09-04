//
//  main.swift
//  iOS8-LockContention
//
//  Created by Paul Solt on 9/4/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import Foundation

// Command + ~ to switch Xcode windows

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
//group.enter()  // 20,001 enters, 20,000 leaves (1 missing!!!)

print("Waiting")
group.wait()        // wait until all the kids are on the bus


var endTime = Date()
var elapsedTime = endTime.timeIntervalSinceReferenceDate - startTime.timeIntervalSinceReferenceDate
print("Lock Time elapsed to add \(numberOfIterations): \(elapsedTime) seconds")


// Test with DispatchQueue

startTime = Date()

let serialQueue = DispatchQueue(label: "Serial Queue to Test Performance")

// 1. Time profile, don't assume you know how fast something is
// 2. Both methods are very fast, use either to protect shared data
// 3. DispatchGroup works

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
print("Queue Time elapsed to add \(numberOfIterations): \(elapsedTime) seconds")

