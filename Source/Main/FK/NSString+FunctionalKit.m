#import "NSString+FunctionalKit.h"

@implementation NSString (FunctionalKitExtensions)

+ (FKEither *)loadContentsOfFile:(NSString *)path {
    NSError *error;
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    return content == nil ? [FKEither leftWithValue:error] : [FKEither rightWithValue:content];
}

@end
