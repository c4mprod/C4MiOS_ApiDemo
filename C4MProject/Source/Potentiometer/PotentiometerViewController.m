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

#import "PotentiometerViewController.h"
#import "C4MPotentiometer.h"

@implementation PotentiometerViewController

- (void)dealloc
{
	[mStepByStepPotentiometer	release];
	[mFreePotentiometer			release];
    [super						dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	
	// Step by Step Potentiometer configuration.
	[mStepByStepPotentiometer setReferencePositionTo:CGPointMake(mStepByStepPotentiometer.frame.size.width / 2, mStepByStepPotentiometer.frame.size.height / 2)];
	[mStepByStepPotentiometer setDelegate:self];
	//[mPotentiometer setMaxDistanceFromCenter:mPotentiometer.frame.size.width / 2];
	[mStepByStepPotentiometer setMinAngle:180.0];
	[mStepByStepPotentiometer setMaxAngle:360.0];
	[mStepByStepPotentiometer setSwipeStepArayTo:[NSArray arrayWithObjects:@"225", @"270", @"320", nil] currentSelectedStepIndex:1];
	[mStepByStepPotentiometer setCursorBackgroundImage:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn02_base.png"]]];
	
	
	// Free move Potentiometer
	[mFreePotentiometer setReferencePositionTo:CGPointMake(mFreePotentiometer.frame.size.width / 2, mFreePotentiometer.frame.size.height / 2)];
	[mFreePotentiometer setDelegate:self];
	//[mPotentiometer setMaxDistanceFromCenter:mPotentiometer.frame.size.width / 2];
	[mFreePotentiometer setCursorBackgroundImage:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn02_base.png"]]];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - 
#pragma C4M Potentiometer Delegate Method


- (void)potentiometerView:(C4MPotentiometer*)_PotentiometerView touchBeginToAngle:(NSNumber*)_DegreAngle
{
	NSLog(@"touchBeginToAngle");
}


- (void)potentiometerView:(C4MPotentiometer*)_PotentiometerView touchMoveToAngle:(NSNumber*)_DegreAngle
{
	NSLog(@"touchMoveToAngle");
}


- (void)potentiometerView:(C4MPotentiometer*)_PotentiometerView touchEndedToAngle:(NSNumber*)_DegreAngle
{
	NSLog(@"touchEndedToAngle");
}


- (void)potentiometerView:(C4MPotentiometer*)_PotentiometerView selectedStepIndex:(int)_StepIndex andStepValue:(float)_StepAngleValue
{
	NSLog(@"select step : %i for angle %f", _StepIndex, _StepAngleValue);
}



@end
