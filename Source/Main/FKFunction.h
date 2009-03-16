#import <Foundation/Foundation.h>

// TODO Add in F2, F3, etc.

@protocol FKFunction <NSObject>
- (id):(id)arg;
@end

@interface FKFunction : NSObject

// On application, the selector will be sent to the argument
// eg. [arg selector]
+ (id <FKFunction>)functionFromSelector:(SEL)s;

// On application, the selector will be sent to the target, with the argument as an argument...
// eg. [target selector:arg]
+ (id <FKFunction>)functionFromSelector:(SEL)s target:(NSObject *)target;

@end
