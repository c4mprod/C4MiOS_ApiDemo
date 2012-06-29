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
@synthesize mTextfieldAddress;
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
    
    [[NSNotificationCenter defaultCenter] 
     addObserver:self 
     selector:@selector(receiveObjectFromAddrString:) 
     name:@"getCoordinationFromAddrString" object:nil];
    
    [[NSNotificationCenter defaultCenter] 
     addObserver:self 
     selector:@selector(receiveError:) 
     name:@"receiveError" object:nil];
    
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
    [self setMTextfieldAddress:nil];
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
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"receivePlaceMark" message:_placeMark.description delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
}
- (void)receiveObjectFromAddrString:(NSNotification*)_notification
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"receiveObjectFromAddrString" message:[NSString stringWithFormat:@"%@",[_notification object]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    [alert release];
}
- (void)receiveError:(NSNotification*)_notification
{
    NSLog(@"Error : %@",((NSError*)[_notification object]).localizedDescription);
}

- (void)receiveCoordinateFromLocation:(NSDictionary*)_coordinateDictionary
{
    
    NSLog(@"receiveCoordinateFromLocation");
}

- (IBAction)getPlaceMark:(id)sender 
{

    [C4MLocationManager getPlaceMarkFromCurrentLocationWithIdentifier:@"placeMarkIdentifier"];
}

- (IBAction)startLocation:(id)sender 
{

    
}

- (IBAction)getUserLocation:(id)sender 
{
    [C4MLocationManager getUserLocationWithIdentifier:@"getUserLocation"];
}

- (IBAction)onValidAddr:(id)sender 
{
    [mTextfieldAddress resignFirstResponder];
    [C4MLocationManager getCoordinationFromAddrString:mTextfieldAddress.text withIdentifier:@"getCoordinationFromAddrString"];
}

- (void)dealloc {
   // [mGeolocLabel release];
    [mCurrentLocation release];
    [mButtonStartGeoloc release];
    [mUserLocation release];
    [mTextfieldAddress release];
    [super dealloc];
}
@end
