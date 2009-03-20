#import "FKUnit.h"

@implementation FKUnit
//TODO make this a singleton

+ (FKUnit *)unit {
    return [[[FKUnit alloc] init] autorelease];
}

#pragma mark NSObject methods.
- (BOOL)isEqual:(id)object {
    return object == nil || ![[object class] isEqual:[self class]] ? NO : YES;
}

- (NSUInteger)hash {
    return 42;
}

- (NSString *)description {
    return @"<FKUnit>";
}

@end
