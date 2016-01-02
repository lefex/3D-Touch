//
//  AppDelegate.m
//  3D_touch_examlple
//
//  Created by wsy on 15/12/27.
//  Copyright © 2015年 WSY. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@property (nonatomic, strong) UIApplicationShortcutItem *launchShortcutItem;

@end

@implementation AppDelegate

static  NSString *scanQR = @"scan.qr";
static  NSString *myInfo = @"my.info";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 动态快捷键的个数，如果没有，添加2个
    if (application.shortcutItems.count == 0) {
        UIApplicationShortcutItem *scanItem = [[UIApplicationShortcutItem alloc] initWithType: scanQR localizedTitle:@"Scan QR" localizedSubtitle:@"scan qr to add friend" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay] userInfo:nil];
        
        UIApplicationShortcutItem *myInfoItem = [[UIApplicationShortcutItem alloc] initWithType:myInfo localizedTitle:@"My info message" localizedSubtitle:@"detail my info message" icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"btn_sound_open"] userInfo:nil];
        
        // 设置动态的shortcutItem
        application.shortcutItems = @[scanItem, myInfoItem];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler
{
    completionHandler([self handelShortcutItem:shortcutItem]);
}

- (BOOL)handelShortcutItem:(UIApplicationShortcutItem *)shortcutItem
{
    if (!shortcutItem.type) {
        return NO;
    }
    if (![shortcutItem.type isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    return [self isMyShortcutItem:shortcutItem];
}

- (BOOL)isMyShortcutItem:(UIApplicationShortcutItem *)shortcutItem
{
    NSArray *shortcutItemTypes = @[@"com.wsy.share", scanQR, myInfo];
    BOOL isContain = NO;
    if (shortcutItem.type) {
        isContain = [shortcutItemTypes containsObject:shortcutItem.type];
    }
    
    if (isContain) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:shortcutItem.localizedTitle message:shortcutItem.localizedSubtitle preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:nil]];
        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
    return isContain;
}

@end
