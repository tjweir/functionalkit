#import <Foundation/Foundation.h>
#import "FKMacros.h"

#define p3(a, b, c)    pair3(a, b, c)
#define pair3(a, b, c) [FKP3 p3With_1:a _2:b _3:c]

@interface FKP3 : NSObject <NSCopying> {
    id _1;
    id _2;
    id _3;
}

READ id _1;
READ id _2;
READ id _3;

+ (FKP3 *)p3With_1:(id)_1 _2:(id)_2 _3:(id)_3;
- (id)initWith_1:(id)new_1 _2:(id)new_2 _3:(id)new_3;
@end
