#import "FKFunction+Common.h"
#import "NSObject+FunctionalKit.h"
#import "FKMacros.h"
#import "NSInvocation+FunctionalKit.h"

id IdentityF(id arg) {
	return arg;
}

@implementation FKFunction (CommonFunctions)

+ (id)constHelper:(id)a b:(id)b {
	return a;
}

+ (FKFunction *)const:(id)constantReturnValue {
	NSInvocation *inv = [NSInvocation invocationWithSelector:@selector(constHelper:b:) target:self arguments:NSARRAY(constantReturnValue)];
	return [FKFunction functionFromInvocation:inv parameterIndex:1];
}

+ (FKFunction *)identity {
	return functionP(IdentityF);
}

@end
