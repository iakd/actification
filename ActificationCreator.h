#import "LAActificationListener.h"

@interface ActificationCreator : NSObject
+(id)sharedInstance;
-(NSArray*)createListeners;
@end