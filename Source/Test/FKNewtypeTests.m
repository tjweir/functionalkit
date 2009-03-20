#import "GTMSenTestCase.h"
#import "FKNewtype.h"

NEWTYPE(Age, NSString, age);

NEWTYPE(Name, NSString, name);

NEWTYPE2(Person, Age, age, Name, name);

NEWTYPE3(Position, Person, occupier, NSString, title, NSDate, started);

@interface FKNewtypeTests : GTMTestCase
@end

@implementation FKNewtypeTests
- (void)testTypes {
	Age *age = [Age age:@"54"];
	Name *name = [Name name:@"Nick"];
	Person *nick = [Person age:age name:name];
	Position *p = [Position occupier:nick title:@"Dev" started:[NSDate date]];
	STAssertEqualObjects(age.age, @"54", nil);
	STAssertEqualObjects(nick.name.name, @"Nick", nil);
	STAssertEqualObjects(p.title, @"Dev", nil);
}

- (void)testValidArrayCreation {
	id <FKFunction> fromArray = [[[NSArrayToAge alloc] init] autorelease];
	id fromValid = [fromArray :[NSArray arrayWithObject:@"54"]];
	STAssertTrue([fromValid isSome], nil);
	STAssertEqualObjects([fromValid some], [Age age:@"54"], nil);
}

- (void)testWrongSizeArrayCreation {
	id <FKFunction> fromArray = [[[NSArrayToAge alloc] init] autorelease];
	
	id fromEmpty = [fromArray :EMPTY_ARRAY];
	STAssertTrue([fromEmpty isKindOfClass:[FKOption class]],nil);
	STAssertTrue([fromEmpty isNone], nil);
	
	id fromTooBig = [fromArray :NSARRAY(@"54", @"55")];
	STAssertTrue([fromTooBig isKindOfClass:[FKOption class]],nil);
	STAssertTrue([fromTooBig isNone], nil);
}

- (void)testWrongTypeArrayCreation {
	id <FKFunction> fromArray = [[[NSArrayToAge alloc] init] autorelease];
	id fromWrongType = [fromArray :NSARRAY([NSNumber numberWithInt:54])];
	STAssertTrue([fromWrongType isKindOfClass:[FKOption class]],nil);
	STAssertTrue([fromWrongType isNone], nil);
}
@end

