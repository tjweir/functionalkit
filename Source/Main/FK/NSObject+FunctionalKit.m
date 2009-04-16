#import "NSObject+FunctionalKit.h"
#import "NSInvocation+FunctionalKit.h"

@implementation NSObject (FunctionalKitExtensions)
- (id)classAsId {
    return (id) [self class];
}

- (FKFunction *)functionForSelector:(SEL)selector arguments:(NSArray *)args applyIndex:(NSUInteger)i {
	NSInvocation *inv = [NSInvocation invocationWithSelector:selector target:self arguments:args];
	return [FKFunction functionFromInvocation:inv parameterIndex:i];
}
@end
