#import <Foundation/Foundation.h>

// Represents a non-blocking future value. Products, functions, and actors, given to the methods on this class, are executed concurrently, and the
// Promise serves as a handle on the result of the computation.
@interface FKPromise : NSObject {
}

// Waits if necessary for the computation to complete, and then retrieves its result.
- (id)claim;

// Waits if necessary for the computation to complete, and then retrieves its result.
- (id)claim:(NSTimeInterval)timeout;

@end
