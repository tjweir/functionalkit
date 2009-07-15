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

+ (FKEither *)loadContentsOfFile:(NSString *)path {
    NSError *error;
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    return content == nil ? [FKEither leftWithValue:error] : [FKEither rightWithValue:content];
}

@end
