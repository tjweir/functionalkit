
/*
 Macros for creating instant types based on P*'s.
 Provides somewhat typesafe contructors and accessors.
 
 Your.h => NewTypeInterface(MyNewType, NSString, fieldName);
 Your.m => NewTypeImplementation(MyNewType, NSString, fieldName);
 
 Later...
 MyNewType *instance = [MyNewType fieldName:@"foobar"];
 [instance fieldName]; // @foobar
 
 */

#import "FK/FKPrelude.h"

// TODO make the contructors type check harder, so that 'id' can't be passed in


// P1 newtype
#define NewTypeInterface(newtype, wrappedtype1, acc1) \
@interface newtype : FKP1 \
+ (newtype *)acc1:(wrappedtype1 *)acc1; \
@property (readonly) wrappedtype1 *acc1; \
@end \
@interface NSArrayTo##newtype : FKFunction @end \
@interface NSDictionaryTo##newtype : FKFunction @end

#define NewTypeImplementation(newtype, wrappedtype1, acc1) \
@implementation newtype \
@synthesize acc1=_1; \
- (newtype *)initWith_1:(wrappedtype1 *)acc1 { return ((self = [super initWith_1:acc1])); } \
+ (newtype *)acc1:(wrappedtype1 *)acc1 { return [[[self alloc] initWith_1:acc1] autorelease]; } \
@end \
@implementation NSArrayTo##newtype \
- (id):(id)arg { \
if (![arg isKindOfClass:[NSArray class]] || ([arg count] != 1)) { \
return [FKOption none]; \
} \
id _1 = [arg objectAtIndex:0]; \
if ( [_1 isKindOfClass:[wrappedtype1 class]] ) { \
return [FKOption some:[newtype acc1:_1]]; \
} \
return [FKOption none]; \
} \
@end \
@implementation NSDictionaryTo##newtype \
- (id):(id)dict { \
if (![dict isKindOfClass:[NSDictionary class]]) { \
return [FKOption none]; \
} \
NSArray *keys = NSARRAY([NSString stringWithCString:#acc1]);\
NSArray *values = [dict objectsForKeys:keys notFoundMarker:[NSNull null]]; \
id <FKFunction> arrayToType = [NSArrayTo##newtype new]; \
FKOption *result = [arrayToType :values]; \
[arrayToType release]; \
return result; \
} \
@end

// P2 newtype
#define NewType2Interface(newtype, wrappedtype1, acc1, wrappedtype2, acc2) \
@interface newtype : FKP2 \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2; \
@property (readonly) wrappedtype1 *acc1; \
@property (readonly) wrappedtype2 *acc2; \
@end \
@interface NSArrayTo##newtype : FKFunction @end \
@interface NSDictionaryTo##newtype : FKFunction @end

#define NewType2Implementation(newtype, wrappedtype1, acc1, wrappedtype2, acc2) \
@implementation newtype \
@synthesize acc1=_1, acc2=_2; \
- (newtype *)initWith_1:(wrappedtype1 *)acc1 _2:(wrappedtype2 *)acc2 { return ((self = [super initWith_1:acc1 _2:acc2])); } \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 { return [[[self alloc] initWith_1:acc1 _2:acc2] autorelease]; } \
@end \
@implementation NSArrayTo##newtype \
- (id):(id)arg { \
if (![arg isKindOfClass:[NSArray class]] || ([arg count] != 2)) { \
return [FKOption none]; \
} \
id _1 = [arg objectAtIndex:0]; \
id _2 = [arg objectAtIndex:1]; \
if ( [_1 isKindOfClass:[wrappedtype1 class]] && [_2 isKindOfClass:[wrappedtype2 class]] ) { \
return [FKOption some:[newtype acc1:_1 acc2:_2]]; \
} \
return [FKOption none]; \
} \
@end \
@implementation NSDictionaryTo##newtype \
- (id):(id)dict { \
if (![dict isKindOfClass:[NSDictionary class]]) { \
return [FKOption none]; \
} \
NSArray *keys = NSARRAY([NSString stringWithCString:#acc1], [NSString stringWithCString:#acc2]);\
NSArray *values = [dict objectsForKeys:keys notFoundMarker:[NSNull null]]; \
id <FKFunction> arrayToType = [NSArrayTo##newtype new]; \
FKOption *result = [arrayToType :values]; \
[arrayToType release]; \
return result; \
} \
@end

// P3 newtype
#define NewType3Interface(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3) \
@interface newtype : FKP3 \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 acc3:(wrappedtype3 *)acc3; \
@property (readonly) wrappedtype1 *acc1; \
@property (readonly) wrappedtype2 *acc2; \
@property (readonly) wrappedtype3 *acc3; \
@end \
@interface NSArrayTo##newtype : FKFunction @end \
@interface NSDictionaryTo##newtype : FKFunction @end

#define NewType3Implementation(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3) \
@implementation newtype \
@synthesize acc1=_1, acc2=_2, acc3=_3; \
- (newtype *)initWith_1:(wrappedtype1 *)acc1 _2:(wrappedtype2 *)acc2 _3:(wrappedtype3 *)acc3 { return ((self = [super initWith_1:acc1 _2:acc2 _3:acc3])); } \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 acc3:(wrappedtype3 *)acc3 { return [[[self alloc] initWith_1:acc1 _2:acc2 _3:acc3] autorelease]; } \
@end \
@implementation NSArrayTo##newtype \
- (id):(id)arg { \
if (![arg isKindOfClass:[NSArray class]] || ([arg count] != 3)) { \
return [FKOption none]; \
} \
id _1 = [arg objectAtIndex:0]; \
id _2 = [arg objectAtIndex:1]; \
id _3 = [arg objectAtIndex:2]; \
if ( [_1 isKindOfClass:[wrappedtype1 class]] && [_2 isKindOfClass:[wrappedtype2 class]] && [_3 isKindOfClass:[wrappedtype3 class]] ) { \
return [FKOption some:[newtype acc1:_1 acc2:_2 acc3:_3]]; \
} \
return [FKOption none]; \
} \
@end \
@implementation NSDictionaryTo##newtype \
- (id):(id)dict { \
if (![dict isKindOfClass:[NSDictionary class]]) { \
return [FKOption none]; \
} \
NSArray *keys = NSARRAY([NSString stringWithCString:#acc1], [NSString stringWithCString:#acc2], [NSString stringWithCString:#acc3]);\
NSArray *values = [dict objectsForKeys:keys notFoundMarker:[NSNull null]]; \
id <FKFunction> arrayToType = [NSArrayTo##newtype new]; \
FKOption *result = [arrayToType :values]; \
[arrayToType release]; \
return result; \
} \
@end

// P4 newtype
#define NewType4Interface(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3, wrappedtype4, acc4) \
@interface newtype : FKP4 \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 acc3:(wrappedtype3 *)acc3 acc4:(wrappedtype4 *)acc4; \
@property (readonly) wrappedtype1 *acc1; \
@property (readonly) wrappedtype2 *acc2; \
@property (readonly) wrappedtype3 *acc3; \
@property (readonly) wrappedtype4 *acc4; \
@end \
@interface NSArrayTo##newtype : FKFunction @end \
@interface NSDictionaryTo##newtype : FKFunction @end

#define NewType4Implementation(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3, wrappedtype4, acc4) \
@implementation newtype \
@synthesize acc1=_1, acc2=_2, acc3=_3, acc4=_4; \
- (newtype *)initWith_1:(wrappedtype1 *)acc1 _2:(wrappedtype2 *)acc2 _3:(wrappedtype3 *)acc3 _4:(wrappedtype4 *)acc4 { return ((self = [super initWith_1:acc1 _2:acc2 _3:acc3 _4:acc4])); } \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 acc3:(wrappedtype3 *)acc3 acc4:(wrappedtype4 *)acc4 { return [[[self alloc] initWith_1:acc1 _2:acc2 _3:acc3 _4:acc4] autorelease]; } \
@end \
@implementation NSArrayTo##newtype \
- (id):(id)arg { \
if (![arg isKindOfClass:[NSArray class]] || ([arg count] != 4)) { \
return [FKOption none]; \
} \
id _1 = [arg objectAtIndex:0]; \
id _2 = [arg objectAtIndex:1]; \
id _3 = [arg objectAtIndex:2]; \
id _4 = [arg objectAtIndex:3]; \
if ( [_1 isKindOfClass:[wrappedtype1 class]] && [_2 isKindOfClass:[wrappedtype2 class]] && [_3 isKindOfClass:[wrappedtype3 class]] && [_4 isKindOfClass:[wrappedtype4 class]] ) { \
return [FKOption some:[newtype acc1:_1 acc2:_2 acc3:_3 acc4:_4]]; \
} \
return [FKOption none]; \
} \
@end \
@implementation NSDictionaryTo##newtype \
- (id):(id)dict { \
if (![dict isKindOfClass:[NSDictionary class]]) { \
return [FKOption none]; \
} \
NSArray *keys = NSARRAY([NSString stringWithCString:#acc1], [NSString stringWithCString:#acc2], [NSString stringWithCString:#acc3], [NSString stringWithCString:#acc4]);\
NSArray *values = [dict objectsForKeys:keys notFoundMarker:[NSNull null]]; \
id <FKFunction> arrayToType = [NSArrayTo##newtype new]; \
FKOption *result = [arrayToType :values]; \
[arrayToType release]; \
return result; \
} \
@end

// P5 newtype
#define NewType5Interface(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3, wrappedtype4, acc4, wrappedtype5, acc5) \
@interface newtype : FKP5 \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 acc3:(wrappedtype3 *)acc3 acc4:(wrappedtype4 *)acc4 acc5:(wrappedtype5 *)acc5; \
@property (readonly) wrappedtype1 *acc1; \
@property (readonly) wrappedtype2 *acc2; \
@property (readonly) wrappedtype3 *acc3; \
@property (readonly) wrappedtype4 *acc4; \
@property (readonly) wrappedtype5 *acc5; \
@end \
@interface NSArrayTo##newtype : FKFunction @end \
@interface NSDictionaryTo##newtype : FKFunction @end

#define NewType5Implementation(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3, wrappedtype4, acc4, wrappedtype5, acc5) \
@implementation newtype \
@synthesize acc1=_1, acc2=_2, acc3=_3, acc4=_4, acc5=_5; \
- (newtype *)initWith_1:(wrappedtype1 *)acc1 _2:(wrappedtype2 *)acc2 _3:(wrappedtype3 *)acc3 _4:(wrappedtype4 *)acc4 _5:(wrappedtype5 *)acc5 { return ((self = [super initWith_1:acc1 _2:acc2 _3:acc3 _4:acc4 _5:acc5])); } \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 acc3:(wrappedtype3 *)acc3 acc4:(wrappedtype4 *)acc4 acc5:(wrappedtype5 *)acc5 { return [[[self alloc] initWith_1:acc1 _2:acc2 _3:acc3 _4:acc4 _5:acc5] autorelease]; } \
@end \
@implementation NSArrayTo##newtype \
- (id):(id)arg { \
if (![arg isKindOfClass:[NSArray class]] || ([arg count] != 5)) { \
return [FKOption none]; \
} \
id _1 = [arg objectAtIndex:0]; \
id _2 = [arg objectAtIndex:1]; \
id _3 = [arg objectAtIndex:2]; \
id _4 = [arg objectAtIndex:3]; \
id _5 = [arg objectAtIndex:4]; \
if ( [_1 isKindOfClass:[wrappedtype1 class]] && [_2 isKindOfClass:[wrappedtype2 class]] && [_3 isKindOfClass:[wrappedtype3 class]] && [_4 isKindOfClass:[wrappedtype4 class]] && [_5 isKindOfClass:[wrappedtype5 class]] ) { \
return [FKOption some:[newtype acc1:_1 acc2:_2 acc3:_3 acc4:_4 acc5:_5]]; \
} \
return [FKOption none]; \
} \
@end \
@implementation NSDictionaryTo##newtype \
- (id):(id)dict { \
if (![dict isKindOfClass:[NSDictionary class]]) { \
return [FKOption none]; \
} \
NSArray *keys = NSARRAY([NSString stringWithCString:#acc1], [NSString stringWithCString:#acc2], [NSString stringWithCString:#acc3], [NSString stringWithCString:#acc4], [NSString stringWithCString:#acc5]);\
NSArray *values = [dict objectsForKeys:keys notFoundMarker:[NSNull null]]; \
id <FKFunction> arrayToType = [NSArrayTo##newtype new]; \
FKOption *result = [arrayToType :values]; \
[arrayToType release]; \
return result; \
} \
@end

// P6 newtype
#define NewType6Interface(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3, wrappedtype4, acc4, wrappedtype5, acc5, wrappedtype6, acc6) \
@interface newtype : FKP6 \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 acc3:(wrappedtype3 *)acc3 acc4:(wrappedtype4 *)acc4 acc5:(wrappedtype5 *)acc5 acc6:(wrappedtype6 *)acc6; \
@property (readonly) wrappedtype1 *acc1; \
@property (readonly) wrappedtype2 *acc2; \
@property (readonly) wrappedtype3 *acc3; \
@property (readonly) wrappedtype4 *acc4; \
@property (readonly) wrappedtype5 *acc5; \
@property (readonly) wrappedtype6 *acc6; \
@end \
@interface NSArrayTo##newtype : FKFunction @end \
@interface NSDictionaryTo##newtype : FKFunction @end

#define NewType6Implementation(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3, wrappedtype4, acc4, wrappedtype5, acc5, wrappedtype6, acc6) \
@implementation newtype \
@synthesize acc1=_1, acc2=_2, acc3=_3, acc4=_4, acc5=_5, acc6=_6; \
- (newtype *)initWith_1:(wrappedtype1 *)acc1 _2:(wrappedtype2 *)acc2 _3:(wrappedtype3 *)acc3 _4:(wrappedtype4 *)acc4 _5:(wrappedtype5 *)acc5 _6:(wrappedtype6 *)acc6 { return ((self = [super initWith_1:acc1 _2:acc2 _3:acc3 _4:acc4 _5:acc5 _6:acc6])); } \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 acc3:(wrappedtype3 *)acc3 acc4:(wrappedtype4 *)acc4 acc5:(wrappedtype5 *)acc5 acc6:(wrappedtype6 *)acc6 { return [[[self alloc] initWith_1:acc1 _2:acc2 _3:acc3 _4:acc4 _5:acc5 _6:acc6] autorelease]; } \
@end \
@implementation NSArrayTo##newtype \
- (id):(id)arg { \
if (![arg isKindOfClass:[NSArray class]] || ([arg count] != 6)) { \
return [FKOption none]; \
} \
id _1 = [arg objectAtIndex:0]; \
id _2 = [arg objectAtIndex:1]; \
id _3 = [arg objectAtIndex:2]; \
id _4 = [arg objectAtIndex:3]; \
id _5 = [arg objectAtIndex:4]; \
id _6 = [arg objectAtIndex:5]; \
if ( [_1 isKindOfClass:[wrappedtype1 class]] && [_2 isKindOfClass:[wrappedtype2 class]] && [_3 isKindOfClass:[wrappedtype3 class]] && [_4 isKindOfClass:[wrappedtype4 class]] && [_5 isKindOfClass:[wrappedtype5 class]] && [_6 isKindOfClass:[wrappedtype6 class]] ) { \
return [FKOption some:[newtype acc1:_1 acc2:_2 acc3:_3 acc4:_4 acc5:_5 acc6:_6]]; \
} \
return [FKOption none]; \
} \
@end \
@implementation NSDictionaryTo##newtype \
- (id):(id)dict { \
if (![dict isKindOfClass:[NSDictionary class]]) { \
return [FKOption none]; \
} \
NSArray *keys = NSARRAY([NSString stringWithCString:#acc1], [NSString stringWithCString:#acc2], [NSString stringWithCString:#acc3], [NSString stringWithCString:#acc4], [NSString stringWithCString:#acc5], [NSString stringWithCString:#acc6]);\
NSArray *values = [dict objectsForKeys:keys notFoundMarker:[NSNull null]]; \
id <FKFunction> arrayToType = [NSArrayTo##newtype new]; \
FKOption *result = [arrayToType :values]; \
[arrayToType release]; \
return result; \
} \
@end

// P7 newtype
#define NewType7Interface(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3, wrappedtype4, acc4, wrappedtype5, acc5, wrappedtype6, acc6, wrappedtype7, acc7) \
@interface newtype : FKP7 \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 acc3:(wrappedtype3 *)acc3 acc4:(wrappedtype4 *)acc4 acc5:(wrappedtype5 *)acc5 acc6:(wrappedtype6 *)acc6 acc7:(wrappedtype7 *)acc7; \
@property (readonly) wrappedtype1 *acc1; \
@property (readonly) wrappedtype2 *acc2; \
@property (readonly) wrappedtype3 *acc3; \
@property (readonly) wrappedtype4 *acc4; \
@property (readonly) wrappedtype5 *acc5; \
@property (readonly) wrappedtype6 *acc6; \
@property (readonly) wrappedtype7 *acc7; \
@end \
@interface NSArrayTo##newtype : FKFunction @end \
@interface NSDictionaryTo##newtype : FKFunction @end

#define NewType7Implementation(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3, wrappedtype4, acc4, wrappedtype5, acc5, wrappedtype6, acc6, wrappedtype7, acc7) \
@implementation newtype \
@synthesize acc1=_1, acc2=_2, acc3=_3, acc4=_4, acc5=_5, acc6=_6, acc7=_7; \
- (newtype *)initWith_1:(wrappedtype1 *)acc1 _2:(wrappedtype2 *)acc2 _3:(wrappedtype3 *)acc3 _4:(wrappedtype4 *)acc4 _5:(wrappedtype5 *)acc5 _6:(wrappedtype6 *)acc6 _7:(wrappedtype7 *)acc7 { return ((self = [super initWith_1:acc1 _2:acc2 _3:acc3 _4:acc4 _5:acc5 _6:acc6 _7:acc7])); } \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 acc3:(wrappedtype3 *)acc3 acc4:(wrappedtype4 *)acc4 acc5:(wrappedtype5 *)acc5 acc6:(wrappedtype6 *)acc6 acc7:(wrappedtype7 *)acc7 { return [[[self alloc] initWith_1:acc1 _2:acc2 _3:acc3 _4:acc4 _5:acc5 _6:acc6 _7:acc7] autorelease]; } \
@end \
@implementation NSArrayTo##newtype \
- (id):(id)arg { \
if (![arg isKindOfClass:[NSArray class]] || ([arg count] != 7)) { \
return [FKOption none]; \
} \
id _1 = [arg objectAtIndex:0]; \
id _2 = [arg objectAtIndex:1]; \
id _3 = [arg objectAtIndex:2]; \
id _4 = [arg objectAtIndex:3]; \
id _5 = [arg objectAtIndex:4]; \
id _6 = [arg objectAtIndex:5]; \
id _7 = [arg objectAtIndex:6]; \
if ( [_1 isKindOfClass:[wrappedtype1 class]] && [_2 isKindOfClass:[wrappedtype2 class]] && [_3 isKindOfClass:[wrappedtype3 class]] && [_4 isKindOfClass:[wrappedtype4 class]] && [_5 isKindOfClass:[wrappedtype5 class]] && [_6 isKindOfClass:[wrappedtype6 class]] && [_7 isKindOfClass:[wrappedtype7 class]] ) { \
return [FKOption some:[newtype acc1:_1 acc2:_2 acc3:_3 acc4:_4 acc5:_5 acc6:_6 acc7:_7]]; \
} \
return [FKOption none]; \
} \
@end \
@implementation NSDictionaryTo##newtype \
- (id):(id)dict { \
if (![dict isKindOfClass:[NSDictionary class]]) { \
return [FKOption none]; \
} \
NSArray *keys = NSARRAY([NSString stringWithCString:#acc1], [NSString stringWithCString:#acc2], [NSString stringWithCString:#acc3], [NSString stringWithCString:#acc4], [NSString stringWithCString:#acc5], [NSString stringWithCString:#acc6], [NSString stringWithCString:#acc7]);\
NSArray *values = [dict objectsForKeys:keys notFoundMarker:[NSNull null]]; \
id <FKFunction> arrayToType = [NSArrayTo##newtype new]; \
FKOption *result = [arrayToType :values]; \
[arrayToType release]; \
return result; \
} \
@end

// P8 newtype
#define NewType8Interface(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3, wrappedtype4, acc4, wrappedtype5, acc5, wrappedtype6, acc6, wrappedtype7, acc7, wrappedtype8, acc8) \
@interface newtype : FKP8 \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 acc3:(wrappedtype3 *)acc3 acc4:(wrappedtype4 *)acc4 acc5:(wrappedtype5 *)acc5 acc6:(wrappedtype6 *)acc6 acc7:(wrappedtype7 *)acc7 acc8:(wrappedtype8 *)acc8; \
@property (readonly) wrappedtype1 *acc1; \
@property (readonly) wrappedtype2 *acc2; \
@property (readonly) wrappedtype3 *acc3; \
@property (readonly) wrappedtype4 *acc4; \
@property (readonly) wrappedtype5 *acc5; \
@property (readonly) wrappedtype6 *acc6; \
@property (readonly) wrappedtype7 *acc7; \
@property (readonly) wrappedtype8 *acc8; \
@end \
@interface NSArrayTo##newtype : FKFunction @end \
@interface NSDictionaryTo##newtype : FKFunction @end

#define NewType8Implementation(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3, wrappedtype4, acc4, wrappedtype5, acc5, wrappedtype6, acc6, wrappedtype7, acc7, wrappedtype8, acc8) \
@implementation newtype \
@synthesize acc1=_1, acc2=_2, acc3=_3, acc4=_4, acc5=_5, acc6=_6, acc7=_7, acc8=_8; \
- (newtype *)initWith_1:(wrappedtype1 *)acc1 _2:(wrappedtype2 *)acc2 _3:(wrappedtype3 *)acc3 _4:(wrappedtype4 *)acc4 _5:(wrappedtype5 *)acc5 _6:(wrappedtype6 *)acc6 _7:(wrappedtype7 *)acc7 _8:(wrappedtype8 *)acc8 { return ((self = [super initWith_1:acc1 _2:acc2 _3:acc3 _4:acc4 _5:acc5 _6:acc6 _7:acc7 _8:acc8])); } \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 acc3:(wrappedtype3 *)acc3 acc4:(wrappedtype4 *)acc4 acc5:(wrappedtype5 *)acc5 acc6:(wrappedtype6 *)acc6 acc7:(wrappedtype7 *)acc7 acc8:(wrappedtype8 *)acc8 { return [[[self alloc] initWith_1:acc1 _2:acc2 _3:acc3 _4:acc4 _5:acc5 _6:acc6 _7:acc7 _8:acc8] autorelease]; } \
@end \
@implementation NSArrayTo##newtype \
- (id):(id)arg { \
if (![arg isKindOfClass:[NSArray class]] || ([arg count] != 8)) { \
return [FKOption none]; \
} \
id _1 = [arg objectAtIndex:0]; \
id _2 = [arg objectAtIndex:1]; \
id _3 = [arg objectAtIndex:2]; \
id _4 = [arg objectAtIndex:3]; \
id _5 = [arg objectAtIndex:4]; \
id _6 = [arg objectAtIndex:5]; \
id _7 = [arg objectAtIndex:6]; \
id _8 = [arg objectAtIndex:7]; \
if ( [_1 isKindOfClass:[wrappedtype1 class]] && [_2 isKindOfClass:[wrappedtype2 class]] && [_3 isKindOfClass:[wrappedtype3 class]] && [_4 isKindOfClass:[wrappedtype4 class]] && [_5 isKindOfClass:[wrappedtype5 class]] && [_6 isKindOfClass:[wrappedtype6 class]] && [_7 isKindOfClass:[wrappedtype7 class]] && [_8 isKindOfClass:[wrappedtype8 class]] ) { \
return [FKOption some:[newtype acc1:_1 acc2:_2 acc3:_3 acc4:_4 acc5:_5 acc6:_6 acc7:_7 acc8:_8]]; \
} \
return [FKOption none]; \
} \
@end \
@implementation NSDictionaryTo##newtype \
- (id):(id)dict { \
if (![dict isKindOfClass:[NSDictionary class]]) { \
return [FKOption none]; \
} \
NSArray *keys = NSARRAY([NSString stringWithCString:#acc1], [NSString stringWithCString:#acc2], [NSString stringWithCString:#acc3], [NSString stringWithCString:#acc4], [NSString stringWithCString:#acc5], [NSString stringWithCString:#acc6], [NSString stringWithCString:#acc7], [NSString stringWithCString:#acc8]);\
NSArray *values = [dict objectsForKeys:keys notFoundMarker:[NSNull null]]; \
id <FKFunction> arrayToType = [NSArrayTo##newtype new]; \
FKOption *result = [arrayToType :values]; \
[arrayToType release]; \
return result; \
} \
@end


// Do both. This won't work most of the time, duplicate symbols abound
#define NEWTYPE(newtype, wrappedtype, acc1) \
NewTypeInterface(newtype, wrappedtype, acc1) \
NewTypeImplementation(newtype, wrappedtype, acc1)

#define NEWTYPE2(newtype, wrappedtype1, acc1, wrappedtype2, acc2) \
NewType2Interface(newtype, wrappedtype1, acc1, wrappedtype2, acc2) \
NewType2Implementation(newtype, wrappedtype1, acc1, wrappedtype2, acc2)

#define NEWTYPE3(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3) \
NewType3Interface(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3) \
NewType3Implementation(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3)
