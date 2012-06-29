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
//@synthesize mGeolocLabel;
@synthesize mCurrentLocation;
@synthesize mUserLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    [[NSNotificationCenter defaultCenter] 
     addObserver:self 
     selector:@selector(receivePlaceMark:) 
     name:@"receivePlaceMark" object:nil];
    
    [[NSNotificationCenter defaultCenter] 
     addObserver:self 
     selector:@selector(receiveUserLocation:) 
     name:@"receiveUserLocation" object:nil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
   // [self setMGeolocLabel:nil];
    [self setMCurrentLocation:nil];
    [self setMButtonStartGeoloc:nil];
    [self setMUserLocation:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)receiveUserLocation:(NSNotification*)_notification
{
    NSLog(@"receiveUserLocation %@",_notification);
    
    CLLocation* loc = [_notification object];
    mUserLocation.text = [NSString stringWithFormat:@"%f \n%f",loc.coordinate.latitude, loc.coordinate.longitude]; 
}

- (void)receivePlaceMark:(NSDictionary*)_placeMark
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:_placeMark.description delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
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
/*
    C4MLocationManager* loc = [[C4MLocationManager alloc] init];
    [loc getPlaceMarkFromCurrentLocation];
    [loc release];*/
    [C4MLocationManager getPlaceMarkFromCurrentLocationWithIdentifier:@"placeMarkIdentifier"];
}

- (IBAction)startLocation:(id)sender 
{
   /* C4MLocationManager* loc = [[C4MLocationManager alloc] init];
    loc.mDelegate = self;
    [loc startLocationWithAccuracy:kCLLocationAccuracyBest];
    [loc release];*/
    
}

- (IBAction)getUserLocation:(id)sender 
{
    [C4MLocationManager getUserLocationWithIdentifier:@"getUserLocation"];
}

- (void)dealloc {
   // [mGeolocLabel release];
    [mCurrentLocation release];
    [mButtonStartGeoloc release];
    [mUserLocation release];
    [super dealloc];
}
@end
