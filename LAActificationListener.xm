#import "LAActificationListener.h"

@implementation LAActificationListener

-(id)initWithName:(NSString*)name msgTitle:(NSString*)title msgContent:(NSString*)content msgBundle:(NSString*)bundle {
    if(self = [super init]) {
        afName = name;
        afTitle = title;
        afContent = content;
        afBundle = bundle;
    }
    
    return self;
}

-(void)activator:(LAActivator*)activator receiveEvent:(LAEvent*)event {
    [self sendNotificationWithTitle:afTitle
                            message:afContent
                         fromBundle:afBundle];
    event.handled = YES;
}

-(void)sendNotificationWithTitle:(NSString*)title message:(NSString*)msg fromBundle:(NSString*)bundle {
    id bulletinServer = [%c(BBServer) customSharedInstance];
    
    id bulletin = [[%c(BBBulletin) alloc] init];
    [bulletin setSectionID:bundle];
    [bulletin setTitle:title];
    [bulletin setExpirationDate:[[NSDate date]dateByAddingTimeInterval:30]];
    [bulletin setMessage:msg];
    [bulletin setClearable:YES];
    [bulletin setBulletinID:[NSString stringWithFormat:@"%@-%@", [NSString stringWithFormat:@"%d", arc4random_uniform(21474836)], [NSString stringWithFormat:@"%d", arc4random_uniform(21474836)]]];
    [bulletin setDate:[NSDate date]];
    [bulletin setPublicationDate:[NSDate date]];
    [bulletin setLastInterruptDate:[NSDate date]];
     
     if(bulletin && bulletinServer)
        [bulletinServer publishBulletin:bulletin destinations:14 alwaysToLockScreen:YES];
    else
        NSLog(@"Actification: Bulletin could not be sent to BBServer!");
    
    [bulletin release];
}

-(NSString *)activator:(LAActivator *)activator requiresLocalizedGroupForListenerName:(NSString *)listenerName {
    return @"Actification";
}

-(NSString *)activator:(LAActivator *)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName {
    return [NSString stringWithFormat:@"Actification: %@", afName];
}

-(NSString *)activator:(LAActivator *)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName {
    return [NSString stringWithFormat:@"Send a notification with title \"%@\" and text \"%@\"", afTitle, afContent];
}

-(NSString*)listenerName {
    return afName;
}

@end