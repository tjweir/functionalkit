#import "FKP3.h"
#import <objc/runtime.h>

@implementation FKP3

@synthesize _1, _2, _3;

+ (FKP3 *)p3With_1:(id)_1 _2:(id)_2 _3:(id)_3 {
    return [[[FKP3 alloc] initWith_1:_1 _2:_2 _3:_3] autorelease];
}

- (void)dealloc {
    [_1 release];
    [_2 release];
    [_3 release];
    [super dealloc];
}

#pragma mark Private methods.
- (id)initWith_1:(id)new_1 _2:(id)new_2 _3:(id)new_3 {
    if (self = [super init]) {
        _1 = [new_1 retain];
        _2 = [new_2 retain];
        _3 = [new_3 retain];
    }
    return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"<%s: _1=%@ _2=%@ _3=%@>", class_getName([self class]), _1, _2, _3];
}

#pragma mark NSObject methods.
- (BOOL)isEqual:(id)object {
    if (object == nil || ![[object class] isEqual:[self class]]) {
        return NO;
    } else {
        FKP3 *other = (FKP3 *)object;
		return [_1 isEqual:other._1] && [_2 isEqual:other._2] && [_3 isEqual:other._3];
    }
}

- (NSUInteger)hash {
    return [_1 hash] + [_2 hash] + [_3 hash];
}

#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone {
	return [self retain];
}
@end
