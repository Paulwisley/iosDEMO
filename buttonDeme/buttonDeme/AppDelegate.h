//
//  AppDelegate.h
//  buttonDeme
//
//  Created by Paul on 2018/12/14.
//  Copyright © 2018 Dingzhijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

