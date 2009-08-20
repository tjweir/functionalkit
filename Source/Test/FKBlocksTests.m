#import "GTMSenTestCase.h"
#import <FK/FKMacros.h>
//#import <FK/FKPrelude.h>
#import <FK/FKBlocks.h>

@interface FKBlocksUnitTest : GTMTestCase {
    NSObject *object;
}
@end

@implementation FKBlocksUnitTest

- (void)setUp {
	object = [[[NSObject alloc] init] autorelease];
}

- (void)testTypeDefs {
    __block int count = 0;
    Closure c = ^{
        count++;
    };
    c();
    STAssertTrue(count == 1, nil);

    Function description = ^(id arg) {
        return (id)[arg description];
    };
    STAssertEqualObjects(description(@"foo"), @"foo",nil);
}

- (void)testMacros {
    Function description = functionS(description);
    STAssertEqualObjects(description(@"foo"), @"foo",nil);
    
    Function addBar = functionSA(stringByAppendingString:, @"bar");
    STAssertEqualObjects(addBar(@"foo"), @"foobar",nil);
    
    Function preBar = functionTS(@"bar", stringByAppendingString:);
    STAssertEqualObjects(preBar(@"foo"), @"barfoo",nil);
    
    Function2 join = function2S(stringByAppendingString:);
    STAssertEqualObjects(join(@"foo", @"bar"), @"foobar",nil);
    
    NSMutableArray *array = [NSMutableArray arrayWithObject:@"foo"];
    Effect clear = effectS(removeAllObjects);
    clear(array);
    STAssertTrue([array count] == 0, nil);
    
    Effect two = effectTS(array, addObject:);
    two(@"foo");
    STAssertEqualObjects(NSARRAY(@"foo"), array, nil);
    
    clear(array);
    
    Effect three = effectSA(addObject:, @"foo");
    three(array);
    STAssertEqualObjects(NSARRAY(@"foo"), array, nil);
    
}

- (void)testF {
    Function addBar = functionSA(stringByAppendingString:, @"bar");
    Function addFoo = functionSA(stringByAppendingString:, @"foo");
    
    Function foobar = [F compose:addBar :addFoo];
    STAssertEqualObjects(@"foobar", foobar(@""), nil);

    NSMutableArray *array = [NSMutableArray array];
    Effect add = effectTS(array, addObject:);
    Effect addWithBar = [F comap:add :addBar];
    
    addWithBar(@"foo");
    STAssertEqualObjects(NSARRAY(@"foobar"), array, nil);    
}

- (void)testFunctionFailsIfTargetDoesntRespondToSelector {}

- (void)testLiftFunction {
//	NSArray *a = NSARRAY(@"first");
//	id <FKFunction> f = [FKFunction functionFromSelector:@selector(uppercaseString)];
//	id <FKFunction> lifted = [NSArray liftFunction:f];
//	NSArray *result = [lifted :a];
//	STAssertEqualObjects(NSARRAY(@"FIRST"), result, nil);
}

- (void)testComposeWith {}

- (void)testAndThen {}


- (void)testInvocation {}

@end
