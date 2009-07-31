#import <Foundation/Foundation.h>

// TODO Make these macros (i.e. the constructors) fail harder if given bad data.

#define FKS(sel) [FKFunction functionFromSelector:@selector(sel)]
#define FKSA(sel, arg) [FKFunction functionFromSelector:@selector(sel) withArgument:arg]
#define FKTS(tgt, sel) [FKFunction functionFromSelector:@selector(sel) target:tgt]
#define FKPtr(fp) [FKFunction functionFromPointer:fp]
#define FKPtr2(fp) [FKFunction2 functionFromPointer:fp]

#define functionS(sel) FKS(sel)
#define functionSA(sel, arg) FKSA(sel, arg)
#define functionP(fp) FKPtr(fp)
#define functionP2(fp) FKPtr2(fp)
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

// C function types, for function pointer-based function application.
typedef id (*fkFunction)(id);
typedef id (*fkFunction2)(id, id);

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

+ (FKFunction *)functionFromInvocation:(NSInvocation *)invocation parameterIndex:(NSUInteger)index;

- (FKFunction *)andThen:(FKFunction *)other;

- (FKFunction *)composeWith:(FKFunction *)other;

@end

@interface FKFunction2 : NSObject <FKFunction2>

// On application, the selector will be sent to the first argument with the second argument.
// eg. [arg1 selector:arg2]
// s :: id -> id
+ (FKFunction2 *)functionFromSelector:(SEL)s;

+ (FKFunction2 *)functionFromPointer:(fkFunction2)f;

@end
