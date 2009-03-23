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

// Returns this optional value if there is one, otherwise, returns the argument optional value.
- (FKOption *)orElse:(FKOption *)other;

// Returns the value in the some of this option or if none, the given argument.
- (id)orSome:(id)some;


// Maps the given selector across this option by invoking |selector| on value contained in |some|.
- (FKOption *)mapWithSelector:(SEL)selector;

// Maps the given selector across this option by invoking |selector| on |object| passing the value contained in |some| as an argument.
// |selector| should be a method taking a single argument of type |id| and return |id|.
// Note. Returns this either (i.e. self) if the given |object| does not response to |selector|.
- (FKOption *)mapWithSelector:(SEL)selector onObject:(id)object;

// Maps the given function across the option
- (FKOption *)map:(id <FKFunction>)f;

// Returns an either projection of this optional value; |left| in a Left if this optional holds no value, or this optional's value in Right.
- (FKEither *)toEither:(id)left;

@end

@interface FKNone : FKOption
@end

@interface FKSome : FKOption {
    id someObject;
}
@end
