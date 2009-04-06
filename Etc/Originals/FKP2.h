#import <Foundation/Foundation.h>
#import "FKMacros.h"

#define p2(a, b)    pair2(a, b)
#define pair2(a, b) [FKP2 p2With_1:a _2:b]

@interface FKP2 : NSObject <NSCopying> {
    id _1;
    id _2;
}

READ id _1;
READ id _2;

+ (FKP2 *)p2With_1:(id)_1 _2:(id)_2;
- (id)initWith_1:(id)new_1 _2:(id)new_2;
@end
