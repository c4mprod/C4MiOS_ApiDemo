//
//  AutoResizeLabelViewController.h
//  C4MiOS_ApiDemo
//
//  Created by Emeric Janowski on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C4MiOS_UIAutoResizeLabel.h"

@interface AutoResizeLabelViewController : UIViewController
{
    IBOutlet C4MiOS_UIAutoResizeLabel   *mAutoResizeLabel;
    IBOutlet UITextField                *mNumberOfLines;
    IBOutlet UITextField                *mMinimumSize;
    IBOutlet UILabel                    *mLabelCurrentFontSIze;
    IBOutlet UITextField                *mTargetedSize;
}
- (IBAction)onUpdate:(id)sender;
@end
