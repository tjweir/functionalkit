#import "FKEffect.h"

@interface ComapEffectFunction : NSObject <FKEffect> {
	id <FKFunction> f;
	id <FKEffect> e;
}

- (id)initWithEffect:(id <FKEffect>)effect andF:(id <FKFunction>)function;
@end

@implementation ComapEffectFunction
- (id)initWithEffect:(id <FKEffect>)effect andF:(id <FKFunction>)function {
	if ((self = [super init])) {
		e = [effect retain];
		f = [function retain];
	}
	return self;
}

- (oneway void)e:(id)arg {
	[e e:[f :arg]];
}

- (void)dealloc {
	[e release];
	[f release];
	[super dealloc];
}

@end

@implementation FKEffect
+ (id <FKEffect>)comap:(id <FKEffect>)effect :(id<FKFunction>)function {
	return [[[ComapEffectFunction alloc] initWithEffect:effect andF:function] autorelease];
}
@end
