//
//  LocationManagerViewController.m
//  C4MiOS_ApiDemo
//
//  Created by Emeric Janowski on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationManagerViewController.h"

@interface LocationManagerViewController ()

@end

@implementation LocationManagerViewController
@synthesize mButtonStartGeoloc;
@synthesize mGeolocLabel;
@synthesize mCurrentLocation;

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
    [self setMGeolocLabel:nil];
    [self setMCurrentLocation:nil];
    [self setMButtonStartGeoloc:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)receiveUserLocation:(CLLocation*)_Location
{
    NSLog(@"receiveUserLocation");
}

- (void)receivePlaceMark:(NSDictionary*)_placeMark
{
    mGeolocLabel.text = _placeMark.description;
}

- (void)receiveError:(NSError*)_error
{
    
}

- (void)receiveCoordinateFromLocation:(NSDictionary*)_coordinateDictionary
{
    NSLog(@"receiveCoordinateFromLocation");
}

- (IBAction)updateGeoloc:(id)sender 
{
    [[NSNotificationCenter defaultCenter] 
     addObserver:self 
     selector:@selector(receivePlaceMark:) 
     name:@"receivePlaceMark" object:nil];

    C4MLocationManager* loc = [[C4MLocationManager alloc] init];
    [loc getPlaceMarkFromCurrentLocation];
    [loc release];
}

- (IBAction)startLocation:(id)sender 
{
    C4MLocationManager* loc = [[C4MLocationManager alloc] init];
    loc.mDelegate = self;
    [loc startLocationWithAccuracy:kCLLocationAccuracyBest];
    [loc release];
}
- (void)dealloc {
    [mGeolocLabel release];
    [mCurrentLocation release];
    [mButtonStartGeoloc release];
    [super dealloc];
}
@end
