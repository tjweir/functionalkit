#import "GTMSenTestCase.h"
#import "FKOption.h"
#import "FKLog.h"

@interface FKOptionUnitTest : GTMTestCase {
    NSObject *object;
}
@end

@implementation FKOptionUnitTest

- (void)setUp {
    object = [[[NSObject alloc] init] autorelease];
}

- (void)testANoneIsNone {
    STAssertTrue([[FKOption none] isNone], nil);
    STAssertFalse([[FKOption none] isSome], nil);
}

- (void)testASomeIsSome {
    STAssertTrue([[FKOption some:object] isSome], nil);
    STAssertFalse([[FKOption some:object] isNone], nil);
}

- (void)testCanPullTheSomeValueOutOfASome {
    STAssertEqualObjects(object, [[FKOption some:object] some], nil);
}

- (void)testTransformsNilsIntoNones {
    STAssertTrue([[FKOption fromNil:nil] isNone], nil);
    STAssertTrue([[FKOption fromNil:object] isSome], nil);
}

- (void)testMaps {
	STAssertTrue([[[FKOption none] mapWithSelector:@selector(description)] isNone], nil);
	NSString *description = [object description];
	FKOption *r = [[FKOption some:object] mapWithSelector:@selector(description)];
	STAssertTrue([r isSome], nil);	
	STAssertEqualObjects([r some], description, nil);
}

- (void)testTypes {
	STAssertTrue([[FKOption fromNil:@"54" ofType:[NSString class]] isSome], nil);
	STAssertTrue([[FKOption fromNil:nil ofType:[NSString class]] isNone], nil);
	STAssertTrue([[FKOption fromNil:@"54" ofType:[NSArray class]] isNone], nil);
}

@end
