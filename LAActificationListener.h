#import <libactivator/libactivator.h>

@interface LAActificationListener : NSObject <LAListener> {
    NSString* afName;
    NSString* afTitle;
    NSString* afContent;
    NSString* afBundle;
}

-(id)initWithName:(NSString*)name msgTitle:(NSString*)title msgContent:(NSString*)content msgBundle:(NSString*)bundle;
-(NSString*)listenerName;
@end