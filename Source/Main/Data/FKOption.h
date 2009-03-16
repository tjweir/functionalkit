#import <Foundation/Foundation.h>
#import "FKFunction.h"

@interface MVOption : NSObject

+ (MVOption *)fromNil:(id)maybeNil;

+ (MVOption *)fromNil:(id)maybeNil ofType:(Class)cls;

+ (MVOption *)none;

+ (MVOption *)some:(id)someObject;

- (BOOL)isNone;

- (BOOL)isSome;

- (id)some;

// Returns this optional value if there is one, otherwise, returns the argument optional value.
- (MVOption *)orElse:(MVOption *)other;

// Returns the value of this optional value or the given argument.
- (id)orSome:(id)some;

// Maps the given selector across this option by invoking |selector| on value contained in |some|.
- (MVOption *)mapWithSelector:(SEL)selector;

// Maps the given selector across this option by invoking |selector| on |object| passing the value contained in |some| as an argument.
// |selector| should be a method taking a single argument of type |id| and return |id|.
// Note. Returns this either (i.e. self) if the given |object| does not response to |selector|.
- (MVOption *)mapWithSelector:(SEL)selector onObject:(id)object;

// Maps the given function across the option
- (MVOption *)map:(id <FKFunction>)f;
@end

@interface MVNone : MVOption
@end

@interface MVSome : MVOption {
    id someObject;
}
@end
