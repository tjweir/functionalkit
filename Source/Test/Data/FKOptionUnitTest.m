#import "GTMSenTestCase.h"
#import "MVOption.h"
#import "MVLog.h"

@interface MVOptionUnitTest : GTMTestCase {
    NSObject *object;
}
@end

@implementation MVOptionUnitTest

- (void)setUp {
    object = [[[NSObject alloc] init] autorelease];
}

- (void)testANoneIsNone {
    STAssertTrue([[MVOption none] isNone], nil);
    STAssertFalse([[MVOption none] isSome], nil);
}

- (void)testASomeIsSome {
    STAssertTrue([[MVOption some:object] isSome], nil);
    STAssertFalse([[MVOption some:object] isNone], nil);
}

- (void)testCanPullTheSomeValueOutOfASome {
    STAssertEqualObjects(object, [[MVOption some:object] some], nil);
}

- (void)testTransformsNilsIntoNones {
    STAssertTrue([[MVOption fromNil:nil] isNone], nil);
    STAssertTrue([[MVOption fromNil:object] isSome], nil);
}

- (void)testMaps {
	STAssertTrue([[[MVOption none] mapWithSelector:@selector(description)] isNone], nil);
	NSString *description = [object description];
	MVOption *r = [[MVOption some:object] mapWithSelector:@selector(description)];
	STAssertTrue([r isSome], nil);	
	STAssertEqualObjects([r some], description, nil);
}

- (void)testTypes {
	STAssertTrue([[MVOption fromNil:@"54" ofType:[NSString class]] isSome], nil);
	STAssertTrue([[MVOption fromNil:nil ofType:[NSString class]] isNone], nil);
	STAssertTrue([[MVOption fromNil:@"54" ofType:[NSArray class]] isNone], nil);
}

@end
