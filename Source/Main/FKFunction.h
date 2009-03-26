#import <Foundation/Foundation.h>

// TODO Add in F2, F3, etc.

@protocol FKFunction <NSObject>
- (id):(id)arg;
@end


typedef id (*fkFunction)(id);

@interface FKFunction : NSObject <FKFunction>

// On application, the selector will be sent to the argument
// eg. [arg selector]
+ (FKFunction *)functionFromSelector:(SEL)s;

// On application, the selector will be sent to the target, with the argument as an argument...
// eg. [target selector:arg]
+ (FKFunction *)functionFromSelector:(SEL)s target:(NSObject *)target;

+ (FKFunction *)functionFromPointer:(fkFunction)f;

- (FKFunction *)andThen:(FKFunction *)other;
- (FKFunction *)composeWith:(FKFunction *)other;
@end
