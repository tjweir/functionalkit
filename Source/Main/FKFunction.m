#import "FKFunction.h"
#import "MVMacros.h"
#import "FKMacros.h"

@interface FKFunctionFromSelector : NSObject <FKFunction> {
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
    return object == nil || ![[object class] isEqual:[FKFunctionFromSelector class]] ? NO : FKEqualSelectors(self.selector, ((FKFunctionFromSelector *) object).selector);
}

- (NSUInteger)hash {
    return 42;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ selector: %s>", [self className], sel_getName(selector)];
}

@end

@interface FKFunctionFromSelectorWithTarget : NSObject <FKFunction> {
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
    if (object == nil || ![[object class] isEqual:[FKFunctionFromSelectorWithTarget class]]) {
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
    return [NSString stringWithFormat:@"<%@ selector: %s; target: %@>", [self className], sel_getName(selector), target];
}

@end

@implementation FKFunction
+ (id <FKFunction>)functionFromSelector:(SEL)s {
	return [[[FKFunctionFromSelector alloc] initWithSelector:s] autorelease];
}
+ (id <FKFunction>)functionFromSelector:(SEL)s target:(NSObject *)target {
	return [[[FKFunctionFromSelectorWithTarget alloc] initWithSelector:s target:target] autorelease];
}
@end

