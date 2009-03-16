#import "NSArray+FunctionalKit.h"

// TODO - Add stuff like these
//@interface NSArray (FK)
//- (NSArray *)map:(id <FKFunction>)f;
//- (NSArray *)zip:(NSArray *)other;
//@end
//
//@implementation NSArray (FK)
//- (NSArray *)zip:(NSArray *)other {
//	assert([other count] == [self count]);
//	NSMutableArray *r = [NSMutableArray arrayWithCapacity:[self count]];
//	for (int i = 0; i < [self count]; ++i) {
//		[r addObject:[FKP2 p2With_1:[self objectAtIndex:i] _2:[other objectAtIndex:i]]];
//	}
//	return [NSArray arrayWithArray:r];
//}
//@end

@interface FKLiftedFunction : NSObject <FKFunction> {
	id <FKFunction> f;
}
- (FKLiftedFunction *)initWithF:(FKFunction *)f;
@end
@implementation FKLiftedFunction
- (FKLiftedFunction *)initWithF:(FKFunction *)inF {
	if ((self = [super init])) {
		f = [inF retain];
	}
	return self;
}

- (id):(id)arg {
	assert([arg isKindOfClass:[NSArray class]]);
	NSArray *argArray = arg;
	NSMutableArray *arr = [NSMutableArray arrayWithCapacity:[arg count]];
	for (id obj in argArray) {
		[arr addObject:[f :obj]];
	}
	return arr;
}

@end

@implementation NSArray (FunctionalKitExtensions)

- (BOOL)all:(SEL)predicate {
	for (id object in self) {
		if (![object performSelector:predicate]) {
			return NO;
		}
	}
	return YES;
}

- (NSArray *)map:(id <FKFunction>)f {
	NSMutableArray *r = [NSMutableArray arrayWithCapacity:[self count]];
	for (id o in self) {
		[r addObject:[f :o]];
	}
	return [NSArray arrayWithArray:r];
}

+ (id <FKFunction>)liftFunction:(id <FKFunction>)f {
	return [[[FKLiftedFunction alloc] initWithF:f] autorelease];
}

@end
