//
//  AppDelegate.m
//  Pandora
//
//  Created by Mac Pro_C on 12-12-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "PDRCoreWindowManager.h"
#import "PDRCore.h"
#import "PDRCommonString.h"
#ifdef PDR_PLUS_UMENG
#import "MobClick.h"
#endif

BOOL bIsDeactivate = YES;

@implementation AppDelegate

@synthesize window = _window;


#pragma mark -
#pragma mark app lifecycle

/*
 * @Summary:程序启动时收到push消息
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    PDRCore *core = [PDRCore Instance];

    //处理openURL
    NSURL *url = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
    if ( url ) {
        [[PDRCore Instance] handleSysEvent:PDRCoreSysEventOpenURL withObject:url];
    }

    //处理aps
#ifdef PDR_PLUS_DHPUSH
    // 注册APS
    if ( launchOptions ) {
        NSDictionary* userInfo  = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if ( userInfo ) {
            [[PDRCore Instance] handleSysEvent:PDRCoreSysEventRevRemoteNotification withObject:[self packageApns:userInfo receive:FALSE]];
        }
    }
    
    NSDictionary *dhDict = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"dhpush"];
    if ( [dhDict isKindOfClass:[NSDictionary class]] ) {
        NSString *appID = [dhDict objectForKey:@"appid"];
        if ( appID ) {
            _pushServer = [MKeyPush defaultInstance];
            [_pushServer setDelegate:self];
            [_pushServer initMkeyPushWithAppID:appID option:nil];
        }
    }
#endif
    //处理本地消息
    if ( launchOptions ) {
        UILocalNotification *localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
        if ( localNotif ) {
            NSMutableDictionary* pDictionary = [self packageApns:localNotif receive:FALSE];
            [[PDRCore Instance] handleSysEvent:PDRCoreSysEventRevLocalNotification withObject:pDictionary];
        }
    }
    
    //注册插件
    //NSString *plugin1JSPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Pandora/apps/H5Plugin/www/js/plugin1.js"];
    //[core regPluginWithName:@"Plugin1" impClassName:@"Plugin1" type:PDRExendPluginTypeFrame javaScriptPath:plugin1JSPath];
    //[core regPluginWithName:@"Plugin2" impClassName:@"Plugin1" type:PDRExendPluginTypeFrame javaScript:nil];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    bIsDeactivate = NO;
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    bIsDeactivate = YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[PDRCore Instance] handleSysEvent:PDRCoreSysEventEnterBackground withObject:nil];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[PDRCore Instance] handleSysEvent:PDRCoreSysEventEnterForeGround withObject:nil];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark URL

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    [self application:application handleOpenURL:url];
    return YES;
}

/*
 * @Summary:程序被第三方调用，传入参数启动
 *
 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [[PDRCore Instance] handleSysEvent:PDRCoreSysEventOpenURL withObject:url];
    return YES;
}



#ifdef PDR_PLUS_DHPUSH

#pragma mark -
#pragma mark APNS
/*
 * @Summary:远程push注册成功收到DeviceToken回调
 *
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[PDRCore Instance] handleSysEvent:PDRCoreSysEventRevDeviceToken withObject:deviceToken];
    NSDictionary *dhDict = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"dhpush"];
    if ( [dhDict isKindOfClass:[NSDictionary class]] ) {
        NSString *url = [dhDict objectForKey:@"url"];
        if ( url ) {
            [_pushServer registerMkeyPushUseDeviceToken:deviceToken toServer:url];
        }
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [_pushServer handleRemoteNotification:userInfo];
}


/*
 * @Summary: 远程push注册失败
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
}

- (NSMutableDictionary*)packageApns:(NSObject*)userInfo receive:(BOOL)bRev
{
    if ( userInfo ) {
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        [dict setObject:userInfo forKey:g_pdr_string_aps];
        if (bRev) {
            [dict setObject:g_pdr_string_receive forKey:g_pdr_string_type];
        } else {
            [dict setObject:g_pdr_string_click forKey:g_pdr_string_type];
        }
        return dict;
    }
    return nil;
}

#pragma mark -
#pragma mark DHPUSH
//收到消息()
- (void)didReceiveMessage:(NSDictionary*)message {
    NSMutableDictionary* pDictionary = [self packageApns:message receive:!bIsDeactivate];
    [[PDRCore Instance] handleSysEvent:PDRCoreSysEventRevRemoteNotification withObject:pDictionary];
}

//收到炸弹短息消息
- (void)didReceiveBombMessage {
    
}
/*
//过程中出现错误
- (void)didReceiveFailWithError:(NSError*)error {
}
*/
#endif

#pragma mark -
#pragma mark other
/*
 * @Summary:程序收到本地消息
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSMutableDictionary* pDictionary = [self packageApns:notification receive:!bIsDeactivate];
    [[PDRCore Instance] handleSysEvent:PDRCoreSysEventRevLocalNotification withObject:pDictionary];
}

- (void)dealloc
{
#ifdef PDR_PLUS_MAP
    [_mapManager stop];
//    [_mapManager release];
    _mapManager = nil;
#endif
//    [super dealloc];
}

@end
