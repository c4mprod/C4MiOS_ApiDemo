//
//  CustomPopupFrameViewController.h
//  C4MiOS_ApiDemo
//
//  Created by Damien Praca on 6/29/12.
//  Copyright (c) 2012 C4MProd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C4MPopup.h"

@interface CustomPopupFrameViewController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *mMessage;
@property (retain, nonatomic) IBOutlet UILabel *mTitle;
@property (retain, nonatomic) IBOutlet UIButton *mClose;

- (IBAction)onClose:(id)sender;

@end
