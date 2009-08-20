typedef void (^Closure)(void);
typedef void (^Effect)(id obj);
typedef id (^Function)(id obj);
typedef id (^Function2)(id obj1, id obj2);
typedef BOOL (^Predicate)(id obj);

// On application, the selector will be sent to the argument
#define functionS(sel) ^(id arg) { return (id)[arg sel]; }

// On application, the selector will be sent to the arg (the arg param to the function application) with the given |argument|.
#define functionSA(sel, arg) ^(id v) { return [v performSelector:@selector(sel) withObject:arg]; }

// On application, the selector will be sent to the target, with the given |argument|.
// eg. [target selector:arg]
#define functionTS(tgt, sel) ^ (id v) { return [tgt performSelector:@selector(sel) withObject:v]; }

// On application, the selector will be sent to the first argument with the second argument.
#define function2S(sel) ^(id arg1, id arg2) { return [arg1 performSelector:@selector(sel) withObject:arg2]; }

// 
#define pureTS(tgt, sel) ^(id arg) { return [tgt sel arg]; }
#define pureS(sel) ^(id arg) { return [arg sel]; }
#define pureSA(sel, arg) ^(id tgt) { return [tgt sel arg]; }

#define effectS(sel) ^(id arg) { [arg sel]; return; }

#define effectSA(sel, arg) ^(id v) { [v performSelector:@selector(sel) withObject:arg]; return; }

#define effectTS(tgt, sel) ^(id arg) { [tgt performSelector:@selector(sel) withObject:arg]; return; }

@interface F : NSObject 
+ (Function)compose:(Function)f1 :(Function)f2;

+ (Effect)comap:(Effect)e :(Function)f;

+ (Function)identity;

+ (Function)const:(id)arg;
@end

@interface NSObject (BlockAdditions)
- (Function)compose:(Function)other;
- (Function)andThen:(Function)other;
@end
