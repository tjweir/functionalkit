#import <Foundation/Foundation.h>

#define FKS(sel) [FKFunction functionFromSelector:@selector(sel)]
#define FKTS(tgt, sel) [FKFunction functionFromSelector:@selector(sel) target:tgt]
#define FKP(fp) [FKFunction functionFromPointer:fp]

#define functionS(sel) FKS(sel)
#define functionP(fp) FKP(sel)
#define functionTS(tgt, sel) FKTS(tgt, sel)

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

