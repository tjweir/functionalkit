#import <Foundation/Foundation.h>

// TODO Make these macros (i.e. the constructors) fail harder if given bad data.

#define FKS(sel) [FKFunction functionFromSelector:@selector(sel)]
#define FKSA(sel, arg) [FKFunction functionFromSelector:@selector(sel) withArgument:arg]
#define FKTS(tgt, sel) [FKFunction functionFromSelector:@selector(sel) target:tgt]
#define FKP(fp) [FKFunction functionFromPointer:fp]

#define functionS(sel) FKS(sel)
#define functionSA(sel, arg) FKSA(sel, arg)
#define functionP(fp) FKP(fp)
#define functionTS(tgt, sel) FKTS(tgt, sel)

// TODO Add in F2, F3, etc.

// A function that takes a single argument.
@protocol FKFunction <NSObject>
- (id):(id)arg;
@end

// A function that takes two arguments.
@protocol FKFunction2 <NSObject>
- (id):(id)arg1 :(id)arg2;
@end

typedef id (*fkFunction)(id);

@interface FKFunction : NSObject <FKFunction>

// On application, the selector will be sent to the argument
// eg. [arg selector]
// s :: void -> id
+ (FKFunction *)functionFromSelector:(SEL)s;

// On application, the selector will be sent to the arg (the arg param to the function application) with the given |argument|.
// eg. [arg selector:argument];
// s :: id -> id
+ (FKFunction *)functionFromSelector:(SEL)s withArgument:(id)argument;

// On application, the selector will be sent to the target, with the given |argument|.
// eg. [target selector:arg]
+ (FKFunction *)functionFromSelector:(SEL)s target:(NSObject *)target;

+ (FKFunction *)functionFromPointer:(fkFunction)f;

- (FKFunction *)andThen:(FKFunction *)other;

- (FKFunction *)composeWith:(FKFunction *)other;

@end

@interface FKFunction2 : NSObject <FKFunction2>

// On application, the selector will be sent to the first argument with the second argument.
// eg. [arg1 selector:arg2]
// s :: id -> id
+ (FKFunction2 *)functionFromSelector:(SEL)s;

@end
