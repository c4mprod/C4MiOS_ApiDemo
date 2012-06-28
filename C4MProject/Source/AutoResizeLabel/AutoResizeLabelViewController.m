//
//  AutoResizeLabelViewController.m
//  C4MiOS_ApiDemo
//
//  Created by Emeric Janowski on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AutoResizeLabelViewController.h"

@interface AutoResizeLabelViewController ()

@end

@implementation AutoResizeLabelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self onUpdate:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [mAutoResizeLabel release];
    mAutoResizeLabel = nil;
    [mNumberOfLines release];
    mNumberOfLines = nil;
    [mMinimumSize release];
    mMinimumSize = nil;
    [mLabelCurrentFontSIze release];
    mLabelCurrentFontSIze = nil;
    [mTargetedSize release];
    mTargetedSize = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [mAutoResizeLabel release];
    [mNumberOfLines release];
    [mMinimumSize release];
    [mLabelCurrentFontSIze release];
    [mTargetedSize release];
    [super dealloc];
}
- (IBAction)onUpdate:(id)sender {
    NSLog(@"mMinimumSize");
    [mMinimumSize       resignFirstResponder];
    NSLog(@"mNumberOfLines");
    [mNumberOfLines     resignFirstResponder];
    NSLog(@"mTargetedSize");
    [mTargetedSize      resignFirstResponder];
    mAutoResizeLabel.numberOfLines = [mNumberOfLines.text intValue];
    mAutoResizeLabel.minimumFontSize = [mMinimumSize.text intValue];
    mAutoResizeLabel.font = [mAutoResizeLabel.font fontWithSize:[mTargetedSize.text intValue]];
    [self performSelector:@selector(displayCurrentFontSize) withObject:nil afterDelay:0.5];
}

-(void)displayCurrentFontSize
{
    mLabelCurrentFontSIze.text = [NSString stringWithFormat:@"Current font size : %f",mAutoResizeLabel.font.pointSize];
}
@end
