#import <Foundation/Foundation.h>
#import "FKFunction.h"
#import "FKMacros.h"

// TODO filter

@interface NSArray (FunctionalKitExtensions)

- (BOOL)all:(SEL)predicate;

- (NSArray *)map:(id <FKFunction>)f;

- (void)foreach:(id <FKFunction>)f;

+ (id <FKFunction>)liftFunction:(id <FKFunction>)f;


@end
