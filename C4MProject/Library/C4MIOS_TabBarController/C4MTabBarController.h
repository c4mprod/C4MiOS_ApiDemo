/*******************************************************************************
 * This file is part of the C4MiOS_Potentiometer project.
 * 
 * Copyright (c) 2012 C4M PROD.
 * 
 * C4MIOS_TabBarController is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * C4MIOS_TabBarController is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with C4MIOS_TabBarController. If not, see <http://www.gnu.org/licenses/lgpl.html>.
 * 
 * Contributors:
 * C4M PROD - initial API and implementation
 ******************************************************************************/

#import <UIKit/UIKit.h>
#import "TouchTableView.h"
@class C4MTabBarController;

@protocol C4MTabBarControllerDelegate <NSObject>
- (UITableViewCell*)C4MTabBarController:(C4MTabBarController*)_tabBarController withTableView:(UITableView*)_tableView cellForIndex:(int)_index;

@optional
- (double)C4MTabBarController:(C4MTabBarController*)_tabBarController widthForItemAtIndex:(int)_index;
- (void)C4MTabBarController:(C4MTabBarController*)_tabBarController badge:(NSString*)_badgeValue onCell:(UITableViewCell*)_cell atIndex:(int)_index;
@end

@interface C4MTabBarController : UITabBarController<UITableViewDelegate,UITableViewDataSource> {

	NSObject<C4MTabBarControllerDelegate>* mDelegate;
	UIImageView* mBackgroundImageView;
	TouchTableView* mTableView;
}

@property (nonatomic, readonly) TouchTableView*     mTableView;

- (void)setC4MTabBarControllerHeight:(float)_tabBarHeight;
- (void)setScroll:(BOOL)_scroll;

- (void)setTabBarHidden:(BOOL)_hidden;

// deprecated
//-(void)setC4MTabBarControllerBackground:(UIImage*)_image;

@end
