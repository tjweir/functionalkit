#import "GTMSenTestCase.h"
#import "NSArray+Motive.h"
#import "FKFunction.h"
#import "FKEffect.h"
#import "MVLog.h"
#import "MVNewtype.h"

@interface TestEffect : NSObject <FKEffect> {
	id arg;
}
- (id)arg;
@end
@implementation TestEffect
- (oneway void)e:(id)effectArg {
	arg = effectArg;
}
- (id)arg {
	return arg;
}
@end

@interface MVFunctionUnitTest : GTMTestCase {
    NSObject *object;
}
@end

@implementation MVFunctionUnitTest

- (void)setUp {
	object = [[[NSObject alloc] init] autorelease];
}

- (void)testSelectorFuncAppliesSelector {
	NSString *d = [object description];
	id <FKFunction> f = [FKFunction functionFromSelector:@selector(description)];
	NSString *result = [f :object];
	STAssertEqualObjects(d, result, nil);
}

- (void)testEffectComapping {
	TestEffect *e = [[[TestEffect alloc] init] autorelease];
	id <FKFunction> f = [FKFunction functionFromSelector:@selector(description)];
	id <FKEffect> comapped = [FKEffect comap:e:f];
	[comapped e:object];	
	STAssertEqualObjects([object description], [e arg], nil);
}

- (void)testSelectorWithTarget {
	id <FKFunction> f = [FKFunction functionFromSelector:@selector(arrayByAddingObject:) target:[NSArray array]];
	STAssertEqualObjects([f :@"yep"], NSARRAY(@"yep"), nil);
}

- (void)testFunctionFailsIfTargetDoesntRespondToSelector {
	@try {
		[FKFunction functionFromSelector:@selector(arrayByAddingObject:) target:@"wat"];
		STAssertTrue(NO, nil);
	}
	@catch (NSException * e) {
		STAssertEqualObjects([e name], @"InvalidOperation", nil);
	}
}

- (void)testLiftFunction {
	NSArray *a = NSARRAY(@"first");
	id <FKFunction> f = [FKFunction functionFromSelector:@selector(uppercaseString)];
	id <FKFunction> lifted = [NSArray liftFunction:f];
	NSArray *result = [lifted :a];
	STAssertEqualObjects(NSARRAY(@"FIRST"), result, nil);
}
@end
