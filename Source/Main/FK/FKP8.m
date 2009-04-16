#import "FKP8.h"
#import <objc/runtime.h>

@implementation FKP8

@synthesize _1, _2, _3, _4, _5, _6, _7, _8;

+ (FKP8 *)p8With_1:(id)_1 _2:(id)_2 _3:(id)_3 _4:(id)_4 _5:(id)_5 _6:(id)_6 _7:(id)_7 _8:(id)_8 {
    return [[[FKP8 alloc] initWith_1:_1 _2:_2 _3:_3 _4:_4 _5:_5 _6:_6 _7:_7 _8:_8] autorelease];
}

- (void)dealloc {
    [_1 release];
    [_2 release];
    [_3 release];
    [_4 release];
    [_5 release];
    [_6 release];
    [_7 release];
    [_8 release];
    [super dealloc];
}

#pragma mark Private methods.
- (id)initWith_1:(id)new_1 _2:(id)new_2 _3:(id)new_3 _4:(id)new_4 _5:(id)new_5 _6:(id)new_6 _7:(id)new_7 _8:(id)new_8 {
    if (self = [super init]) {
        _1 = [new_1 retain];
        _2 = [new_2 retain];
        _3 = [new_3 retain];
        _4 = [new_4 retain];
        _5 = [new_5 retain];
        _6 = [new_6 retain];
        _7 = [new_7 retain];
        _8 = [new_8 retain];
    }
    return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"<%s: _1=%@ _2=%@ _3=%@ _4=%@ _5=%@ _6=%@ _7=%@ _8=%@>", class_getName([self class]), _1, _2, _3, _4, _5, _6, _7, _8];
}

#pragma mark NSObject methods.
- (BOOL)isEqual:(id)object {
    if (object == nil || ![[object class] isEqual:[self class]]) {
        return NO;
    } else {
        FKP8 *other = (FKP8 *)object;
		return [_1 isEqual:other._1] && [_2 isEqual:other._2] && [_3 isEqual:other._3] && [_4 isEqual:other._4] && [_5 isEqual:other._5] && [_6 isEqual:other._6] && [_7 isEqual:other._7] && [_8 isEqual:other._8];
    }
}

- (NSUInteger)hash {
    return [_1 hash] + [_2 hash] + [_3 hash] + [_4 hash] + [_5 hash] + [_6 hash] + [_7 hash] + [_8 hash];
}

#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone {
	return [self retain];
}
@end
