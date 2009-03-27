#import <Foundation/Foundation.h>

@interface NSObject (FunctionalKitExtensions)

// Returns the receivers |Class| cast as type |id|. This is useful when using NEWTYPE constructs as it allows you to call the type constructors 
// directly as functions without casting.
// For example instead of writing this: 
//   Function *f = functionTS((id)[Person class], name:)];
// You can write this:
//   Function *f = functionTS([Person classAsId], name:)];
- (id)classAsId;

@end
