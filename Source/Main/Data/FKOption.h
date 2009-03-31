#import <Foundation/Foundation.h>
#import "FKFunction.h"
#import "FKEither.h"
#import "FKMacros.h"

// An optional value that may be none (no value) or some (a value). This type is a replacement for the use of nil to denote non-existence.
@interface FKOption : NSObject

READ id some;
READ BOOL isNone;
READ BOOL isSome;

+ (FKOption *)fromNil:(id)maybeNil;

+ (FKOption *)fromNil:(id)maybeNil ofType:(Class)cls;

+ (FKOption *)none;

+ (FKOption *)some:(id)someObject;

// Takes an array of options, and returns an array of all the Some values
+ (NSArray *)somes:(NSArray *)options;

// TODO Add identity function, then do concat.
// Concatenates an option containing an option into an option. Will fail if any item is not an FKOption.
// concat :: FKOption[FKOption[a]] -> FKOption[a]
//+ (FKOption *)concat:(FKOption *)nested;

// Returns this optional value if there is one, otherwise, returns the argument optional value.
- (FKOption *)orElse:(FKOption *)other;

// Returns the value in the some of this option or if none, the given argument.
- (id)orSome:(id)some;

// Maps the given function across the option
- (FKOption *)map:(id <FKFunction>)f;

// Binds the given function across the projection.
// f should be a fucntion with the following type: a -> FKOption[b].
- (FKOption *)bind:(id <FKFunction>)f;

// Returns an either projection of this optional value; |left| in a Left if this optional holds no value, or this optional's value in Right.
- (FKEither *)toEither:(id)left;

@end

@interface FKNone : FKOption
@end

@interface FKSome : FKOption {
    id someObject;
}
@end
