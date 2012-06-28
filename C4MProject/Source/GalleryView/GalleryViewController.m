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

#import "GalleryViewController.h"

@interface GalleryViewController ()

@end

@implementation GalleryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mListElements = [[NSArray alloc] initWithObjects:@"view1",@"view2", @"view3", @"view4", nil];
        startIndex = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [mCarouselView buildView];
    [mCarouselView setDataSource:self];
    [mCarouselView setDelegate:self];
    [mCarouselView setCellWidth:320];
    mCarouselView.mTableView.pagingEnabled = TRUE;	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
    
    [mPageControl setPageControl:[mListElements count] withPaddingX:3 withImage:[UIImage imageNamed:@"point_beige"] andSelectedImage:[UIImage imageNamed:@"point_rouge"]];
    [mPageControl selectPageControl:startIndex];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) dealloc {
    
    [mListElements release];
    [super dealloc];
    
}

#pragma mark -
#pragma mark Table View Data Source Method


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mListElements count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"GalleryCell";
    
    GalleryCell * cell = (GalleryCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) 
    {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        for (id oneObject in nib) 
        {
            if ([oneObject isKindOfClass:[GalleryCell class]])
            {
                cell = (GalleryCell *)oneObject;
            }
        }
    }
    
    UILabel *label = (UILabel*)[cell viewWithTag:1];
    label.text  = [mListElements objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{	
    float offsetY			= scrollView.contentOffset.y;
    int selectedIndex		= (int)(offsetY / 320);
    
    [mPageControl selectPageControl:selectedIndex];
}

@end
