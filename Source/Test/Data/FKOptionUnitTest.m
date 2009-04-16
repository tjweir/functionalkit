#import "GTMSenTestCase.h"
#import "FK/FKOption.h"
#import "FK/FKMacros.h"
#import "FK/FKFunction.h"

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
	STAssertTrue([[[FKOption none] map:functionS(description)] isNone], nil);
	NSString *description = [object description];
	FKOption *r = [[FKOption some:object] map:functionS(description)];
	STAssertTrue([r isSome], nil);	
	STAssertEqualObjects([r some], description, nil);
}

- (void)testTypes {
	STAssertTrue([[FKOption fromNil:@"54" ofType:[NSString class]] isSome], nil);
	STAssertTrue([[FKOption fromNil:nil ofType:[NSString class]] isNone], nil);
	STAssertTrue([[FKOption fromNil:@"54" ofType:[NSArray class]] isNone], nil);
}

- (void)testBindingAcrossANoneGivesANone {
    id result = [[FKOption none] bind:functionTS(self, givesANone:)];
    STAssertTrue([result isKindOfClass:[FKOption class]], nil);
    STAssertTrue([result isNone], nil);
}

- (void)testBindingAcrossASomeWithANoneGivesANone {
    id result = [[FKOption some:@"foo"] bind:functionTS(self, givesANone:)];
    STAssertTrue([result isKindOfClass:[FKOption class]], nil);
    STAssertTrue([result isNone], nil);
}

- (void)testBindingAcrossASomeWithASomeGivesANone {
    id result = [[FKOption some:@"foo"] bind:functionTS(self, givesASome:)];
    STAssertTrue([result isKindOfClass:[FKOption class]], nil);
    STAssertTrue([result isSome], nil);
    STAssertEqualObjects(@"foo", [result some], nil);
}

- (void)testSomes {
	NSArray *options = NSARRAY([FKOption some:@"54"], [FKOption none]);
	NSArray *somes = [FKOption somes:options];
	STAssertEqualObjects(NSARRAY(@"54"), somes, nil);
}

- (FKOption *)givesANone:(NSString *)str {
    return [FKOption none];
}

- (FKOption *)givesASome:(NSString *)str {
    return [FKOption some:str];
}

@end
