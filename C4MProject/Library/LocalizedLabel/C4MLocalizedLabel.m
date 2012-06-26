//
//  C4MLocalizedLabel.m
//  Bhost
//
//  Created by Raphaël Pinto on 18/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "C4MLocalizedLabel.h"

@implementation C4MLocalizedLabel


- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self)
	{
		self.text	= NSLocalizedString(self.text, self.text);
	}
	return self;
}

@end
