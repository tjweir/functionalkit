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

@end