#import <Foundation/Foundation.h>

@interface NSDictionary (FunctionalKitExtensions)

// Projects this dictionary as an array of key/value pairs: NSArray[FKP2[id,id]].
- (NSArray *)toArray;

@end
