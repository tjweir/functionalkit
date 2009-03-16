#import <Foundation/Foundation.h>
#import "MVMacros.h"
#import "FKFunction.h"

@class MVEither;

@protocol MVEitherProjection <NSObject>

// The either value underlying this projection.
READ MVEither *either;

// The value of this projection or fails (throws an NSException) with a specialised error message.
READ id value;

// Returns the value of this projection or fails (throws an NSException) with the given error message.
- (id)valueOrMessage:(NSString*)errorMessage;

// Maps the given selector across the value in this either.
// Note. Returns this either (i.e. self) if the value in this either does not response to |selector|.
- (MVEither *)mapWithSelector:(SEL)selector;

// Maps the given selector across this either by invoking |selector| on |object| passing the value in the either as an argument.
// |selector| should be a method taking a single argument of type |id| and return |id|.
// Note. Returns this either (i.e. self) if the given |object| does not response to |selector|.
- (MVEither *)mapWithSelector:(SEL)selector onObject:(id)object;

- (MVEither *)map:(id <FKFunction>)f;
@end

@interface MVLeftProjection : NSObject <MVEitherProjection> {
    MVEither *either;
}

@end

// A right projection of an either value.
@interface MVRightProjection : NSObject <MVEitherProjection> {
    MVEither *either;
}

// TODO Look at FJ projections for a better way to return an error, so we don't need to do: [(NSError *)[result value]  localizedDescription].
@end

// The Either type represents a value of one of two possible types (a disjoint union).
// The data constructors; Left and Right represent the two possible values. The Either type is often used as an alternative to Option where Left 
// represents failure (by convention) and Right is akin to Some.
@interface MVEither : NSObject {
    id value;
    BOOL isLeft;
}

READ BOOL isLeft;
READ BOOL isRight;
READ MVLeftProjection *left;
READ MVRightProjection *right;

// Construct a left value of either.
+ (MVEither *)leftWithValue:(id)value;

// Construct a right value of either.
+ (MVEither *)rightWithValue:(id)value;

// If this is a left, then return the left value in right, or vice versa.
- (MVEither *)swap;

@end
