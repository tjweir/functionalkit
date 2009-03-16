#import "GTMSenTestCase.h"
#import "MVNewtype.h"
NEWTYPE(Age, NSString, age);
NEWTYPE(Name, NSString, name);
NEWTYPE2(Person, Age, age, Name, name);

NEWTYPE3(Position, Person, occupier, NSString, title, NSDate, started);

@interface MVNewtypeTests : GTMTestCase
@end

@implementation MVNewtypeTests
- (void)testTypes {
	Age *age = [Age age:@"54"];
	Name *name = [Name name:@"Nick"];
	Person *nick = [Person age:age name:name];
	Position *p = [Position occupier:nick title:@"Dev" started:[NSDate date]];
	STAssertEqualObjects(age.age, @"54", nil);
	STAssertEqualObjects(nick.name.name, @"Nick", nil);
	STAssertEqualObjects(p.title, @"Dev", nil);
}
@end

