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

#import <UIKit/UIKit.h>
#import "C4MRequestGroup.h"
#import "C4MRequestManager.h"

@interface RequestManagerViewController : UIViewController <JSonResponseHandler, UITextFieldDelegate>
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
- (IBAction)onBgTap:(id)sender;

@end
