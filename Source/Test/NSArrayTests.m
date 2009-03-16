#import "GTMSenTestCase.h"
#import "NSArray+Motive.h"
#import "MVMacros.h"

@interface NSArrayTests : GTMTestCase
@end

@implementation NSArrayTests
- (void)testAll {
	BOOL r = [NSARRAY(NSARRAY(@"1")) all:@selector(isNotEmpty)];
	STAssertTrue(r, nil);
	BOOL v = [NSARRAY([NSArray array]) all:@selector(isNotEmpty)];
	STAssertFalse(v, nil);
}

- (void)testMap {
	STAssertEqualObjects([NSARRAY(@"test") map:[FKFunction functionFromSelector:@selector(uppercaseString)]], NSARRAY(@"TEST"), nil); 
}
@end

