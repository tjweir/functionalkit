#import "GTMSenTestCase.h"
#import "FKBlocks.h"

@interface FKFunctionCommonTests : GTMTestCase
@end

@implementation FKFunctionCommonTests
- (void)testIdentity {
	STAssertEqualObjects(@"54", [F identity](@"54"), nil);
}

- (void)testConst {
	STAssertEqualObjects(@"54", [F const:@"54"](@"wat"), nil);
}

@end

