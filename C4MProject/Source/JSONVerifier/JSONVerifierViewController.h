//
//  ResultViewController.h
//  C4MJSONVerifier
//
//  Created by Damien Praca on 12/9/10.
//  Copyright 2010 C4MProd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JSONVerifierViewController : UIViewController {
	UILabel *result;
}

@property (nonatomic, retain) IBOutlet UILabel  *result;

@end
