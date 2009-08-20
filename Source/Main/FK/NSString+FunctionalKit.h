#import <Foundation/Foundation.h>
#import <FK/FKEither.h>

@interface NSString (FunctionalKitExtensions)

+ (FKEither *)loadContentsOfFile:(NSString *)path;

@end
