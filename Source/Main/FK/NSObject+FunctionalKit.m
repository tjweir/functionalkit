#import "NSObject+FunctionalKit.h"
#import "NSInvocation+FunctionalKit.h"

@implementation NSObject (FunctionalKitExtensions)
- (id)classAsId {
    return (id) [self class];
}
@end
