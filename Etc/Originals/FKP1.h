#import <Foundation/Foundation.h>
#import "FKMacros.h"

#define p1(a)    pair1(a)
#define pair1(a) [FKP1 p1With_1:a]

@interface FKP1 : NSObject <NSCopying> {
    id _1;
}

READ id _1;

+ (FKP1 *)p1With_1:(id)_1;
- (id)initWith_1:(id)new_1;
@end
