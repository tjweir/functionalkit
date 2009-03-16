#import "MVOption.h"

@implementation MVNone
@end

@interface MVSome (MVSomePrivate)
- (MVSome *)initWithSome:(id)someObject;
@end

@implementation MVSome

- (id)some {
    return someObject;
}

- (void) dealloc {
    [someObject release];
    [super dealloc];
}

#pragma mark Private methods.
- (MVSome *)initWithSome:(id)newSomeObject {
    if (self = [super init]) {
        someObject = [newSomeObject retain];
    }
    return self;
}

@end

@implementation MVOption

+ (MVOption *)fromNil:(id)maybeNil {
    return maybeNil == nil ? [MVOption none] : [MVOption some:maybeNil];
}

+ (MVOption *)fromNil:(id)maybeNil ofType:(Class)cls {
	//TODO add bind and re-use fromNil
	return (maybeNil != nil && [maybeNil isKindOfClass:cls]) ? [MVOption some:maybeNil] : [MVOption none];
}

+ (MVOption *)none {
    return [[[MVNone alloc] init] autorelease];
}

+ (MVOption *)some:(id)someObject {
    return [[[MVSome alloc] initWithSome:someObject] autorelease];
}

- (BOOL)isNone {
    return [self isKindOfClass:[MVNone class]];
}

- (BOOL)isSome {
    return [self isKindOfClass:[MVSome class]];
}

- (id)some {
    return nil;
}

- (MVOption *)orElse:(MVOption *)other {
    return [self isSome] ? self : other;
}

- (id)orSome:(id)some {
    return [self isSome] ? [self some] : some;
}

- (MVOption *)mapWithSelector:(SEL)selector {
	return [self isSome] && [[self some] respondsToSelector:selector] ? [MVOption some:[[self some] performSelector:selector]] : self;
}

- (MVOption *)mapWithSelector:(SEL)selector onObject:(id)object {
	return [self isSome] && [object respondsToSelector:selector] ? [MVOption some:[object performSelector:selector withObject:[self some]]] : self;
}

- (MVOption *)map:(id <FKFunction>)f {
	return [self isSome] ? [MVOption some:[f :[self  some]]] : self;
}

@end
