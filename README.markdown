# FunctionalKit: It's Functional for Objective-C.

FunctionalKit is an attempt to use functional paradigms in Objective-C. It is a set of low level 
functional types & APIs. It contains types such as either, option, etc. that allow your to write
correct, clean, tight, succinct and (where possible) typesafe code. It also provides some more
advanced stuff such as lifting functions into monads.

FunctionalKit is loosely modelled on Functional Java.


## Setup

1. Clone the project into your project somewhere, we use Source/External/functionalkit.
1. Add the Source/Main directory into your Xcode project.
1. Rock!


## Examples

### Function creation

Create a function from a selector.

    id <FKFunction> doSomethingFunction = [FKFunction functionFromSelector:@selector(doSomething:) target:self];

### Mapping

Map across the elements of an array of names and turn them into people.

    NSArray *names = [NSArray arrayWithObject:@"Fred", @"Mary", @"Pete", nil];
    NSArray *people = [names map:[FKFunction functionFromSelector:@selector(makePersonFromName:) target:self]];

### Nil values

Handle a possibly nil value safely.

    NSDictionary *dict = ...;
    FKOption *couldBeNil = [KFOption fromNil:[dict objectForKey:@"SomeKey"]];

### Handling failures

Construct an either representing failure.

    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Credentials have not been saved" forKey:NSLocalizedDescriptionKey];
    FKEither *failed = [FKEither leftWithValue:[NSError errorWithDomain:@"InvalidOperation" code:0 userInfo:userInfo]];

Perform an operation that may fail, apply a selector on success, otherwise on failure propagate the error.

    MVEither *maybeResponse = [HttpApi makeRequestToUrl:@"http://www.foo.com/json-api"];
    MVEither *maybeParsedJson = [maybeResponse mapRightWithSelector:@selector(JSONValue)];

### Validate parsed values, turn them into a domain model class on success

Note. This is a bit messy, could be cleaner.

    FKOption *maybeTitle = [FKOption fromNil:[dictionary objectForKey:@"title"] ofType:[NSString class]];
    FKOption *maybeOwnerName = [FKOption fromNil:[dictionary objectForKey:@"owner_name"] ofType:[NSString class]];
    FKOption *maybeHeadlineImgId = [FKOption fromNil:[dictionary objectForKey:@"headline_img_id"] ofType:[NSString class]];
    if ([NSARRAY(maybeTitle, maybeOwnerName, maybeHeadlineImgId) all:@selector(isSome)]) {
    	return [FKOption some:[FlickrGallery galleryWithTitle:[maybeTitle some] ownerName:[maybeOwnerName some] sampleImgId:[maybeHeadlineImgId some]]];
    } else {
    	return [FKOption none];
    }

### Side effects

Comap a function with an effect, to have the function execute then perform a side effect using the function's result.

    id <FKFunction> getPhotosF = [FKFunction functionFromSelector:@selector(photos)];
    id <FKEffect> galleriesOp = [FKEffect comap:[self effectThatDoesSomethingWithPhotos] :getPhotosF];
