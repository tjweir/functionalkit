#import "FKP2.h"
#import <objc/runtime.h>

// TODO Add has, isEqual.

@interface FKP2 (FKP2Private)
@end

@implementation FKP2

@synthesize _1, _2;

+ (FKP2 *)p2With_1:(id)_1 _2:(id)_2 {
    return [[[FKP2 alloc] initWith_1:_1 _2:_2] autorelease];
}

- (void) dealloc {
    [_1 release];
    [_2 release];
    [super dealloc];
}

#pragma mark Private methods.
- (id)initWith_1:(id)new_1 _2:(id)new_2 {
    if (self = [super init]) {
        _1 = [new_1 retain];
        _2 = [new_2 retain];
    }
    return self;
}

#pragma mark NSObject
- (NSString *)description {
	return [NSString stringWithFormat:@"<%s: _1=%@ _2=%@>", class_getName([self class]), _1, _2];
}

@end
