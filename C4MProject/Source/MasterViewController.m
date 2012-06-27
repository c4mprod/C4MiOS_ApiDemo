/*******************************************************************************
 * This file is part of the C4MiOS_ApiDemo project.
 * 
 * Copyright (c) 2012 C4M PROD.
 * 
 * C4MiOS_ApiDemo is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * C4MiOS_ApiDemo is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with C4MiOS_ApiDemo. If not, see <http://www.gnu.org/licenses/lgpl.html>.
 * 
 * Contributors:
 * C4M PROD - initial API and implementation
 ******************************************************************************/

#import "MasterViewController.h"
#import "RequestManagerViewController.h"
#import "ImageManagerViewController.h"
#import "CarouselViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        NSString *path = [[NSBundle mainBundle] pathForResource:
                          @"api" ofType:@"plist"];
        
        NSDictionary* plist = [[NSDictionary alloc] initWithContentsOfFile:path];
        datas = [[NSArray alloc] initWithArray:[plist objectForKey:@"listing"]];
        [plist release];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)aTableView 
{
	return 1;
}

- (NSInteger) tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {

	return [datas count];
	
}

- (UITableViewCell *) tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *name = @"ApiTableViewCell";
    
    UITableViewCell *cell = [mTableView dequeueReusableCellWithIdentifier:name];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name] autorelease];
    }
    
    NSDictionary* itemDic = [datas objectAtIndex:indexPath.row];
    cell.textLabel.text = [itemDic objectForKey:@"label"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary* itemDic = [datas objectAtIndex:indexPath.row];
    NSString* ctrl = [itemDic objectForKey:@"controller"];
    
    if (ctrl)
    {
        if ([ctrl isEqualToString:@"RequestManagerViewController"]){
            RequestManagerViewController *cvc = [[[RequestManagerViewController alloc] initWithNibName:@"RequestManagerViewController" bundle:nil] autorelease];
            [self.navigationController pushViewController:cvc animated:YES];
        } else if ([ctrl isEqualToString:@"ImageManagerViewController"]){
            ImageManagerViewController *cvc = [[[ImageManagerViewController alloc] initWithNibName:@"ImageManagerViewController" bundle:nil] autorelease];
            [self.navigationController pushViewController:cvc animated:YES];
        } else if ([ctrl isEqualToString:@"CarouselViewController"]){
            CarouselViewController *cvc = [[[CarouselViewController alloc] initWithNibName:@"CarouselViewController" bundle:nil] autorelease];
            [self.navigationController pushViewController:cvc animated:YES];
        }
        
    }
    
	
    
}







@end
