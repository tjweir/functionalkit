#import "FK/FKOption.h"

@implementation FKNone

#pragma mark NSObject methods.
- (BOOL)isEqual:(id)object {
    return object == nil || ![[object class] isEqual:[self class]] ? NO : YES;
}

- (NSUInteger)hash {
    return 42;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%s>", class_getName([self class])];
}

@end

@interface FKSome (FKSomePrivate)
- (FKSome *)initWithSome:(id)someObject;
@end

@implementation FKSome

- (id)some {
    return someObject;
}

- (void) dealloc {
    [someObject release];
    [super dealloc];
}

#pragma mark NSObject methods.
- (BOOL)isEqual:(id)object {
    return object == nil || ![[object class] isEqual:[self class]] ? NO : [self.some isEqual:((FKSome *) object).some];
}

- (NSUInteger)hash {
    return [self.some hash];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%s some: %@>", class_getName([self class]), self.some];
}

#pragma mark Private methods.
- (FKSome *)initWithSome:(id)newSomeObject {
    if ((self = [super init])) {
        someObject = [newSomeObject retain];
    }
    return self;
}

@end

@implementation FKOption

+ (FKOption *)fromNil:(id)maybeNil {
    return maybeNil == nil ? [FKOption none] : [FKOption some:maybeNil];
}

+ (FKOption *)fromNil:(id)maybeNil ofType:(Class)cls {
	//TODO add bind and re-use fromNil
	return (maybeNil != nil && [maybeNil isKindOfClass:cls]) ? [FKOption some:maybeNil] : [FKOption none];
}

+ (FKOption *)none {
    return [[[FKNone alloc] init] autorelease];
}

+ (FKOption *)some:(id)someObject {
    return [[[FKSome alloc] initWithSome:someObject] autorelease];
}

// TODO Replace this implementation with filter.
+ (NSArray *)somes:(NSArray *)options {
	NSMutableArray *result = [NSMutableArray array];
	for (FKOption *o in options) {
		if ([o isSome]) {
			[result addObject:[o some]];
		}
	}
	return [NSArray arrayWithArray:result];
}

// TODO Add identity function.
//+ (FKOption *)concat:(FKOption *)nested {
//    if (nested.isSome) {
//    } else {
//    }
//}

- (BOOL)isNone {
    return [self isKindOfClass:[FKNone class]];
}

- (BOOL)isSome {
    return [self isKindOfClass:[FKSome class]];
}

- (id)some {
    NSString *message = @"Attempt to access some but this is None";
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:message userInfo:EMPTY_DICT];
}

- (FKOption *)orElse:(FKOption *)other {
    return self.isSome ? self : other;
}

- (id)orSome:(id)some {
    return self.isSome ? [self some] : some;
}

- (FKOption *)map:(id <FKFunction>)f {
	return self.isSome ? [FKOption some:[f :self.some]] : self;
}

- (FKOption *)bind:(id <FKFunction>)f {
	return self.isSome ? [f :self.some] : self;
}

- (FKEither *)toEither:(id)left {
	return self.isSome ? [FKEither rightWithValue:self.some] : [FKEither leftWithValue:left];
}

- (FKEither *)toEitherWithError:(NSString *)reason {
	return self.isSome ? [FKEither rightWithValue:self.some] : [FKEither errorWithReason:reason];
}

- (void)foreach:(id <FKEffect>)effect {
    if (self.isSome) {
        [effect e:self.some];
    }
}

@end
