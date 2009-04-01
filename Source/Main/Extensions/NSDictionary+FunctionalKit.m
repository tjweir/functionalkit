#import "NSDictionary+FunctionalKit.h"
#import "FKP2.h"

@implementation NSDictionary (FunctionalKitExtensions)

- (NSArray *)toArray {
    NSMutableArray *pairs = [NSMutableArray arrayWithCapacity:[self count]];
    for (id key in self) {
        [pairs addObject:p2(key, [self objectForKey:key])];
    }    
    return [NSArray arrayWithArray:pairs];
}

- (FKOption *)maybeObjectForKey:(id)key {
    return [FKOption fromNil:[self objectForKey:key]];
}

@end
