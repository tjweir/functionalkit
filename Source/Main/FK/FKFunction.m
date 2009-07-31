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

#pragma mark FKFunction2FromSelector
@interface FKFunction2FromSelector : FKFunction2 {
	SEL selector;
}

READ SEL selector;
- (FKFunction2FromSelector *)initWithSelector:(SEL)s;
@end

@implementation FKFunction2FromSelector

@synthesize selector;

- (FKFunction2FromSelector *)initWithSelector:(SEL)s {
	if ((self = [super init])) {
		selector = s;
	}
	return self;
}

- (id):(id)arg1 :(id)arg2 {
	return [arg1 performSelector:selector withObject:arg2];
}

- (BOOL)isEqual:(id)object {
    return object == nil || ![[object class] isEqual:[self class]] ? NO : FKEqualSelectors(self.selector, ((FKFunction2FromSelector *) object).selector);
}

- (NSUInteger)hash {
    return 42;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%s selector: %s>", class_getName([self class]), sel_getName(selector)];
}

@end

#pragma mark FKFunctionFromSelectorWithArgument
@interface FKFunctionFromSelectorWithArgument : FKFunction {
	SEL selector;
    id argument;
}

READ SEL selector;
READ id argument;
- (FKFunctionFromSelectorWithArgument *)initWithSelector:(SEL)s argument:(id)argument;
@end

@implementation FKFunctionFromSelectorWithArgument

@synthesize selector, argument;

- (FKFunctionFromSelectorWithArgument *)initWithSelector:(SEL)newS argument:(id)newArgument {
	if ((self = [super init])) {
		selector = newS;
        argument = [newArgument retain];
	}
	return self;
}

- (id):(id)arg {
	return [arg performSelector:selector withObject:argument];
}

- (void) dealloc {
    [argument release];
    [super dealloc];
}

- (BOOL)isEqual:(id)object {
    if (object == nil || ![[object class] isEqual:[self class]]) {
        return NO;
    } else {
        FKFunctionFromSelectorWithArgument *other = (FKFunctionFromSelectorWithArgument *) object;
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

@interface FKFunction2FromPointer : FKFunction2 {
	fkFunction2 theFunction;
}
- (FKFunction2 *)initWithPointer2:(fkFunction2)fp;
@end
@implementation FKFunction2FromPointer
- (FKFunction2 *)initWithPointer2:(fkFunction2)fp {
	if ((self = [super init])) {
		theFunction = fp;
	}
	return self;
}
- (id):(id)arg1 :(id)arg2 {
	return (*theFunction)(arg1, arg2);
}
@end

#pragma mark FKFunctionFromInvocation
@interface FKFunctionFromInvocation : FKFunction {
	NSInvocation *invocation;
	NSUInteger index;
}
- (FKFunction *)initWithInvocation:(NSInvocation *)inv parameterIndex:(NSUInteger)idx;
@end

@implementation FKFunctionFromInvocation
- (FKFunction *)initWithInvocation:(NSInvocation *)inv parameterIndex:(NSUInteger)idx {
	if ((self = [super init])) {
		NSLog(@"inv: %@", inv);
		invocation = [inv retain];
		index = idx;
	}
	return self;
}
- (id):(id)arg {
	[invocation setArgument:&arg atIndex:(index + 2)];
	[invocation invoke];
	id anObject;
	[invocation getReturnValue:&anObject];
	return anObject;
}
- (void)dealloc {
	[invocation release];
	[super dealloc];
}

@end

@implementation FKFunction

+ (FKFunction *)functionFromSelector:(SEL)s {
	return [[[FKFunctionFromSelector alloc] initWithSelector:s] autorelease];
}

+ (FKFunction *)functionFromSelector:(SEL)s withArgument:(id)argument {
	return [[[FKFunctionFromSelectorWithArgument alloc] initWithSelector:s argument:argument] autorelease];
}

+ (FKFunction *)functionFromSelector:(SEL)s target:(NSObject *)target {
	return [[[FKFunctionFromSelectorWithTarget alloc] initWithSelector:s target:target] autorelease];
}

+ (FKFunction *)functionFromPointer:(fkFunction)f {
	return [[[FKFunctionFromPointer alloc] initWithPointer:f] autorelease];
}

+ (FKFunction *)functionFromInvocation:(NSInvocation *)invocation parameterIndex:(NSUInteger)index {
	return [[[FKFunctionFromInvocation alloc] initWithInvocation:invocation parameterIndex:index] autorelease];	
}

- (id):(id)arg {
	@throw [NSException exceptionWithName:@"InvalidOperation" reason:@"Must override -(id):(id) in FKFunction" userInfo:nil];
}

- (FKFunction *)andThen:(FKFunction *)other {
	return [other composeWith:self];
}

- (FKFunction *)composeWith:(FKFunction *)other {
	return [[[FKFunctionComposition alloc] initWithF:self andG:other] autorelease];
}
@end

@implementation FKFunction2

+ (FKFunction2 *)functionFromSelector:(SEL)s {
	return [[[FKFunction2FromSelector alloc] initWithSelector:s] autorelease];
}

+ (FKFunction2 *)functionFromPointer:(fkFunction2)f {
	return [[[FKFunction2FromPointer alloc] initWithPointer2:f] autorelease];
}

- (id):(id)arg1 :(id)arg2 {
    @throw [NSException exceptionWithName:@"InvalidOperation" reason:@"Must override -(id):(id):(id) in FKFunction2" userInfo:nil];
}    

@end


