//
//  CustomPopupFrameViewController.m
//  C4MiOS_ApiDemo
//
//  Created by Damien Praca on 6/29/12.
//  Copyright (c) 2012 C4MProd. All rights reserved.
//

#import "CustomPopupFrameViewController.h"

@interface CustomPopupFrameViewController ()

@end

@implementation CustomPopupFrameViewController
@synthesize mMessage;
@synthesize mTitle;
@synthesize mClose;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setMMessage:nil];
    [self setMTitle:nil];
    [self setMClose:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [mMessage release];
    [mTitle release];
    [mClose release];
    [super dealloc];
}
- (IBAction)onClose:(id)sender {
    
    [C4MPopup hideCustomPopupWithClickedButtonIndex:0];
}
@end
