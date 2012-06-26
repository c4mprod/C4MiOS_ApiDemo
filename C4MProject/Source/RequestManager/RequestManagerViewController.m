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

#import "RequestManagerViewController.h"

@interface RequestManagerViewController ()

@end

@implementation RequestManagerViewController
@synthesize mUrl;
@synthesize mPerfomBtn;
@synthesize mAnswer;
@synthesize mSpinner;

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)onBtnAction:(id)sender {
    
    //UIButton *btn = (UIButton*) sender;
    
    //1. Create the Request Group
    NSMutableDictionary* params				= [[NSMutableDictionary alloc] init];
	[params setValue:@"arg1"                forKey:@"10"];	
	[params setValue:@"arg2"                forKey:@"test"];
	
	
	NSString* targetUrl						= [NSString stringWithFormat:@"%@", mUrl.text];
	C4MRequest *request						= [[C4MRequest alloc] initWithParams:params isJSon:NO];
    [params release];
	
	C4MRequestGroup *requestGroup           = [[C4MRequestGroup alloc] initWithSingleC4MRequest:request withDelegate:self withTargetURLString:targetUrl withAdditionnalHTTPHeaders:nil httpMethod:HTTP_GET];
	requestGroup.mKeepWrapperArrayForSingleRequest = NO;
	[request release];
    
    //2. Create the request with the group
    
    [[C4MRequestManager sharedRequestManager] performAsynchronousRequestsFromRequestGroup:requestGroup withIdentifierKey:@"AsynchronousRequest"];
    
    mSpinner.hidden = false;
    mAnswer.text = @"";
    
    return [requestGroup release];	
}


#pragma mark -
#pragma mark JSon Delegate Methods

- (void) jsonRequestFailed:(NSError *)_error forRequestKey:(NSString*)_requestId;
{
    mSpinner.hidden = true;
	mAnswer.text = _error.localizedDescription;
}


- (void) parseJSonResponse:(NSString *)jsonResponse forRequestKey:(NSString*)_requestId withStatusCode:(NSInteger)_statusCode{	
    
    mSpinner.hidden = true;
	if([_requestId isEqualToString:@"AsynchronousRequest"])
	{		
		mAnswer.text = [NSString stringWithFormat:@">%@ \n%@", mUrl.text, jsonResponse];
	}
	
}


@end
