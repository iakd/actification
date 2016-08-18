#import "ActificationCreator.h"

@implementation ActificationCreator

+(id)sharedInstance {
    static dispatch_once_t p = 0;
    
    __strong static id _sharedObject = nil;
    
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}

-(NSArray*)createListeners {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:@"/var/mobile/Actification" error:nil];
    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.plist'"];
    NSArray *onlyPlists = [dirContents filteredArrayUsingPredicate:fltr];
    
    NSMutableArray* listeners = [[NSMutableArray alloc] init];
    
    for(NSString* str in onlyPlists) {
        [listeners addObject:[self createListenerFromPlist:str]];
    }
    
    return listeners;
}

-(LAActificationListener*)createListenerFromPlist:(NSString*)path {
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/var/mobile/Actification/%@", path]];
    
    NSString* title = [plistDict objectForKey:@"NotificationTitle"];
    NSString* content = [plistDict objectForKey:@"NotificationContent"];
    NSString* bundle = [plistDict objectForKey:@"NotificationOrigin"];
    
    return [[LAActificationListener alloc]initWithName:[path stringByReplacingOccurrencesOfString:@".plist" withString:@""] msgTitle:title msgContent:content msgBundle:bundle];
}

@end