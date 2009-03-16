#import "MVEither.h"

@interface MVEither (MVEitherPrivate)
- (MVEither *)initWithValue:(id)value isLeft:(BOOL)newIsLeft;
// Note. This is private to allow projections to get access to value, but not calling code, as it must come via a projection.
- (id)value;
@end

#pragma mark MVLeftProjection implementation.
@interface MVLeftProjection (MVLeftProjectionPrivate)
- (MVLeftProjection *)initWithEither:(MVEither *)either;
@end
@implementation MVLeftProjection

@synthesize either;

- (id)value {
    return [self valueOrMessage:@"Attempt to access a right value but value is on the left"];
}

- (id)valueOrMessage:(NSString*)errorMessage {
    if (either.isLeft) {
        return [either value];
    } else {
        @throw [NSException exceptionWithName:@"InvalidOperation" reason:errorMessage userInfo:EMPTY_DICT];
    }
}

- (MVEither *)mapWithSelector:(SEL)selector {
    return either.isLeft && [either.value respondsToSelector:selector] ? [MVEither leftWithValue:[either.value performSelector:selector]] : either;
}

- (MVEither *)mapWithSelector:(SEL)selector onObject:(id)object {
    return either.isLeft && [object respondsToSelector:selector] ? [MVEither leftWithValue:[object performSelector:selector withObject:either.value]] : either;
}

- (MVEither *)map:(id <FKFunction>)f {
	return either.isLeft ? [MVEither leftWithValue:[f :either.value]] : either;
}

- (void)dealloc {
    [either release];
    [super dealloc];
}

#pragma mark Private methods.
- (MVLeftProjection *)initWithEither:(MVEither *)newEither {
    if (self = [super init]) {
        either = [newEither retain];
    }
    return self;
}

@end

#pragma mark MVRightProjection implementation.
@interface MVRightProjection (MVRightProjectionPrivate)
- (MVRightProjection *)initWithEither:(MVEither *)either;
@end
@implementation MVRightProjection

@synthesize either;

- (id)value {
    return [self valueOrMessage:@"Attempt to access a left value but value is on the right"];
}

- (id)valueOrMessage:(NSString*)errorMessage {
    if (either.isRight) {
        return [either value];
    } else {
        @throw [NSException exceptionWithName:@"InvalidOperation" reason:errorMessage userInfo:EMPTY_DICT];
    }
}

- (MVEither *)mapWithSelector:(SEL)selector {
    return either.isRight && [either.value respondsToSelector:selector] ? [MVEither rightWithValue:[either.value performSelector:selector]] : either;
}

- (MVEither *)mapWithSelector:(SEL)selector onObject:(id)object {
    return either.isRight && [object respondsToSelector:selector] ? [MVEither rightWithValue:[object performSelector:selector withObject:either.value]] : either;
}

- (MVEither *)map:(id <FKFunction>)f {
	return either.isRight ? [MVEither rightWithValue:[f :either.value]] : either;
}

- (void)dealloc {
    [either release];
    [super dealloc];
}

#pragma mark Private methods.
- (MVRightProjection *)initWithEither:(MVEither *)newEither {
    if (self = [super init]) {
        either = [newEither retain];
    }
    return self;
}

@end

#pragma mark MVEither implementation.
@implementation MVEither

@synthesize isLeft;

+ (MVEither *)leftWithValue:(id)value {
    return [[[MVEither alloc] initWithValue:value isLeft:YES] autorelease];
}

+ (MVEither *)rightWithValue:(id)value {
    return [[[MVEither alloc] initWithValue:value isLeft:NO] autorelease];
}

- (BOOL)isRight {
    return !isLeft;
}

- (MVLeftProjection *)left {
    return [[[MVLeftProjection alloc] initWithEither:self] autorelease];
}

- (MVRightProjection *)right {
    return [[[MVRightProjection alloc] initWithEither:self] autorelease];
}

- (MVEither *)swap {
    return isLeft ? [MVEither rightWithValue:value] : [MVEither leftWithValue:value];
}

#pragma mark NSObject methods.
- (BOOL)isEqual:(id)object {
    if (object == nil || ![[object class] isEqual:[MVEither class]]) {
        return NO;
    } else {
        MVEither *other = (MVEither *) object;
        if (self.isLeft == other.isLeft) {
            return self.isLeft ? [self.left.value isEqual:other.left.value] : [self.right.value isEqual:other.right.value];
        } else {
            return NO;
        }
    }
}

- (NSUInteger)hash {
    return value == nil ? 42 : [value hash];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ value: %@>", isLeft ? @"MVLeftProjection" : @"MVRightProjection", value];
}

- (void)dealloc {
    [value release];
    [super dealloc];
}

#pragma mark Private methods.
- (MVEither *)initWithValue:(id)newValue isLeft:(BOOL)newIsLeft {
    if (self = [super init]) {
        value = [newValue retain];
        isLeft = newIsLeft;
    }
    return self;
}

- (id)value {
    return value;
}

// TODO DELETE BELOW HERE. THESE BELONG IN PROJECTIONS.
@end
