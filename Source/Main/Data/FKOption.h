#import <Foundation/Foundation.h>
#import "FKFunction.h"

@interface FKOption : NSObject

+ (FKOption *)fromNil:(id)maybeNil;

+ (FKOption *)fromNil:(id)maybeNil ofType:(Class)cls;

+ (FKOption *)none;

+ (FKOption *)some:(id)someObject;

- (BOOL)isNone;

- (BOOL)isSome;

- (id)some;

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
@end

@interface FKNone : FKOption
@end

@interface FKSome : FKOption {
    id someObject;
}
@end
