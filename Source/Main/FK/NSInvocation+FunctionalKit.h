#import <Foundation/Foundation.h>

@interface NSInvocation (FunctionalKit)
+ (NSInvocation *)invocationWithSelector:(SEL)s target:(id)target arguments:(NSArray *)arguments;
@end
