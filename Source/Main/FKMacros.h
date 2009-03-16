#define ATTR @property (nonatomic, retain)
#define READ @property (readonly)

#define NSARRAY(args...) [NSArray arrayWithObjects:args, nil]
#define EMPTY_ARRAY [NSArray array]

#define NSDICT(args...) [NSDictionary dictionaryWithObjectsAndKeys:args, nil]
#define EMPTY_DICT [NSDictionary dictionary]
