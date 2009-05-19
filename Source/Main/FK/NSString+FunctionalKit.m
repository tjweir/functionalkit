#import "NSString+FunctionalKit.h"

@implementation NSString (FunctionalKitExtensions)

NSString *concatF(NSString *base, NSString *suffix) {
    NSMutableString *mutable = [[[NSMutableString alloc] initWithCapacity:[base length]] autorelease];
    [mutable appendString:base];
    [mutable appendString:suffix];
    return mutable;
} 

+ (FKFunction2 *)concatF {
    return functionP2(concatF);
}

@end
