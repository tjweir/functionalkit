#import "FKEither.h"

@interface FKEither (FKEitherPrivate)
- (FKEither *)initWithValue:(id)value isLeft:(BOOL)newIsLeft;
// Note. This is private to allow projections to get access to value, but not calling code, as it must come via a projection.
- (id)value;
@end

#pragma mark FKLeftProjection implementation.
@interface FKLeftProjection (FKLeftProjectionPrivate)
- (FKLeftProjection *)initWithEither:(FKEither *)either;
@end
@implementation FKLeftProjection

@synthesize either;

- (id)value {
    return [self valueOrMessage:@"Attempt to access a right value but value is on the left"];
}

- (id)valueOrMessage:(NSString*)errorMessage {
    if (either.isLeft) {
        return [either value];
    } else {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:errorMessage userInfo:EMPTY_DICT];
    }
}

- (FKEither *)mapWithSelector:(SEL)selector {
    return either.isLeft && [either.value respondsToSelector:selector] ? [FKEither leftWithValue:[either.value performSelector:selector]] : either;
}

- (FKEither *)mapWithSelector:(SEL)selector onObject:(id)object {
    return either.isLeft && [object respondsToSelector:selector] ? [FKEither leftWithValue:[object performSelector:selector withObject:either.value]] : either;
}

- (FKEither *)map:(id <FKFunction>)f {
	return either.isLeft ? [FKEither leftWithValue:[f :either.value]] : either;
}

- (void)dealloc {
    [either release];
    [super dealloc];
}

#pragma mark Private methods.
- (FKLeftProjection *)initWithEither:(FKEither *)newEither {
    if (self = [super init]) {
        either = [newEither retain];
    }
    return self;
}

@end

#pragma mark FKRightProjection implementation.
@interface FKRightProjection (FKRightProjectionPrivate)
- (FKRightProjection *)initWithEither:(FKEither *)either;
@end
@implementation FKRightProjection

@synthesize either;

- (id)value {
    return [self valueOrMessage:@"Attempt to access a left value but value is on the right"];
}

- (id)valueOrMessage:(NSString*)errorMessage {
    if (either.isRight) {
        return [either value];
    } else {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:errorMessage userInfo:EMPTY_DICT];
    }
}

- (FKEither *)mapWithSelector:(SEL)selector {
    return either.isRight && [either.value respondsToSelector:selector] ? [FKEither rightWithValue:[either.value performSelector:selector]] : either;
}

- (FKEither *)mapWithSelector:(SEL)selector onObject:(id)object {
    return either.isRight && [object respondsToSelector:selector] ? [FKEither rightWithValue:[object performSelector:selector withObject:either.value]] : either;
}

- (FKEither *)map:(id <FKFunction>)f {
	return either.isRight ? [FKEither rightWithValue:[f :either.value]] : either;
}

- (void)dealloc {
    [either release];
    [super dealloc];
}

#pragma mark Private methods.
- (FKRightProjection *)initWithEither:(FKEither *)newEither {
    if (self = [super init]) {
        either = [newEither retain];
    }
    return self;
}

@end

#pragma mark FKEither implementation.
@implementation FKEither

@synthesize isLeft;

+ (FKEither *)leftWithValue:(id)value {
    return [[[FKEither alloc] initWithValue:value isLeft:YES] autorelease];
}

+ (FKEither *)rightWithValue:(id)value {
    return [[[FKEither alloc] initWithValue:value isLeft:NO] autorelease];
}

+ (FKEither *)errorWithReason:(NSString *)reason {
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:reason forKey:NSLocalizedDescriptionKey];
    return [FKEither leftWithValue:[NSError errorWithDomain:@"InvalidOperation" code:0 userInfo:userInfo]];
}

- (BOOL)isRight {
    return !isLeft;
}

- (FKLeftProjection *)left {
    return [[[FKLeftProjection alloc] initWithEither:self] autorelease];
}

- (FKRightProjection *)right {
    return [[[FKRightProjection alloc] initWithEither:self] autorelease];
}

- (FKEither *)swap {
    return isLeft ? [FKEither rightWithValue:value] : [FKEither leftWithValue:value];
}

#pragma mark NSObject methods.
- (BOOL)isEqual:(id)object {
    if (object == nil || ![[object class] isEqual:[FKEither class]]) {
        return NO;
    } else {
        FKEither *other = (FKEither *) object;
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
    return [NSString stringWithFormat:@"<%@ value: %@>", isLeft ? @"FKLeftProjection" : @"FKRightProjection", value];
}

- (void)dealloc {
    [value release];
    [super dealloc];
}

#pragma mark Private methods.
- (FKEither *)initWithValue:(id)newValue isLeft:(BOOL)newIsLeft {
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
