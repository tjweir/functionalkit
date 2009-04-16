#import <Foundation/Foundation.h>
#import "FKFunction.h"

@interface FKFunction (CommonFunctions)

+ (FKFunction *)const:(id)constantReturnValue;

+ (FKFunction *)identity;

@end
