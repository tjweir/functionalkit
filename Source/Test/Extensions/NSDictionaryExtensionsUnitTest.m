#import "GTMSenTestCase.h"
#import "FKMacros.h"
#import "FKFunction.h"
#import "NSDictionary+FunctionalKit.h"
#import "FKP2.h"

@interface NSDictionaryExtensions : GTMTestCase
@end

@implementation NSDictionaryExtensions

- (void)testDictionaryToArray {
    NSDictionary *dict = NSDICT(@"v1", @"k1", @"v2", @"k2");
    STAssertEqualObjects(NSARRAY(pair2(@"k1", @"v1"), pair2(@"k2", @"v2")), [dict toArray], nil);
}

- (void)testAskingForANonExistentValueReturnsANone {
    NSDictionary *dict = NSDICT(@"value", @"key");
    STAssertTrue([[dict maybeObjectForKey:@"not_there"] isNone] , nil);
}

- (void)testAskingForANonExistentValueReturnsASomeWithTheValue {
    NSDictionary *dict = NSDICT(@"value", @"key");
    FKOption *maybeValue = [dict maybeObjectForKey:@"key"];
    STAssertTrue([maybeValue isSome] , nil);
    STAssertEqualObjects(@"value", maybeValue.some, nil);
}

@end