
/*
 Macros for creating instant types based on P*'s.
 Provides somewhat typesafe contructors and accessors.
 
 If the type is local to a .m, then you can do this: 
 NEWTYPE(MyNewType, NSString);
 
 Later...
 MyNewType *instance = [MyNewType value:@"foobar"];
 [instance value]; // @foobar
 
 This won't work in a header though, as the implementation can't be defined in the .h.
 .h => NewTypeInterface(MyNewType, NSString);
 .m => NewTypeImplementation(MyNewType, NSString);
 */

#import "FKFunction.h"
#import "FKOption.h"

#import "FKP1.h"
#import "FKP2.h"
#import "FKP3.h"

// TODO make the contructors type check harder, so that 'id' can't be passed in

// P1 newtype
#define NewTypeInterface(newtype, wrappedtype, accessor) \
@interface newtype : FKP1 \
+ (newtype *)accessor:(wrappedtype *)thing; \
@property (readonly) wrappedtype *accessor; \
@end \
\
@interface NSArrayTo##newtype : NSObject <FKFunction> @end \

#define NewTypeImplementation(newtype, wrappedtype, accessor) \
@implementation newtype \
@synthesize accessor=_1; \
- (newtype *)initWith_1:(wrappedtype *)new_1 { return ((self = [super initWith_1:new_1])); } \
+ (newtype *)accessor:(wrappedtype *)thing { return [[[self alloc] initWith_1:thing] autorelease]; } \
@end \
\
@implementation NSArrayTo##newtype \
- (id):(id)arg { \
	if (![arg isKindOfClass:[NSArray class]] || ([arg count] != 1)) { \
		return [FKOption none]; \
	} \
	id _1 = [arg objectAtIndex:0]; \
	if ([_1 isKindOfClass:[wrappedtype class]]) { \
		return [FKOption some:[newtype accessor:_1]]; \
	} \
	return [FKOption none]; \
} \
@end

// P2 newtype
#define NewType2Interface(newtype, wrappedtype1, acc1, wrappedtype2, acc2) \
@interface newtype : FKP2 \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2; \
@property (readonly) wrappedtype1 *acc1; @property (readonly) wrappedtype2 *acc2; \
@end \
@interface NSArrayTo##newtype : NSObject <FKFunction> @end

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
	if ([_1 isKindOfClass:[wrappedtype1 class]] && [_2 isKindOfClass:[wrappedtype2 class]]) { \
		return [FKOption some:[newtype acc1:_1 acc2:_2]]; \
	} \
	return [FKOption none]; \
} \
@end


// P3 newtype
#define NewType3Interface(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3) \
@interface newtype : FKP3 \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 acc3:(wrappedtype3 *)acc3; \
@property (readonly) wrappedtype1 *acc1; @property (readonly) wrappedtype2 *acc2; @property (readonly) wrappedtype3 *acc3; \
@end \
@interface NSArrayTo##newtype : NSObject <FKFunction> @end

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
	if ([_1 isKindOfClass:[wrappedtype1 class]] && [_2 isKindOfClass:[wrappedtype2 class]] && [_3 isKindOfClass:[wrappedtype3 class]]) { \
		return [FKOption some:[newtype acc1:_1 acc2:_2 acc3:_3]]; \
	} \
	return [FKOption none]; \
} \
@end

// Do both. This won't work most of the time, unless the type is local to .m
#define NEWTYPE(newtype, wrappedtype, acc1) \
NewTypeInterface(newtype, wrappedtype, acc1) \
NewTypeImplementation(newtype, wrappedtype, acc1)

#define NEWTYPE2(newtype, wrappedtype1, acc1, wrappedtype2, acc2) \
NewType2Interface(newtype, wrappedtype1, acc1, wrappedtype2, acc2) \
NewType2Implementation(newtype, wrappedtype1, acc1, wrappedtype2, acc2)

#define NEWTYPE3(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3) \
NewType3Interface(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3) \
NewType3Implementation(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3)

