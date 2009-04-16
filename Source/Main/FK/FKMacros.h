#ifndef ATTR
#define ATTR @property (nonatomic, retain)
#endif

#ifndef READ
#define READ @property (readonly)
#endif

#ifndef NSARRAY
#define NSARRAY(args...) [NSArray arrayWithObjects:args, nil]
#endif

#ifndef EMPTY_ARRAY
#define EMPTY_ARRAY [NSArray array]
#endif

#ifndef NSDICT
#define NSDICT(args...) [NSDictionary dictionaryWithObjectsAndKeys:args, nil]
#endif

#ifndef EMPTY_DICT
#define EMPTY_DICT [NSDictionary dictionary]
#endif

#if OBJC_API_VERSION >= 2

// With Objective-C 2.0 runtime, we can compare using runtime-provided function
#import <objc/runtime.h>
FOUNDATION_STATIC_INLINE BOOL FKEqualSelectors(SEL a, SEL b) {
	return sel_isEqual(a, b);
}
#else

// Without Objective-C 2.0 runtime, just use pre-Leopard comparison
FOUNDATION_STATIC_INLINE BOOL FKEqualSelectors(SEL a, SEL b) {
	return a == b;
}

#endif