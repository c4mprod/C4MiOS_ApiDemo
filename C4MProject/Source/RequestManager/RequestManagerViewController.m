//
//  RequestSampleViewController.m
//  C4MProject
//
//  Created by Damien Praca on 6/25/12.
//  Copyright (c) 2012 C4MProd. All rights reserved.
//

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
