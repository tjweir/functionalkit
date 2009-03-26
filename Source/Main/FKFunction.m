#import "FKFunction.h"
#import "FKMacros.h"

#pragma mark FKFunctionFromSelector
@interface FKFunctionFromSelector : FKFunction {
	SEL selector;
}

READ SEL selector;
- (FKFunctionFromSelector *)initWithSelector:(SEL)s;
@end

@implementation FKFunctionFromSelector

@synthesize selector;

- (FKFunctionFromSelector *)initWithSelector:(SEL)s {
	if ((self = [super init])) {
		selector = s;
	}
	return self;
}

- (id):(id)arg {
	return [arg performSelector:selector];
}

#pragma mark NSObject methods.
- (BOOL)isEqual:(id)object {
    return object == nil || ![[object class] isEqual:[self class]] ? NO : FKEqualSelectors(self.selector, ((FKFunctionFromSelector *) object).selector);
}

- (NSUInteger)hash {
    return 42;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%s selector: %s>", class_getName([self class]), sel_getName(selector)];
}

@end

#pragma mark FKFunctionFromSelectorWithTarget
@interface FKFunctionFromSelectorWithTarget : FKFunction {
	SEL selector;
	NSObject *target;
}
READ SEL selector;
READ NSObject *target;
- (FKFunctionFromSelectorWithTarget *)initWithSelector:(SEL)s target:(NSObject *)target;
@end

@implementation FKFunctionFromSelectorWithTarget

@synthesize selector, target;

- (FKFunctionFromSelectorWithTarget *)initWithSelector:(SEL)s target:(NSObject *)nTarget {
	if (![nTarget respondsToSelector:s]) {
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"target %@ does not respond to selector %s", nTarget, sel_getName(s)] userInfo:EMPTY_DICT];
	}
	if ((self = [super init])) {
		selector = s;
		target = [nTarget retain];
	}
	return self;
}

- (id):(id)arg {
	return [target performSelector:selector withObject:arg];
}

#pragma mark NSObject methods.
- (void) dealloc {
    [target release];
    [super dealloc];
}

- (BOOL)isEqual:(id)object {
    if (object == nil || ![[object class] isEqual:[self class]]) {
        return NO;
    } else {
        FKFunctionFromSelectorWithTarget *other = (FKFunctionFromSelectorWithTarget *) object;
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

#pragma mark FKFunctionComposition
@interface FKFunctionComposition : FKFunction {
	FKFunction *f;
	FKFunction *g;
}

- (FKFunctionComposition *)initWithF:(FKFunction *)anF andG:(FKFunction *)aG;
@end

@implementation FKFunctionComposition

- (FKFunctionComposition *)initWithF:(FKFunction *)anF andG:(FKFunction *)aG {
	if ((self = [super init])) {
		f = [anF retain];
		g = [aG retain];
	}
	return self;
}

- (void)dealloc {
	[f release];
	[g release];
	[super dealloc];
}

- (id):(id)arg {
	return [f :[g :arg]];
}

@end

#pragma mark FKFunctionFromPointer
@interface FKFunctionFromPointer : FKFunction {
	fkFunction theFunction;
}
- (FKFunction *)initWithPointer:(fkFunction)fp;
@end

@implementation FKFunctionFromPointer
- (FKFunction *)initWithPointer:(fkFunction)fp {
	if ((self = [super init])) {
		theFunction = fp;
	}
	return self;
}
- (id):(id)arg {
	return (*theFunction)(arg);
}
@end

@implementation FKFunction
+ (FKFunction *)functionFromSelector:(SEL)s {
	return [[[FKFunctionFromSelector alloc] initWithSelector:s] autorelease];
}
+ (FKFunction *)functionFromSelector:(SEL)s target:(NSObject *)target {
	return [[[FKFunctionFromSelectorWithTarget alloc] initWithSelector:s target:target] autorelease];
}

+ (FKFunction *)functionFromPointer:(fkFunction)f {
	return [[FKFunctionFromPointer alloc] initWithPointer:f];
}

- (id):(id)arg {
	@throw [NSException exceptionWithName:@"InvalidOperation" reason:@"Must override -(id):(id) in FKFunction" userInfo:nil];
}

- (FKFunction *)andThen:(FKFunction *)other {
	return [other composeWith:self];
}

- (FKFunction *)composeWith:(FKFunction *)other {
	return [[FKFunctionComposition alloc] initWithF:self andG:other];
}
@end

