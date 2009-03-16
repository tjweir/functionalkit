#import "MVP3.h"
#import <objc/runtime.h>

@interface MVP3 (MVP3Private)
@end

@implementation MVP3

@synthesize _1, _2, _3;

+ (MVP3 *)p3With_1:(id)_1 _2:(id)_2 _3:(id)_3 {
    return [[[MVP3 alloc] initWith_1:_1 _2:_2 _3:_3] autorelease];
}

- (void) dealloc {
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

#pragma mark NSObject
- (NSString *)description {
	return [NSString stringWithFormat:@"<%s: _1=%@ _2=%@ _3=%@>", class_getName([self class]), _1, _2, _3];
}

@end
