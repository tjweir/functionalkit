#import "FK/FKEffect.h"
#import "FK/FKMacros.h"


@interface ComapEffectFunction : NSObject <FKEffect> {
	id <FKFunction> f;
	id <FKEffect> e;
}

- (id)initWithEffect:(id <FKEffect>)effect andF:(id <FKFunction>)function;
@end

@implementation ComapEffectFunction
- (id)initWithEffect:(id <FKEffect>)effect andF:(id <FKFunction>)function {
	if ((self = [super init])) {
		e = [effect retain];
		f = [function retain];
	}
	return self;
}

- (oneway void)e:(id)arg {
	[e e:[f :arg]];
}

- (void)dealloc {
	[e release];
	[f release];
	[super dealloc];
}
@end

#pragma mark FKEffectFromSelector

@interface FKEffectFromSelector : NSObject <FKEffect> {
	SEL selector;
}

READ SEL selector;
- (FKEffectFromSelector *)initWithSelector:(SEL)s;
@end

@implementation FKEffectFromSelector

@synthesize selector;

- (FKEffectFromSelector *)initWithSelector:(SEL)s {
	if ((self = [super init])) {
		selector = s;
	}
	return self;
}

- (void) e:(id)arg {
    [arg performSelector:selector];
}

- (BOOL)isEqual:(id)object {
    return object == nil || ![[object class] isEqual:[self class]] ? NO : FKEqualSelectors(self.selector, ((FKEffectFromSelector *) object).selector);
}

- (NSUInteger)hash {
    return 42;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%s selector: %s>", class_getName([self class]), sel_getName(selector)];
}

@end

#pragma mark FKEffectFromSelectorWithArgument
@interface FKEffectFromSelectorWithArgument : NSObject <FKEffect> {
	SEL selector;
    id argument;
}

READ SEL selector;
READ id argument;
- (FKEffectFromSelectorWithArgument *)initWithSelector:(SEL)s argument:(id)argument;
@end

@implementation FKEffectFromSelectorWithArgument

@synthesize selector, argument;

- (FKEffectFromSelectorWithArgument *)initWithSelector:(SEL)newS argument:(id)newArgument {
	if ((self = [super init])) {
		selector = newS;
        argument = [newArgument retain];
	}
	return self;
}

- (void) e:(id)arg {
    [arg performSelector:selector withObject:argument];
}

- (void) dealloc {
    [argument release];
    [super dealloc];
}

- (BOOL)isEqual:(id)object {
    if (object == nil || ![[object class] isEqual:[self class]]) {
        return NO;
    } else {
        FKEffectFromSelectorWithArgument *other = (FKEffectFromSelectorWithArgument *) object;
        return FKEqualSelectors(self.selector, other.selector) && [self.argument isEqual:other.argument];
    }
}

- (NSUInteger)hash {
    return 42;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%s selector: %s>", class_getName([self class]), sel_getName(selector)];
}

@end

#pragma mark FKEffectFromSelectorWithTarget
@interface FKEffectFromSelectorWithTarget : NSObject <FKEffect> {
	SEL selector;
	NSObject *target;
}
READ SEL selector;
READ NSObject *target;
- (FKEffectFromSelectorWithTarget *)initWithSelector:(SEL)s target:(NSObject *)target;
@end

@implementation FKEffectFromSelectorWithTarget

@synthesize selector, target;

- (FKEffectFromSelectorWithTarget *)initWithSelector:(SEL)s target:(NSObject *)nTarget {
	if (![nTarget respondsToSelector:s]) {
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"target %@ does not respond to selector %s", nTarget, sel_getName(s)] userInfo:EMPTY_DICT];
	}
	if ((self = [super init])) {
		selector = s;
		target = [nTarget retain];
	}
	return self;
}

- (void)e:(id)arg {
    [target performSelector:selector withObject:arg];
}

- (void) dealloc {
    [target release];
    [super dealloc];
}

- (BOOL)isEqual:(id)object {
    if (object == nil || ![[object class] isEqual:[self class]]) {
        return NO;
    } else {
        FKEffectFromSelectorWithTarget *other = (FKEffectFromSelectorWithTarget *) object;
        return FKEqualSelectors(self.selector, other.selector) && [self.target isEqual:other.target];
    }
}

- (NSUInteger)hash {
    return 42;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%s selector: %s; target: %@>", class_getName([self class]), sel_getName(selector), target];
}

@end

#pragma mark FKEffectFromPointer
@interface FKEffectFromPointer : NSObject <FKEffect> {
	fkEffect theEffect;
}
- (FKEffectFromPointer *)initWithPointer:(fkEffect)fp;
@end
@implementation FKEffectFromPointer
- (FKEffectFromPointer *)initWithPointer:(fkEffect)fp {
	if ((self = [super init])) {
		theEffect = fp;
	}
	return self;
}
- (void) e:(id)arg {
	return (*theEffect)(arg);
}
@end

#pragma mark Public interface

@implementation FKEffect
+ (id <FKEffect>)comap:(id <FKEffect>)effect :(id<FKFunction>)function {
	return [[[ComapEffectFunction alloc] initWithEffect:effect andF:function] autorelease];
}

+ (id <FKEffect>)effectFromSelector:(SEL)s {
    return [[[FKEffectFromSelector alloc] initWithSelector:s] autorelease];
}

+ (id <FKEffect>)effectFromSelector:(SEL)s withArgument:(id)argument {
    return [[[FKEffectFromSelectorWithArgument alloc] initWithSelector:s argument:argument] autorelease];
}

+ (id <FKEffect>)effectFromSelector:(SEL)s target:(NSObject *)target {
    return [[[FKEffectFromSelectorWithTarget alloc] initWithSelector:s target:target] autorelease];
}

+ (id <FKEffect>)effectFromPointer:(fkEffect)f {
    return [[[FKEffectFromPointer alloc] initWithPointer:f] autorelease];
}

@end
