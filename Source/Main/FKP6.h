#import <Foundation/Foundation.h>
#import "FKMacros.h"

#define p6(a, b, c, d, e, f)    pair6(a, b, c, d, e, f)
#define pair6(a, b, c, d, e, f) [FKP6 p6With_1:a _2:b _3:c _4:d _5:e _6:f]

@interface FKP6 : NSObject <NSCopying> {
    id _1;
    id _2;
    id _3;
    id _4;
    id _5;
    id _6;
}

READ id _1;
READ id _2;
READ id _3;
READ id _4;
READ id _5;
READ id _6;

+ (FKP6 *)p6With_1:(id)_1 _2:(id)_2 _3:(id)_3 _4:(id)_4 _5:(id)_5 _6:(id)_6;
- (id)initWith_1:(id)new_1 _2:(id)new_2 _3:(id)new_3 _4:(id)new_4 _5:(id)new_5 _6:(id)new_6;
@end
