//
//  ResultViewController.m
//  C4MJSONVerifier
//
//  Created by Damien Praca on 12/9/10.
//  Copyright 2010 C4MProd. All rights reserved.
//

#import "JSONVerifierViewController.h"
#import "C4MJSONVerifier.h"

@implementation JSONVerifierViewController

@synthesize result;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSError *error = nil;
	
	NSString *modelStream = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"complex-model" ofType:@"json"] encoding:NSUTF8StringEncoding error:&error];
	NSString *testStream = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"complex" ofType:@"json"] encoding:NSUTF8StringEncoding error:&error];
	
	double start = [[NSDate date] timeIntervalSince1970];
	
	if([C4MJSONVerifier checkValidityOf:testStream fromModel:modelStream error:&error])
	{
		NSLog(@"JSON stream is valid!");
		self.result.text = @"JSON stream is valid!";
	}
	else
	{
		NSLog(@"JSON stream is NOT valid! error :%@", error.localizedDescription);
		self.result.text = [NSString stringWithFormat:@"JSON stream is NOT valid! error :%@", error.localizedDescription];
	}
	
	self.result.text = [self.result.text stringByAppendingString:[NSString stringWithFormat:@"Verified in %f sec", ([[NSDate date] timeIntervalSince1970]- start)]];
	
	[modelStream release];
	[testStream release];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
