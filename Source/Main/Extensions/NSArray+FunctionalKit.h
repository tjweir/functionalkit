#import <Foundation/Foundation.h>
#import "FKFunction.h"
#import "FKMacros.h"

@interface NSArray (FunctionalKitExtensions)

// The first element of the array or fails for the empty array.
READ id head;

// The array without the first element or fails for the empty array.
READ NSArray *tail;

// Lifts the given function into this array monad, returning a new function that applies the given function to each item in the array (aka. map).
// f :: id -> id
+ (id <FKFunction>)liftFunction:(id <FKFunction>)f;

// Returns |YES| if every item in this array matches the given predicate.
// f :: id -> BOOL
- (BOOL)all:(id <FKFunction>)f;

// Filters the items in this array returning only those that match the given predicate.
// f :: id -> BOOL
- (NSArray *)filter:(id <FKFunction>)f;

// Groups the items in this array using the given function. Equal objects are placed in the same array.
// f :: id -> id -> BOOL
- (NSArray *)group:(id <FKFunction>)f;

// Maps the given function across every item in this array.
// f :: id -> id
- (NSArray *)map:(id <FKFunction>)f;

// Applies to given function to each item in this array. If the function returns a value it is ignored, it is assumed to be side-effecting.
// f :: id -> void
- (void)foreach:(id <FKFunction>)f;

@end
