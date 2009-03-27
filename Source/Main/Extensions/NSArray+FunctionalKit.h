#import <Foundation/Foundation.h>
#import "FKFunction.h"
#import "FKMacros.h"

@interface NSArray (FunctionalKitExtensions)

// f :: id -> BOOL
- (BOOL)all:(id <FKFunction>)f;

// Filters the items in this array returning only those that match the given predicate.
// f :: id -> BOOL
- (NSArray *)filter:(id <FKFunction>)f;

// Groups the items in this array using the given function. Equal objects are placed in the same array.
// f :: id -> id -> BOOL
- (NSArray *)groupBy:(id <FKFunction>)f;

- (NSArray *)map:(id <FKFunction>)f;

- (void)foreach:(id <FKFunction>)f;

+ (id <FKFunction>)liftFunction:(id <FKFunction>)f;


@end
