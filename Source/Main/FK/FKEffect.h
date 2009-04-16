#import <Foundation/Foundation.h>
#import "FKFunction.h"

@protocol FKEffect <NSObject>
- (oneway void)e:(id)arg;
@end

@interface FKEffect : NSObject
+ (id <FKEffect>)comap:(id <FKEffect>)effect :(id <FKFunction>)function;
@end
