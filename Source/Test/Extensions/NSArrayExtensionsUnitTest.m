#import "GTMSenTestCase.h"
#import "FKMacros.h"
#import "FKFunction.h"
#import "NSArray+FunctionalKit.h"
#import "FKP2.h"
#import "NSString+FunctionalKit.h"

@interface NSArrayExtensionsUnitTest : GTMTestCase
@end

@implementation NSArrayExtensionsUnitTest

- (void)testCanGetTheHeadOfAnArray {
    NSArray *source = NSARRAY(@"1", @"2", @"3", @"4");
    STAssertEqualObjects(@"1", source.head, nil);
}

- (void)testCanGetTheTailOfAnArray {
    NSArray *source = NSARRAY(@"1", @"2", @"3", @"4");
    STAssertEqualObjects(NSARRAY(@"2", @"3", @"4"), source.tail, nil);
}

- (void)testCanGetASpanMatchingAPredicate {
    NSArray *source = NSARRAY(@"1", @"1", @"2", @"4");
    FKP2 *span = [source span:functionTS(self, isStringContainingOne:)];
    STAssertEqualObjects([FKP2 p2With_1:NSARRAY(@"1", @"1") _2:NSARRAY(@"2", @"4")], span, nil);
}

- (void)testCanTestAPredicateAgainstAllItems {
    NSArray *source = NSARRAY(@"1", @"1");
    BOOL allOnes = [source all:functionTS(self, isStringContainingOne:)];
    STAssertTrue(allOnes, nil);
}

- (void)testCanFilterUsingAPredicate {
    NSArray *source = NSARRAY(@"1", @"1", @"2", @"1");
    NSArray *onlyOnes = [source filter:functionTS(self, isStringContainingOne:)];
    STAssertEqualObjects(NSARRAY(@"1", @"1", @"1"), onlyOnes, nil);
}

- (void)testCanGroupItemsUsingAKeyFunctionIntoADictionary {
    NSArray *source = NSARRAY(@"1", @"1", @"2", @"1", @"3", @"3", @"4");
    NSDictionary *grouped = [source groupByKey:functionS(description)];
    STAssertEqualObjects(NSDICT(NSARRAY(@"1", @"1", @"1"), @"1", NSARRAY(@"2"), @"2", NSARRAY(@"3", @"3"), @"3", NSARRAY(@"4"), @"4"), grouped, nil);
}

- (void)testCanMapAFunctionAcrossAnArray {
	STAssertEqualObjects([NSARRAY(@"test") map:functionS(uppercaseString)], NSARRAY(@"TEST"), nil); 
}

- (void)testCanCreateANewArrayByConcatenatingAnotherOne {
    NSArray *source = NSARRAY(NSARRAY(@"1", @"2"), NSARRAY(@"3", @"4"));
    STAssertEqualObjects(NSARRAY(@"1", @"2", @"3", @"4"), [NSArray concat:source], nil);     
}

- (void)testConcatFailsOnNonArray {
    NSArray *source = NSARRAY(NSARRAY(@"1", @"2"), @"3");
    @try {
        [NSArray concat:source];
        STFail(@"Expected concat to fail with no-array argument", nil);
    }
    @catch (NSException * e) {
        // expected
    }
}

- (void)testCanLiftAFunctionIntoAnArray {
    NSArray *array = NSARRAY(@"a", @"b", @"c");
    id <FKFunction> liftedF = [NSArray liftFunction:functionS(uppercaseString)];
    STAssertEqualObjects(NSARRAY(@"A", @"B", @"C"), [liftedF :array], nil);
}

- (void)testCanIntersperseAnObjectWithinAnArray {
    NSArray *array = NSARRAY(@"A", @"B", @"C");
    STAssertEqualObjects(NSARRAY(@"A", @",", @"B", @",", @"C"), [array intersperse:@","], nil);
}

- (void)testCanFoldAcrossAnArray {
    NSArray *array = NSARRAY(@"A", @"B", @"C");
    STAssertEqualObjects(@"ABC", [array foldLeft:@"" f:[NSString concatF]], nil);
}

- (void)testCanReverseAnArray {
    NSArray *array = NSARRAY(@"A", @"B", @"C");
    STAssertEqualObjects(NSARRAY(@"C", @"B", @"A"), [array reverse], nil);
}

- (void)testCanUniquifyAnArray {
    NSArray *array = NSARRAY(@"A", @"B", @"C", @"C", @"A", @"A", @"B");
    STAssertEqualObjects(NSARRAY(@"B", @"A", @"C"), [array unique], nil);
}

- (BOOL)isStringContainingOne:(id)string {
    return [string isEqual:@"1"];
}

@end
