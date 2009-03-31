#import "GTMSenTestCase.h"
#import "NSArray+FunctionalKit.h"
#import "FKFunction.h"
#import "FKEffect.h"
#import "FKNewtype.h"
#import "NSInvocation+FunctionalKit.h"
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

@interface FKFunctionUnitTest : GTMTestCase {
    NSObject *object;
}
@end

@implementation FKFunctionUnitTest

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
		STAssertEqualObjects([e name], NSInvalidArgumentException, nil);
	}
}

- (void)testLiftFunction {
	NSArray *a = NSARRAY(@"first");
	id <FKFunction> f = [FKFunction functionFromSelector:@selector(uppercaseString)];
	id <FKFunction> lifted = [NSArray liftFunction:f];
	NSArray *result = [lifted :a];
	STAssertEqualObjects(NSARRAY(@"FIRST"), result, nil);
}

- (id)a:(id)arg {
	NSString *s = arg;
	return [s stringByAppendingString:@"a"];
}

- (id)b:(id)arg {
	return [arg stringByAppendingString:@"b"];
}

- (void)testComposeWith {
	FKFunction *a = [FKFunction functionFromSelector:@selector(a:) target:self];
	FKFunction *b = [FKFunction functionFromSelector:@selector(b:) target:self];
	FKFunction *composed = [a composeWith:b];
	STAssertEqualObjects(@"ba", [composed :@""], nil);
}

- (void)testAndThen {
	FKFunction *a = [FKFunction functionFromSelector:@selector(a:) target:self];
	FKFunction *b = [FKFunction functionFromSelector:@selector(b:) target:self];
	FKFunction *andThen = [a andThen:b];
	STAssertEqualObjects(@"ab", [andThen :@""], nil);	
}

id myFunc(id arg) {
	return [arg description];
}

- (void)testFunctionPointer {
	FKFunction *f = [FKFunction functionFromPointer:(*myFunc)];
	STAssertEqualObjects([f :[NSNumber numberWithInt:54]], @"54", nil);
}

- (NSString *)add:(NSString *)a to:(NSString *)b {
	return [b stringByAppendingString:a];
}

- (void)testInvocation {
	NSInvocation *inv = [NSInvocation invocationWithSelector:@selector(add:to:) target:self arguments:NSARRAY([NSNull null], @"start")];
	FKFunction *f = [FKFunction functionFromInvocation:inv parameterIndex:0];
	STAssertEqualObjects(@"startend", [f :@"end"], nil);
	STAssertEqualObjects(@"startfoo", [f :@"foo"], nil);
}

@end
