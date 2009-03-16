#import "GTMSenTestCase.h"
#import "NSArray+FunctionalKit.h"
#import "FKMacros.h"

@interface NSArray (extns)
- (BOOL)isNotEmpty;
@end

@implementation NSArray (extns)
- (BOOL)isNotEmpty {
    return [self count] != 0;
}
@end

@interface NSArrayTests : GTMTestCase
@end

@implementation NSArrayTests
- (void)testAll {
	BOOL r = [NSARRAY(NSARRAY(@"1")) all:@selector(isNotEmpty)];
	STAssertTrue(r, nil);
	BOOL v = [NSARRAY(EMPTY_ARRAY) all:@selector(isNotEmpty)];
	STAssertFalse(v, nil);
}

- (void)testMap {
	STAssertEqualObjects([NSARRAY(@"test") map:[FKFunction functionFromSelector:@selector(uppercaseString)]], NSARRAY(@"TEST"), nil); 
}
@end

