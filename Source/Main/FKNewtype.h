
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

#import "MVP1.h"
#import "MVP2.h"
#import "MVP3.h"

// TODO make the contructors type check harder, so that 'id' can't be passed in

// P1 newtype
#define NewTypeInterface(newtype, wrappedtype, accessor) \
@interface newtype : MVP1 \
+ (newtype *)accessor:(wrappedtype *)thing; \
@property (readonly) wrappedtype *accessor; \
@end

#define NewTypeImplementation(newtype, wrappedtype, accessor) \
@implementation newtype \
@synthesize accessor=_1; \
- (newtype *)initWith_1:(wrappedtype *)new_1 { return ((self = [super initWith_1:new_1])); } \
+ (newtype *)accessor:(wrappedtype *)thing { return [[[self alloc] initWith_1:thing] autorelease]; } \
@end

// P2 newtype
#define NewType2Interface(newtype, wrappedtype1, acc1, wrappedtype2, acc2) \
@interface newtype : MVP2 \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2; \
@property (readonly) wrappedtype1 *acc1; @property (readonly) wrappedtype2 *acc2; \
@end

#define NewType2Implementation(newtype, wrappedtype1, acc1, wrappedtype2, acc2) \
@implementation newtype \
@synthesize acc1=_1, acc2=_2; \
- (newtype *)initWith_1:(wrappedtype1 *)acc1 _2:(wrappedtype2 *)acc2 { return ((self = [super initWith_1:acc1 _2:acc2])); } \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 { return [[[self alloc] initWith_1:acc1 _2:acc2] autorelease]; } \
@end

// P3 newtype
#define NewType3Interface(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3) \
@interface newtype : MVP3 \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 acc3:(wrappedtype3 *)acc3; \
@property (readonly) wrappedtype1 *acc1; @property (readonly) wrappedtype2 *acc2; @property (readonly) wrappedtype3 *acc3; \
@end

#define NewType3Implementation(newtype, wrappedtype1, acc1, wrappedtype2, acc2, wrappedtype3, acc3) \
@implementation newtype \
@synthesize acc1=_1, acc2=_2, acc3=_3; \
- (newtype *)initWith_1:(wrappedtype1 *)acc1 _2:(wrappedtype2 *)acc2 _3:(wrappedtype3 *)acc3 { return ((self = [super initWith_1:acc1 _2:acc2 _3:acc3])); } \
+ (newtype *)acc1:(wrappedtype1 *)acc1 acc2:(wrappedtype2 *)acc2 acc3:(wrappedtype3 *)acc3 { return [[[self alloc] initWith_1:acc1 _2:acc2 _3:acc3] autorelease]; } \
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

