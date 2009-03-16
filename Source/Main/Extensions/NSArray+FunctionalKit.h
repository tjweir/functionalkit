#import <Foundation/Foundation.h>
#import "FKFunction.h"
#import "FKMacros.h"

@interface NSArray (FunctionalKitExtensions)

- (BOOL)all:(SEL)predicate;

- (NSArray *)map:(id <FKFunction>)f;

+ (id <FKFunction>)liftFunction:(id <FKFunction>)f;

@end
