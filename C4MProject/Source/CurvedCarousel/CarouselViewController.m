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

#import "CarouselViewController.h"

@interface CarouselViewController ()

@end

@implementation CarouselViewController
@synthesize mCurvedCarousel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:
                          @"carouselContent" ofType:@"plist"];
        
        NSDictionary* plist = [[NSDictionary alloc] initWithContentsOfFile:path];
        datas = [[NSArray alloc] initWithArray:[plist objectForKey:@"sections"]];
        [plist release];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    //[[UIApplication sharedApplication] setStatusBarHidden: YES withAnimation:UIStatusBarAnimationSlide];
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.mCurvedCarousel = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [mCurvedCarousel animateCarousel:TYPE_INTRO];
}

- (void) viewWillDisappear:(BOOL)animated {
    
    //[mCurvedCarousel animateCarousel:TYPE_OUTRO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    //return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)dealloc 
{
    [datas release];
	[super dealloc];
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(CurvedCarousel *)carousel
{
    return 5;
}

- (NSArray *)pointsOfPath:(CurvedCarousel *)carousel
{
    NSMutableArray* array = [NSMutableArray array];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //320x480
        [array addObject:[NSValue valueWithCGPoint:P(0,240)]];
        [array addObject:[NSValue valueWithCGPoint:P(170, 105)]];
        [array addObject:[NSValue valueWithCGPoint:P(270, 70)]];
        [array addObject:[NSValue valueWithCGPoint:P(355, 66)]];
        [array addObject:[NSValue valueWithCGPoint:P(410, 60)]];
        [array addObject:[NSValue valueWithCGPoint:P(460, 40)]];
    } else {
        //768x1024  x2,4  x2.13
        [array addObject:[NSValue valueWithCGPoint:P(0,600)]];
        [array addObject:[NSValue valueWithCGPoint:P(362, 254)]];
        [array addObject:[NSValue valueWithCGPoint:P(575, 175)]];
        [array addObject:[NSValue valueWithCGPoint:P(756, 168)]];
        [array addObject:[NSValue valueWithCGPoint:P(873, 150)]];
        [array addObject:[NSValue valueWithCGPoint:P(979, 100)]];
    }
    
    return array;
}

- (UIView *)carousel:(CurvedCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    UIImage *image_off = nil;
    UIImage *image_on = nil;
    NSString *label = @"";
    NSArray* bundle;
    
    NSDictionary *section = [datas objectAtIndex:index];
    
    label = [section objectForKey:@"name"];
    
    image_off = [UIImage imageNamed:[NSString stringWithFormat:@"%@_off", [section objectForKey:@"image"]]];
    image_on = [UIImage imageNamed:[NSString stringWithFormat:@"%@_on", [section objectForKey:@"image"]]];
    bundle = [[NSBundle mainBundle] loadNibNamed:@"CarouselItemView"
                                           owner:self
                                         options:nil];
    
    UIView* view = [ bundle objectAtIndex: 0];
    for (UIView *v in view.subviews) {
        if ([v isKindOfClass:[UILabel class]]) {
            UILabel *l = (UILabel*)v;
            [l setText:label];
        }
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *b = (UIButton*)v;
            [b setBackgroundImage:image_off forState:UIControlStateNormal];
            [b setBackgroundImage:image_on forState:UIControlStateHighlighted];
            [b setBackgroundImage:image_on forState:UIControlStateSelected];
        }
    }
    
    return view;
}

- (void)carouselDidScroll:(CurvedCarousel *)carousel atIndex:(int) index{
    
    for (int i = 0; i<[mCurvedCarousel.itemViews count]; i++)
    {
        UIView *v = [mCurvedCarousel.itemViews objectAtIndex:i];
        for (UIView *b in v.subviews) {
			if ([b isKindOfClass:[UIButton class]]) {
				((UIButton*)b).selected = (index == i);
			}
            if ([b isKindOfClass:[UIImageView class]]) {
				((UIImageView*)b).hidden = (index != i);
			}
		}
    }
}

- (void)carouselWillScroll:(CurvedCarousel *)carousel{
    
    for (int i = 0; i<[mCurvedCarousel.itemViews count]; i++)
    {
        UIView *v = [mCurvedCarousel.itemViews objectAtIndex:i];
        for (UIView *b in v.subviews) {
			if ([b isKindOfClass:[UIButton class]]) {
				((UIButton*)b).selected = NO;
			}
            if ([b isKindOfClass:[UIImageView class]]) {
				((UIImageView*)b).hidden = YES;
			}
		}
    }
}


@end
