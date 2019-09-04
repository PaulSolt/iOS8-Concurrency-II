import UIKit

//: Create a shared resource and modify it from multiple concurrent threads

var x = 42 // Shared resource
var xLock = NSLock()

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
//: [Next](@next)
