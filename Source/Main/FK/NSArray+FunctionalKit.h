#import <Foundation/Foundation.h>
#import "FK/FKFunction.h"
#import "FK/FKMacros.h"
#import "FK/FKP2.h"
#import "FK/FKOption.h"

// TODO Add:
// - foldL, foldR
// - intersperse

@interface NSArray (FunctionalKitExtensions)

// Lifts the given function into this array monad, returning a new function that applies the given function to each item in the array (aka. map).
// f :: id -> id
+ (id <FKFunction>)liftFunction:(id <FKFunction>)f;

// Concatenates an array of arrays of items into an array of items. Will fail if any item is not an array.
// concat :: [[a]] -> [a]
+ (NSArray *)concat:(NSArray *)nested;

// The first element of the array or fails for the empty array.
READ id head;

// The array without the first element or fails for the empty array.
READ NSArray *tail;

// Returns a tuple where the first element is an array containing the longest prefix of this array that satisfies the given predicate and the second 
// element is the remainder of the array (i.e. those items that don't match).
// f :: id -> BOOL
- (FKP2 *)span:(id <FKFunction>)f;

// Returns |YES| if every item in this array matches the given predicate.
// f :: id -> BOOL
- (BOOL)all:(id <FKFunction>)f;

// Filters the items in this array returning only those that match the given predicate.
// f :: id -> BOOL
- (NSArray *)filter:(id <FKFunction>)f;

// TODO Add one like FJ's: group :: (id -> id -> BOOL) -> NSArray (takes an equality function).
// Groups the items in this array using the given |equal|, equal objects are placed in the same array.
//- (NSArray *)group:(id <FKEqual>)equal;

// Groups the items in this array using the given function to determine the key. Equal objects are placed in the same array. The value returned by
// |f| will be used as a key in an NSDictionary so must conform to the key requirements of that class (conform to the NSCopying protocol).
// f :: id -> id
- (NSDictionary *)groupByKey:(id <FKFunction>)f;

// Folds across this array using |acc| as the start acumulator (of type a), a function given a & b that returns an a, in constant stack.
// It takes the second argument and the first item of the list and applies the function to them, then feeds the function with this result and the 
// second argument and so on. 
// foldLeft :: a -> (a -> b -> a) -> a
- (id)foldLeft:(id)acc f:(id <FKFunction2>)f;

// Maps the given function across every item in this array. You should ensure that you return an autoreleased object from |f|.
// f :: id -> id
- (NSArray *)map:(id <FKFunction>)f;

// Applies to given function to each item in this array. If the function returns a value it is ignored, it is assumed to be side-effecting.
// f :: id -> void
- (void)foreach:(id <FKFunction>)f;

// Intersperses the |object| in bewtween the elements of this array.
- (NSArray *)intersperse:(id)object;

// Reverses this array.
- (NSArray *)reverse;

// Returns the unique items in this array, according to the |isEqual:| selector. Items in the returned array may not be in the same order as this 
// array.
- (NSArray *)unique;

// TODO Add unique

// Returns an option projection of this array; None if empty, or the first element in Some.
- (FKOption *)toOption;

@end
