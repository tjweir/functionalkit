#import <Foundation/Foundation.h>
#import "FKFunction.h"

@interface NSObject (FunctionalKitExtensions)

// Returns the receivers |Class| cast as type |id|. This is useful when using NEWTYPE constructs as it allows you to call the type constructors 
// directly as functions without casting.
// For example instead of writing this: 
//   Function *f = functionTS((id)[Person class], name:)];
// You can write this:
//   Function *f = functionTS([Person classAsId], name:)];
- (id)classAsId;

// Returns a partially applied function for the given selector. Pass NSNull for the argument won't be partially applied.
// eg.
//   FKFunction *f = [someObject functionForSelector:@selector(register:withName:) arguments:NSARRAY([NSNull null], @"name") applyIndex:0];
//   [f :@"object"];
// equivalent to:
//   [someObject register:@"object" withName:@"object"];
- (FKFunction *)functionForSelector:(SEL)selector arguments:(NSArray *)args applyIndex:(NSUInteger)i;
@end
