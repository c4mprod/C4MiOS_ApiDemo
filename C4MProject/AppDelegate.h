//
//  AppDelegate.h
//  C4MProject
//
//  Created by  on 29/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWHockeyManager.h"
#import "BWQuincyManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,BWHockeyManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UISplitViewController *splitViewController;

@end
