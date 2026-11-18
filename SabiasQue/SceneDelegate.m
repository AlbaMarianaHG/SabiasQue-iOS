#import "SceneDelegate.h"
#import "ViewController.h"

@implementation SceneDelegate

- (void)scene:(UIScene *)scene
willConnectToSession:(UISceneSession *)session
options:(UISceneConnectionOptions *)connectionOptions {
    
    if ([scene isKindOfClass:[UIWindowScene class]]) {
        
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        
        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
        
        ViewController *viewController = [[ViewController alloc] init];
        
        self.window.rootViewController = viewController;
        
        [self.window makeKeyAndVisible];
    }
}

@end
