#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [GeneratedPluginRegistrant registerWithRegistry:self];
    
//    self.flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter.ocrSDKKit"];
//    [self.flutterEngine run];
//    FlutterViewController *flutterVC = [[IdCardViewController alloc] initWithEngine:self.flutterEngine nibName:@"IdCardViewController" bundle:[NSBundle mainBundle]];
//
//    [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];
    // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
//    self.window.backgroundColor = [UIColor whiteColor];
//
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:flutterVC];
//    [self.window makeKeyAndVisible];
    
//    return YES;
}

@end
