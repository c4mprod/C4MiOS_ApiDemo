//
//  LocationManagerViewController.h
//  C4MiOS_ApiDemo
//
//  Created by Emeric Janowski on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C4MLocationManager.h"

@interface LocationManagerViewController : UIViewController <C4MLocationManagerDelegate>

@property (retain, nonatomic) IBOutlet UIButton *mButtonStartGeoloc;
//@property (retain, nonatomic) IBOutlet UILabel *mGeolocLabel;
@property (retain, nonatomic) IBOutlet UITextField *mTextfieldAddress;
@property (retain, nonatomic) IBOutlet UILabel *mCurrentLocation;
@property (retain, nonatomic) IBOutlet UILabel *mUserLocation;
- (IBAction)getPlaceMark:(id)sender;
- (IBAction)startLocation:(id)sender;
- (IBAction)getUserLocation:(id)sender;
- (IBAction)onValidAddr:(id)sender;

@end
