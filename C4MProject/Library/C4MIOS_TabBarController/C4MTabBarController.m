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

#import <QuartzCore/QuartzCore.h>

#import "C4MTabBarController.h"


@implementation C4MTabBarController
@synthesize mTableView;

-(void)removeKVOBadge
{
	for(UIViewController* viewController in self.viewControllers)
	{
		[viewController.tabBarItem removeObserver:self forKeyPath:@"badgeValue"];
	}
}
-(void)addKVOBadge
{
	for(UIViewController* viewController in self.viewControllers)
	{
		[viewController.tabBarItem addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:NULL];
	}
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	mTableView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - (mTableView.frame.size.height / 2));
}

- (void)dealloc
{
	[mDelegate release];
	[mTableView release];
	[mBackgroundImageView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)setC4MTabBarControllerHeight:(float)_tabBarHeight
{
	if(!mTableView)
	{
		mTableView = [[TouchTableView alloc] initWithFrame:CGRectMake(0, 0, _tabBarHeight, self.view.frame.size.width)];
	}
	mTableView.transform=CGAffineTransformMakeRotation(-M_PI_2);
	mTableView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - (_tabBarHeight / 2));
	NSLog(@"mTableView.center : %f",mTableView.center.y);
	mTableView.delegate = self;
	mTableView.dataSource = self;
	
	mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	mTableView.backgroundColor = [UIColor clearColor];
	mTableView.scrollEnabled = NO;
	mTableView.showsVerticalScrollIndicator = NO;
	self.tabBar.alpha = 0.1;
	
	[self.view addSubview:mTableView];
	[mTableView reloadData];
}

-(void)setC4MTabBarControllerBackground:(UIImage*)_image
{
	if(!mBackgroundImageView)
		mBackgroundImageView = [[UIImageView alloc] initWithImage:_image];
	
	mBackgroundImageView.userInteractionEnabled=YES;
	mBackgroundImageView.frame = CGRectMake(0, self.view.frame.size.height-_image.size.height, self.view.frame.size.width, _image.size.height);
	
	if(!mTableView)
		mTableView = [[TouchTableView alloc] initWithFrame:CGRectMake(0, 0, _image.size.height, self.view.frame.size.width)];
	
	mTableView.transform=CGAffineTransformMakeRotation(-M_PI_2);
	mTableView.center = CGPointMake(mBackgroundImageView.frame.size.width/2, mBackgroundImageView.frame.size.height/2);
	
	mTableView.delegate =self;
	mTableView.dataSource= self;
	
	mTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
	mTableView.backgroundColor = [UIColor clearColor];
	mTableView.scrollEnabled=NO;
	mTableView.showsVerticalScrollIndicator=NO;
	
	[mBackgroundImageView addSubview:mTableView];
	
	//[self.tabBar setHidden:YES];
	
	[self.view addSubview:mBackgroundImageView];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if([keyPath isEqualToString:@"badgeValue"])
	{
		if([mDelegate respondsToSelector:@selector(C4MTabBarController:badge:onCell:atIndex:)])
		{
			for(int i = 0; i<[self.viewControllers count]; ++i)
			{
				UIViewController* viewController = [self.viewControllers objectAtIndex:i];
				if(viewController.tabBarItem == object)
				{
					UITableViewCell* cell = [mTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
					[mDelegate C4MTabBarController:self badge:viewController.tabBarItem.badgeValue onCell:cell atIndex:i];
					break;
				}
			}
		}
	}
	else if (object == self.tabBar && [keyPath isEqualToString:@"hidden"])
	{
		self.tabBar.alpha = 0.1;
		CATransition *transition = [CATransition animation];
		[transition setType:kCATransitionPush];
		if (self.tabBar.hidden)
		{
			[transition setSubtype:kCATransitionFromBottom];
			[transition setDuration:0.40f];
		}
		else
		{
			[transition setSubtype:kCATransitionFromTop];
			[transition setDuration:0.1f];
		}
		
		[self.navigationController.view.layer addAnimation:transition forKey:nil];
		[mTableView.layer addAnimation:transition forKey:nil];
		mTableView.hidden = self.tabBar.hidden;
	}
	else if([super respondsToSelector:@selector(observeValueForKeyPath:ofObject:change:context:)])
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

-(void)setScroll:(BOOL)_scroll
{
	mTableView.scrollEnabled=_scroll;
}

- (void)setTabBarHidden:(BOOL)_hidden
{
	[self.tabBar setHidden:NO];
}

#pragma mark - TableView Delegate
-(NSIndexPath*)tableView:(UITableView*)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	return indexPath;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIViewController* viewController = [self.viewControllers objectAtIndex:indexPath.row];
	if(![self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)] || [self.delegate tabBarController:self shouldSelectViewController:viewController])
	{
		if(self.selectedIndex!=indexPath.row)
		{
			self.selectedIndex=indexPath.row;
		}
		else if([self.selectedViewController respondsToSelector:@selector(popToRootViewControllerAnimated:)])
		{
			[(UINavigationController*)self.selectedViewController popToRootViewControllerAnimated:YES];
		}
	}
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if([mDelegate respondsToSelector:@selector(C4MTabBarController:tabBarWidthForIndex:)])
		return [mDelegate C4MTabBarController:self widthForItemAtIndex:indexPath.row];
	else
		return self.view.frame.size.width/[self.viewControllers count];
}
#pragma mark - TableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell* cell = [mDelegate C4MTabBarController:self withTableView:mTableView cellForIndex:indexPath.row];
	cell.transform=CGAffineTransformMakeRotation(M_PI_2);
	return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.viewControllers count];
}

#pragma mark - TabBarController subClass
- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
	//[self removeKVOBadge];
	[super setViewControllers:viewControllers animated:animated];
//	[self addKVOBadge];
	[mTableView reloadData];
}
- (void)setViewControllers:(NSArray *)viewControllers
{
	//[self removeKVOBadge];
	[super setViewControllers:viewControllers];
	//[self addKVOBadge];
	[mTableView reloadData];
}
-(void)setDelegate:(id<UITabBarControllerDelegate>)delegate
{
	mDelegate = [delegate retain];
	[super setDelegate:delegate];
	[mTableView reloadData];
}
-(void)setSelectedViewController:(UIViewController *)selectedViewController
{
	NSUInteger index = [self.viewControllers indexOfObject:selectedViewController];
	if(index!=NSNotFound && self.selectedIndex!=index)
		[mTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
	
	[super setSelectedViewController:selectedViewController];
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex
{
	if(self.selectedIndex!=selectedIndex)
	{
		[mTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
		[super setSelectedIndex:selectedIndex];
	}
}
-(void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
{
	//TODO implement hide for custom TabBar
	[super setHidesBottomBarWhenPushed:hidesBottomBarWhenPushed];
}

- (void)viewDidLoad
{
	[self addKVOBadge];
	[self.tabBar addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:NULL];
	[super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidUnload
{
	[self removeKVOBadge];
	[self.tabBar removeObserver:self forKeyPath:@"hidden"];
	[super viewDidUnload];
}

/*- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}*/



@end
