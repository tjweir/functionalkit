#import "FKP5.h"
#import <objc/runtime.h>

@implementation FKP5

@synthesize _1, _2, _3, _4, _5;

+ (FKP5 *)p5With_1:(id)_1 _2:(id)_2 _3:(id)_3 _4:(id)_4 _5:(id)_5 {
    return [[[FKP5 alloc] initWith_1:_1 _2:_2 _3:_3 _4:_4 _5:_5] autorelease];
}

- (void)dealloc {
    [_1 release];
    [_2 release];
    [_3 release];
    [_4 release];
    [_5 release];
    [super dealloc];
}

#pragma mark Private methods.
- (id)initWith_1:(id)new_1 _2:(id)new_2 _3:(id)new_3 _4:(id)new_4 _5:(id)new_5 {
    if (self = [super init]) {
        _1 = [new_1 retain];
        _2 = [new_2 retain];
        _3 = [new_3 retain];
        _4 = [new_4 retain];
        _5 = [new_5 retain];
    }
    return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"<%s: _1=%@ _2=%@ _3=%@ _4=%@ _5=%@>", class_getName([self class]), _1, _2, _3, _4, _5];
}

#pragma mark NSObject methods.
- (BOOL)isEqual:(id)object {
    if (object == nil || ![[object class] isEqual:[self class]]) {
        return NO;
    } else {
        FKP5 *other = (FKP5 *)object;
		return [_1 isEqual:other._1] && [_2 isEqual:other._2] && [_3 isEqual:other._3] && [_4 isEqual:other._4] && [_5 isEqual:other._5];
    }
}

- (NSUInteger)hash {
    return [_1 hash] + [_2 hash] + [_3 hash] + [_4 hash] + [_5 hash];
}

#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone {
	return [self retain];
}
@end
