#import <Foundation/Foundation.h>
#import "FKMacros.h"

#define p5(a, b, c, d, e)    pair5(a, b, c, d, e)
#define pair5(a, b, c, d, e) [FKP5 p5With_1:a _2:b _3:c _4:d _5:e]

@interface FKP5 : NSObject <NSCopying> {
    id _1;
    id _2;
    id _3;
    id _4;
    id _5;
}

READ id _1;
READ id _2;
READ id _3;
READ id _4;
READ id _5;

+ (FKP5 *)p5With_1:(id)_1 _2:(id)_2 _3:(id)_3 _4:(id)_4 _5:(id)_5;
- (id)initWith_1:(id)new_1 _2:(id)new_2 _3:(id)new_3 _4:(id)new_4 _5:(id)new_5;
@end
