#import <Foundation/Foundation.h>
#import "FKMacros.h"
#import "FKFunction.h"

@class FKEither;

@protocol FKEitherProjection <NSObject>

// The either value underlying this projection.
READ FKEither *either;

// The value of this projection or fails (throws an NSException) with a specialised error message.
READ id value;

// Returns the value of this projection or fails (throws an NSException) with the given error message.
- (id)valueOrMessage:(NSString*)errorMessage;

// Maps the given selector across the value in this either.
// Note. Returns this either (i.e. self) if the value in this either does not response to |selector|.
- (FKEither *)mapWithSelector:(SEL)selector;

// Maps the given selector across this either by invoking |selector| on |object| passing the value in the either as an argument.
// |selector| should be a method taking a single argument of type |id| and return |id|.
// Note. Returns this either (i.e. self) if the given |object| does not response to |selector|.
- (FKEither *)mapWithSelector:(SEL)selector onObject:(id)object;

- (FKEither *)map:(id <FKFunction>)f;
@end

@interface FKLeftProjection : NSObject <FKEitherProjection> {
    FKEither *either;
}

@end

// A right projection of an either value.
@interface FKRightProjection : NSObject <FKEitherProjection> {
    FKEither *either;
}

// TODO Look at FJ projections for a better way to return an error, so we don't need to do: [(NSError *)[result value]  localizedDescription].
@end

// The Either type represents a value of one of two possible types (a disjoint union).
// The data constructors; Left and Right represent the two possible values. The Either type is often used as an alternative to Option where Left 
// represents failure (by convention) and Right is akin to Some.
@interface FKEither : NSObject {
    id value;
    BOOL isLeft;
}

READ BOOL isLeft;
READ BOOL isRight;
READ FKLeftProjection *left;
READ FKRightProjection *right;

// Construct a left value of either.
+ (FKEither *)leftWithValue:(id)value;

// Construct a right value of either.
+ (FKEither *)rightWithValue:(id)value;

// Construct an NSError on the left using |reason| as the NSLocalizedDescriptionKey.
+ (FKEither *)errorUsingReason:(NSString *)reason;

// If this is a left, then return the left value in right, or vice versa.
- (FKEither *)swap;

@end
