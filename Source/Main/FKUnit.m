#import "MVUnit.h"

@implementation MVUnit

+ (MVUnit *)unit {
    return [[[MVUnit alloc] init] autorelease];
}

#pragma mark NSObject methods.
- (BOOL)isEqual:(id)object {
    return object == nil || ![[object class] isEqual:[MVUnit class]] ? NO : YES;
}

- (NSUInteger)hash {
    return 42;
}

- (NSString *)description {
    return @"<MVUnit>";
}

@end
