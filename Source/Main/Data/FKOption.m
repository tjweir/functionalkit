#import "FKOption.h"

@implementation FKNone

#pragma mark NSObject methods.
- (BOOL)isEqual:(id)object {
    return object == nil || ![[object class] isEqual:[self class]] ? NO : YES;
}

- (NSUInteger)hash {
    return 42;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%s>", class_getName([self class]), self.some];
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
    if (self = [super init]) {
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

// Takes an array of options, and returns an array of all the Some values
+ (NSArray *)somes:(NSArray *)options {
	NSMutableArray *result = [NSMutableArray array];
	for (FKOption *o in options) {
		if ([o isSome]) {
			[result addObject:[o some]];
		}
	}
	return [NSArray arrayWithArray:result];
}

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

- (FKOption *)mapWithSelector:(SEL)selector {
	return self.isSome && [[self some] respondsToSelector:selector] ? [FKOption some:[[self some] performSelector:selector]] : self;
}

- (FKOption *)mapWithSelector:(SEL)selector onObject:(id)object {
	return self.isSome && [object respondsToSelector:selector] ? [FKOption some:[object performSelector:selector withObject:[self some]]] : self;
}

- (FKOption *)map:(id <FKFunction>)f {
	return self.isSome ? [FKOption some:[f :self.some]] : self;
}

- (FKEither *)toEither:(id)left {
	return self.isSome ? [FKEither rightWithValue:self.some] : [FKEither leftWithValue:left];
}

@end
