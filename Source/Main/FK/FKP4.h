#import <Foundation/Foundation.h>
#import "FKMacros.h"

#define p4(a, b, c, d)    pair4(a, b, c, d)
#define pair4(a, b, c, d) [FKP4 p4With_1:a _2:b _3:c _4:d]

@interface FKP4 : NSObject <NSCopying> {
    id _1;
    id _2;
    id _3;
    id _4;
}

READ id _1;
READ id _2;
READ id _3;
READ id _4;

+ (FKP4 *)p4With_1:(id)_1 _2:(id)_2 _3:(id)_3 _4:(id)_4;
- (id)initWith_1:(id)new_1 _2:(id)new_2 _3:(id)new_3 _4:(id)new_4;
@end
