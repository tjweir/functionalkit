#import "GTMSenTestCase.h"
#import "FK/FKEither.h"
#import "FK/FKOption.h"
#import "FKFunction.h"

@interface FKEitherUnitTest : GTMTestCase {
    NSObject *o1;
    NSObject *o2;
}
@end

@implementation FKEitherUnitTest

- (void)setUp {
    o1 = [[[NSObject alloc] init] autorelease];
    o2 = [[[NSObject alloc] init] autorelease];
}

- (void)testALeftIsLeft {
    FKEither *leftEither = [FKEither leftWithValue:o1];
    FKLeftProjection *left = leftEither.left;
    STAssertTrue(leftEither.isLeft, nil);
    STAssertFalse(leftEither.isRight, nil);
    STAssertEqualObjects(o1, left.value, nil);
}

- (void)testARightIsRight {
    FKEither *rightEither = [FKEither rightWithValue:o1];
    FKRightProjection *right = rightEither.right;
    STAssertTrue(rightEither.isRight, nil);
    STAssertFalse(rightEither.isLeft, nil);
    STAssertEqualObjects(o1, right.value, nil);
}

- (void)testTwoLeftsWithEqualValuesAreEqual {
    FKEither *l1 = [FKEither leftWithValue:o1];
    FKEither *l2 = [FKEither leftWithValue:o1];
    STAssertEqualObjects(l1, l2, nil);
}

- (void)testTwoRightsWithEqualValuesAreEqual {
    FKEither *r1 = [FKEither rightWithValue:o1];
    FKEither *r2 = [FKEither rightWithValue:o1];
    STAssertEqualObjects(r1, r2, nil);
}

- (void)testTwoLeftsWithUnEqualValuesAreNotEqual {
    FKEither *l1 = [FKEither leftWithValue:o1];
    FKEither *l2 = [FKEither leftWithValue:o2];
    STAssertNotEqualObjects(l1, l2, nil);
}

- (void)testTwoRightsWithUnEqualValuesAreNotEqual {
    FKEither *r1 = [FKEither rightWithValue:o1];
    FKEither *r2 = [FKEither rightWithValue:o2];
    STAssertNotEqualObjects(r1, r2, nil);
}

- (void)testALeftAndARightAreNotEqual {
    FKEither *l = [FKEither leftWithValue:o1];
    FKEither *r = [FKEither rightWithValue:o1];
    STAssertNotEqualObjects(l, r, nil);
}

- (void)testAccessingTheRightValueInLeftThrowsAnError {
    FKEither *l = [FKEither leftWithValue:o1];
    @try {
        l.right.value;
        STFail(@"Expected an exception to be thrown");
    }
    @catch (id exception) {
    }
}

- (void)testAccessingTheLeftValueInLeftThrowsAnError {
    FKEither *r = [FKEither rightWithValue:o1];
    @try {
        r.left.value;
        STFail(@"Expected an exception to be thrown");
    }
    @catch (id exception) {
    }
}

- (void)testAccessingTheLeftOrValue {
	FKEither *left = [FKEither leftWithValue:o1];
	FKEither *right = [FKEither rightWithValue:o1];
	STAssertEqualObjects([left.right orValue:@"54"], @"54", nil);
	STAssertEqualObjects([right.left orValue:@"54"], @"54", nil);
	STAssertEqualObjects([left.left orValue:@"54"], o1, nil);
	STAssertEqualObjects([right.right orValue:@"54"], o1, nil);
}

- (void)testMappingAcrossTheLeft {
	FKEither *either = [FKEither leftWithValue:[NSNumber numberWithInt:54]];
	FKEither *mapped = [either.left map:functionS(description)];
	STAssertTrue(mapped.isLeft,nil);
	STAssertEqualObjects(mapped.left.value, @"54",nil);
}

- (void)testMappingAcrossTheRightOfALeftIsIdentity {
	FKEither *either = [FKEither leftWithValue:[NSNumber numberWithInt:54]];
	FKEither *mapped = [either.right map:functionS(description)];
	STAssertEqualObjects(either, mapped, nil);
}

- (void)testMappingAcrossTheRight {
	FKEither *either = [FKEither rightWithValue:[NSNumber numberWithInt:54]];
	FKEither *mapped = [either.right map:functionS(description)];
	STAssertTrue(mapped.isRight,nil);
	STAssertEqualObjects(mapped.right.value, @"54",nil);	
}

- (void)testMappingAcrossTheLeftOfARightIsIdentity {
	FKEither *either = [FKEither rightWithValue:[NSNumber numberWithInt:54]];
	FKEither *mapped = [either.left map:functionS(description)];
	STAssertEqualObjects(either, mapped, nil);
}

- (void)testMappingUsingF {
	FKEither *either = [FKEither rightWithValue:[NSNumber numberWithInt:54]];
	FKEither *mapped = [either.right map:[FKFunction functionFromSelector:@selector(description)]];
	STAssertEqualObjects(mapped.right.value, @"54", nil);
}

- (void)testToOption {
	FKEither *either = [FKEither rightWithValue:@"v"];
	STAssertTrue([[either.right toOption] isSome], nil);
	STAssertTrue([[either.left toOption] isNone], nil);
}

- (void)testBindLeftConcatentatesToProduceASingleEither {
	FKEither *either = [FKEither leftWithValue:@"v"];
    FKEither *afterBind = [either.left bind:functionTS(self, toLeft:)];
    STAssertEqualObjects(either, afterBind, nil);
}

- (void)testBindRightConcatentatesToProduceASingleEither {
	FKEither *either = [FKEither rightWithValue:@"v"];
    FKEither *afterBind = [either.right bind:functionTS(self, toRight:)];
    STAssertEqualObjects(either, afterBind, nil);
}

- (void)testRightJoin {
    FKEither *fullRight = [FKEither rightWithValue:[FKEither rightWithValue:@"right"]];
    FKEither *firstLeft = [FKEither leftWithValue:@"left"];
    FKEither *secondLeft = [FKEither rightWithValue:[FKEither leftWithValue:@"left"]];
    
    STAssertEqualObjects([FKEither joinRight:fullRight], [FKEither rightWithValue:@"right"], nil);
    STAssertEqualObjects([FKEither joinRight:firstLeft], [FKEither leftWithValue:@"left"], nil);
    STAssertEqualObjects([FKEither joinRight:secondLeft], [FKEither leftWithValue:@"left"], nil);
}

- (FKEither *)toLeft:(NSString *)string {
    return [FKEither leftWithValue:string];
}

- (FKEither *)toRight:(NSString *)string {
    return [FKEither rightWithValue:string];
}

@end
