#import "GTMSenTestCase.h"
#import "FKMacros.h"
#import "FKFunction.h"
#import "NSArray+FunctionalKit.h"
#import "FKP2.h"

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

- (BOOL)isStringContainingOne:(id)string {
    return [string isEqual:@"1"];
}

@end
