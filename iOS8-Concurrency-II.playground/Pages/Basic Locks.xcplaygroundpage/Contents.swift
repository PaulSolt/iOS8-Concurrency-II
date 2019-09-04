import UIKit

//: Create a shared resource and modify it from multiple concurrent threads

var x = 42 // Shared resource
var xLock = NSLock()    // Mutex

//for i in 0..<100 {
 DispatchQueue.concurrentPerform(iterations: 100) { (index) in
    xLock.lock()
    
    var localCopy = x   // Read
    localCopy += 1      // Modify
    x = localCopy       // Write
//    print("x: \(x)")
    
    xLock.unlock()
}
// 6 cores = 12 threads (2 threads per core)
// 4 cores = 8
// 2 cores = 4
print("End: expecting x to be: 142: \(x)")


var sharedResource = 27
let sharedAccessQueue = DispatchQueue(label: "Shared Resource Queue")

DispatchQueue.concurrentPerform(iterations: 100) { threadNumber in
    print("Starting sync block: #\(threadNumber + 1)")
    sharedAccessQueue.async {
        print("Executing concurrent perform #\(threadNumber + 1)")
        
        var copyOfResource = sharedResource
        copyOfResource += 1
        sharedResource = copyOfResource
    }
    print("Finished sync block: #\(threadNumber + 1)")
}
print("SharedResource: Expect 127 calculated: \(sharedResource)")

//: [Next](@next)
