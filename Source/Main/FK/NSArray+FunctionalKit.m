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

@implementation NSArray (FunctionalKitExtensions)

+ (Function)liftFunction:(Function)f {
    Function lifted = ^(id arg) {
        NSArray *array = arg;
        return (id)[array map:f];
    };
    return [[lifted copy] autorelease];
}

+ (NSArray *)concat:(NSArray *)nested {
    NSMutableArray *concatenated = [NSMutableArray array];
    for (id item in nested) {
        if ([item isKindOfClass:[NSArray class]]) {
            [concatenated addObjectsFromArray:item];
        } else {
            NSString *message = @"Cannot concat a non-array value";
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:message userInfo:EMPTY_DICT];
        }
    }
    return [NSArray arrayWithArray:concatenated];
}

- (id)head {
    if ([self count] == 0) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Cannot get the head of an empty array" userInfo:EMPTY_DICT];
    } else {
        return [self objectAtIndex:0];
    }
}

- (NSArray *)tail {
    if ([self count] == 0) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Cannot get the tail of an empty array" userInfo:EMPTY_DICT];
    } else {
        return [self subarrayWithRange:NSMakeRange(1, [self count] - 1)];
    }
}

- (FKP2 *)span:(Predicate)pred {
    NSMutableArray *matching = [NSMutableArray array];
    NSMutableArray *rest = [NSMutableArray array];
	for (id item in self) {
		if (pred(item)) {
            [matching addObject:item];
		} else {
            [rest addObject:item];
        }
	}
    return [FKP2 p2With_1:[NSArray arrayWithArray:matching] _2:[NSArray arrayWithArray:rest]];
}

- (BOOL)all:(Predicate)pred {
	for (id item in self) {
		if (!pred(item)) {
			return NO;
		}
	}
	return YES;
}

- (NSArray *)filter:(Predicate)pred {
    NSMutableArray *filtered = [NSMutableArray arrayWithCapacity:[self count]];
	for (id item in self) {
		if (pred(item)) {
            [filtered addObject:item];
		}
	}
    return [NSArray arrayWithArray:filtered];
}

- (NSDictionary *)groupByKey:(Function)keyFunction {
    NSMutableDictionary *grouped = [NSMutableDictionary dictionary];
	for (id item in self) {
        id key = keyFunction(item);
        id nilsafeKey = key == nil ? [NSNull null] : key;
        NSMutableArray *values = [grouped objectForKey:nilsafeKey];
        if (values == nil) {
            values = [NSMutableArray array];
            [grouped setObject:values forKey:nilsafeKey];
        }
        [values addObject:item];
	}   
    return [NSDictionary dictionaryWithDictionary:grouped];
}

- (id)foldLeft:(id)acc f:(Function2)f {
    id accC = [[acc copy] autorelease];
    for (id item in self) {
        accC = f(accC,item);
    }
    return accC;
}

- (NSArray *)map:(Function)f {
	NSMutableArray *r = [NSMutableArray arrayWithCapacity:[self count]];
	for (id item in self) {
		[r addObject:f(item)];
	}
	return [NSArray arrayWithArray:r];
}

- (void)foreach:(Effect)f {
	for (id item in self) {
		f(item);
	}
}

- (NSArray *)intersperse:(id)object {
    NSMutableArray *interspersed = [NSMutableArray array];
    for (int i = 0; i < [self count]; i++) {
        [interspersed addObject:[self objectAtIndex:i]];
        if (i != [self count] - 1) [interspersed addObject:object];
    }    
    return interspersed;
}

- (NSArray *)reverse {
    NSMutableArray *reversed = [NSMutableArray array];
    for (int i = [self count] - 1; i >= 0; i--) {
        [reversed addObject:[self objectAtIndex:i]];
    }
    return reversed;
}

// TODO This is innefficient, consider writing it manually.
- (NSArray *)unique {
    NSSet *unique = [NSSet setWithArray:self];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (id item in unique) {
        [array addObject:item];
    }
    NSArray *copy = [array copy];
    [array release];
    return [copy autorelease];
}

- (FKOption *)toOption {
    return  [self count] == 0 ? [FKOption none] : [FKOption some:[self objectAtIndex:0]];
}

@end
