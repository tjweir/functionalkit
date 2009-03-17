#ifndef ATTR
#define ATTR @property (nonatomic, retain)
#endif

#ifndef READ
#define READ @property (readonly)
#endif

#ifndef NSARRAY
#define NSARRAY(args...) [NSArray arrayWithObjects:args, nil]
#endif

#ifndef EMPTY_ARRAY
#define EMPTY_ARRAY [NSArray array]
#endif

#ifndef NSDICT
#define NSDICT(args...) [NSDictionary dictionaryWithObjectsAndKeys:args, nil]
#endif

#ifndef EMPTY_DICT
#define EMPTY_DICT [NSDictionary dictionary]
#endif