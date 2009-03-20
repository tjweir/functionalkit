#import "GTMSenTestCase.h"
#import "FKNewtype.h"

NEWTYPE(Age, NSString, age);

NEWTYPE(Name, NSString, name);

NEWTYPE2(Person, Age, age, Name, name);

NEWTYPE3(Position, Person, occupier, NSString, title, NSDate, started);

NEWTYPE3(Simple3, NSString, a, NSString, b, NSString, c); 

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
	
	id <FKFunction> fromArray2 = [[[NSArrayToPerson alloc] init] autorelease];
	id fromValid2 = [fromArray2 :[NSArray arrayWithObjects:[Age age:@"54"], [Name name:@"Nick"], nil]];
	STAssertTrue([fromValid2 isSome], nil);
	STAssertEqualObjects([fromValid2 some], [Person age:[Age age:@"54"] name:[Name name:@"Nick"]], nil);
	
	id <FKFunction> fromArray3 = [[[NSArrayToSimple3 alloc] init] autorelease];
	id fromValid3 = [fromArray3 :[NSArray arrayWithObjects:@"a", @"b", @"c",nil]];
	STAssertTrue([fromValid3 isSome], nil);
	STAssertEqualObjects([fromValid3 some], [Simple3 a:@"a" b:@"b" c:@"c"], nil);
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

