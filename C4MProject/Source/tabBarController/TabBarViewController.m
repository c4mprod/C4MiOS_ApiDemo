//
//  TabBarViewController.m
//  C4MiOS_ApiDemo
//
//  Created by Emeric Janowski on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TabBarViewController.h"
#import "TabBarCell.h"


@implementation TabBarViewController
@synthesize tabBarController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    [tabBarController.view removeFromSuperview];
    tabBarController.view.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    [self.view addSubview:tabBarController.view];
    
    [self.tabBarController setC4MTabBarControllerHeight:72];
    [self.tabBarController.mTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [tabBarController release];
    [super dealloc];
}

#pragma mark -
#pragma mark C4MTabBarController delegate

- (UITableViewCell*)C4MTabBarController:(C4MTabBarController*)_tabBarController withTableView:(UITableView*)_tableView cellForIndex:(int)_index
{
    NSLog(@"C4MTabBarController");
    static NSString* TabBarCellCellIdentifier = @"TabBarCell";
	
	TabBarCell * cell = (TabBarCell *)[_tableView dequeueReusableCellWithIdentifier:TabBarCellCellIdentifier];
	if (cell == nil) 
	{
		NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"TabBarCell" owner:self options:nil];
		for (id oneObject in nib) 
		{
			if ([oneObject isKindOfClass:[TabBarCell class]])
			{
				cell = (TabBarCell *)oneObject;
				cell.backgroundView = nil;
			}
		}
	}
	if(_index ==0)
    {
       // [cell updateWithBackgroundImage:[UIImage imageNamed:@"tabBar_background.png"] image:[UIImage imageNamed:@"icon_footer_historique.png"] highlightedImage:[UIImage imageNamed:@"icon_footer_historique.png"]];
        [cell updateWithBackgroundImage:[UIImage imageNamed:@"tabBar_background.png"] image:[UIImage imageNamed:@"icon_footer_reglages_off.png"] highlightedImage:[UIImage imageNamed:@"icon_footer_reglages.png"] text:@"Item 1"];
    }
    else 
    {
     //   [cell updateWithBackgroundImage:[UIImage imageNamed:@"tabBar_background2.png"] image:[UIImage imageNamed:@"icon_footer_historique.png"] highlightedImage:[UIImage imageNamed:@"icon_footer_historique.png"]];
        [cell updateWithBackgroundImage:[UIImage imageNamed:@"tabBar_background2.png"] image:[UIImage imageNamed:@"icon_footer_historique_off.png"] highlightedImage:[UIImage imageNamed:@"icon_footer_historique.png"] text:@"Item 2"];
    }
	
	return cell;
}
@end
