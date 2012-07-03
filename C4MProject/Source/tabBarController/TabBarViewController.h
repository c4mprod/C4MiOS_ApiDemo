//
//  TabBarViewController.h
//  C4MiOS_ApiDemo
//
//  Created by Emeric Janowski on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C4MTabBarController.h"

@interface TabBarViewController : UIViewController 
<UITabBarControllerDelegate, C4MTabBarControllerDelegate>
@property (nonatomic, retain) IBOutlet C4MTabBarController *tabBarController;
@end
