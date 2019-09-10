//
//  AppDelegate.h
//  coreData-Mystore
//
//  Created by deerwang(王东东) on 2019/8/15.
//  Copyright © 2019 deerwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

