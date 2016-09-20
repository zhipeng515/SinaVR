//
//  AppDelegate.m
//  SinaVR
//
//  Created by zhipeng on 16/9/19.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "AppDelegate.h"

#import "DAUViewController.h"
#import "DAUNavigationController.h"
#import "DAUTabbarController.h"
#import "DAUManager.h"
#import "ObjectManager.h"
#import "Action.h"
#import "UIWrapper.h"
#include "Data.h"

#import "PanoPlayer.h"

@interface AppDelegate ()

- (void)initGlobalInfo;

@end

@implementation AppDelegate

- (void)initGlobalInfo
{
    NSDictionary * jsonDict = [DAUManager getDictionaryFromJsonFile:@"ObjectCreator"];
    [[ObjectManager shareInstance] loadObjectCreator:jsonDict];
    
    jsonDict = [DAUManager getDictionaryFromJsonFile:@"ModelDefine"];
    [[DAUManager shareInstance] loadModelDefine:jsonDict];
}

- (void)viewDidLoad:(nullable Data*)param
{
    DAUViewController * viewController = param[@"self"];
    Data * member = [[Data alloc] initWithScope:viewController.uiWrapper.scope];
    
    PanoPlayerUrl *panoPlayerUrl = [[PanoPlayerUrl alloc] init];
    NSString *app_config_pic = @"http://www.detu.com/ajax/pano/xml/116913";
    [panoPlayerUrl SetXMlUrl:app_config_pic];
    
    PanoPlayer *panoPlayer = [[PanoPlayer alloc] init];
    member[@"panoPlayer"] = panoPlayer;
    [viewController.view addSubview:panoPlayer];
    panoPlayer.frame = CGRectMake(0, 80, 540, 200);
    panoPlayer.gyroEnable = true;
    
    [panoPlayer Play:panoPlayerUrl];
    
    PanoPlayerUrl *panoPlayerUrl1 = [[PanoPlayerUrl alloc] init];
    NSString *app_config_pic1 = @"http://www.detu.com/ajax/pano/xml/116912";
    [panoPlayerUrl1 SetXMlUrl:app_config_pic1];
    
    PanoPlayer *panoPlayer1 = [[PanoPlayer alloc] init];
    member[@"panoPlayer1"] = panoPlayer1;
    [viewController.view addSubview:panoPlayer1];
    panoPlayer1.frame = CGRectMake(0, 300, 540, 200);
    panoPlayer1.gyroEnable = true;
    
    [panoPlayer1 Play:panoPlayerUrl1];
}

- (void)viewWillAppear:(nullable Data*)param
{
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initGlobalInfo];
    
    UIWrapper * controller1 = [DAUViewController createDAUViewController:@"PanoController"];
    [controller1.ui setTitle:@"注册1"];
    [controller1 addAction:self withSelector:@"viewDidLoad:" withTrigger:@"viewDidLoad"];
    [controller1 addAction:self withSelector:@"viewWillAppear:" withTrigger:@"viewWillAppear"];

    UIWrapper * controller2 = [DAUViewController createDAUViewController:@"RegisterViewController"];
    [controller2.ui setTitle:@"注册2"];
    UIWrapper * controller3 = [DAUViewController createDAUViewController:@"RegisterViewController"];
    [controller3.ui setTitle:@"注册3"];
    
    UIWrapper * naviController1 = [DAUNavigationController createDAUNavigationController:@"RootNavigationController" withRootViewController:controller1];
    UIWrapper * naviController2 = [DAUNavigationController createDAUNavigationController:@"RootNavigationController" withRootViewController:controller2];
    UIWrapper * naviController3 = [DAUNavigationController createDAUNavigationController:@"RootNavigationController" withRootViewController:controller3];
    
    UIWrapper * tabbarController = [DAUTabbarController createDAUTabbarController:@"RootTabbarController" withViewControllers:@[naviController1, naviController2, naviController3]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:tabbarController.ui];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
