//
//  RequestSampleViewController.h
//  C4MProject
//
//  Created by Damien Praca on 6/25/12.
//  Copyright (c) 2012 C4MProd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C4MRequestGroup.h"
#import "C4MRequestManager.h"

@interface RequestManagerViewController : UIViewController <JSonResponseHandler>
{
    UITextField* mUrl;
    UIButton* mPerfomBtn;
    UITextView* mAnswer;
    UIActivityIndicatorView* mSpinner;
    
}

@property (retain, nonatomic) IBOutlet UITextField* mUrl;
@property (retain, nonatomic) IBOutlet UIButton* mPerfomBtn;
@property (retain, nonatomic) IBOutlet UITextView* mAnswer;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView* mSpinner;

- (IBAction)onBtnAction:(id)sender;

@end
