#import "GTMSenTestCase.h"
#import "FKMacros.h"
#import "FKFunction.h"
#import "NSArray+FunctionalKit.h"

@interface NSArray (extns)
- (BOOL)isNotEmpty;
@end

@implementation NSArray (extns)
- (BOOL)isNotEmpty {
    return [self count] != 0;
}
@end

@interface NSArrayExtensionsUnitTest : GTMTestCase
@end

@implementation NSArrayExtensionsUnitTest

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

- (void)testCanMapAFunctionAcrossAnArray {
	STAssertEqualObjects([NSARRAY(@"test") map:functionS(uppercaseString)], NSARRAY(@"TEST"), nil); 
}

- (BOOL)isStringContainingOne:(id)string {
    return [string isEqual:@"1"];
}

@end
