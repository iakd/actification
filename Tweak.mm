#import "ActificationCreator.h"

%ctor {
    ActificationCreator* creator = [ActificationCreator sharedInstance];
    
    NSLog(@"Actification: Looking for listeners...");
    NSArray* listeners = [creator createListeners];
    
    for(LAActificationListener* l in listeners) {
        NSLog(@"Actification: Register listener %@", [l listenerName]);
        [[LAActivator sharedInstance] registerListener:l forName:[NSString stringWithFormat:@"de.iakdev.actification.activator.%@", [l listenerName]]];
    }
}

%hook BBServer
static id sharedBBServer = nil;

%new
+(id)customSharedInstance {
    if([%c(BBServer) respondsToSelector:@selector(IS2_sharedInstance)]) {
        return [self IS2_sharedInstance]; // iOS 8
    }
    
    return sharedBBServer;
}

-(id)init {
    sharedBBServer = %orig;
    return sharedBBServer;
}
%end