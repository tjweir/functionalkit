#import "NSArray+FunctionalKit.h"
#import "FKMacros.h"

// TODO - Add stuff like these
//@interface NSArray (FK)
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
	id <FKFunction> wrappedF;
}

READ id <FKFunction> wrappedF;

- (FKLiftedFunction *)initWithF:(FKFunction *)wrappedF;

@end

@implementation FKLiftedFunction

@synthesize wrappedF;

- (FKLiftedFunction *)initWithF:(FKFunction *)inWrappedF {
	if ((self = [super init])) {
		wrappedF = [inWrappedF retain];
	}
	return self;
}

- (id):(id)arg {
	assert([arg isKindOfClass:[NSArray class]]);
	NSArray *argArray = arg;
	NSMutableArray *arr = [NSMutableArray arrayWithCapacity:[arg count]];
	for (id obj in argArray) {
		[arr addObject:[wrappedF :obj]];
	}
	return arr;
}

#pragma mark NSObject methods.
- (void) dealloc {
    [wrappedF release];
    [super dealloc];
}

- (BOOL)isEqual:(id)object {
    return object == nil || ![[object class] isEqual:[FKFunction class]] ? NO : [wrappedF isEqual:((FKLiftedFunction *) object).wrappedF];
}

- (NSUInteger)hash {
    return 42;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%s wrappedF: %@>", class_getName([self class]), wrappedF];
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
