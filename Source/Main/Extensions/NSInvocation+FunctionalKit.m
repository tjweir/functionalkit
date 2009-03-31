#import "NSInvocation+FunctionalKit.h"

@implementation NSInvocation (FunctionalKit)
+ (NSInvocation *)invocationWithSelector:(SEL)s target:(id)target arguments:(NSArray *)arguments {
	NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:s]];
	[inv setTarget:target];
	[inv setSelector:s];
	int i = 0;
	for (id arg in arguments) {
		if (!([arg isKindOfClass:[NSNull class]])) {
			[inv setArgument:&arg atIndex:(i + 2)]; // +2 offset for self,_cmd args
		}
		++i;
	}
	[inv retainArguments];
	return inv;
}
@end