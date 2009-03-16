#import "FKFunction.h"

@interface FKFunctionFromSelector : NSObject <FKFunction> {
	SEL selector;
}
- (FKFunctionFromSelector *)initWithSelector:(SEL)s;
@end

@implementation FKFunctionFromSelector
- (FKFunctionFromSelector *)initWithSelector:(SEL)s {
	if ((self = [super init])) {
		selector = s;
	}
	return self;
}

- (id):(id)arg {
	return [arg performSelector:selector];
}
@end

@interface FKFunctionFromSelectorWithTarget : NSObject <FKFunction> {
	SEL selector;
	NSObject *target;
}
- (FKFunctionFromSelectorWithTarget *)initWithSelector:(SEL)s target:(NSObject *)target;
@end

@implementation FKFunctionFromSelectorWithTarget
- (FKFunctionFromSelectorWithTarget *)initWithSelector:(SEL)s target:(NSObject *)nTarget {
	if (![nTarget respondsToSelector:s]) {
		@throw [NSException exceptionWithName:@"InvalidOperation" reason:[NSString stringWithFormat:@"target %@ does not respond to selector %s", nTarget, sel_getName(s)] userInfo:[NSDictionary dictionary]];
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
@end

@implementation FKFunction
+ (id <FKFunction>)functionFromSelector:(SEL)s {
	return [[[FKFunctionFromSelector alloc] initWithSelector:s] autorelease];
}
+ (id <FKFunction>)functionFromSelector:(SEL)s target:(NSObject *)target {
	return [[[FKFunctionFromSelectorWithTarget alloc] initWithSelector:s target:target] autorelease];
}
@end

