/*******************************************************************************
 * This file is part of the C4MiOS_Potentiometer project.
 * 
 * Copyright (c) 2012 C4M PROD.
 * 
 * C4MIOS_TabBarController is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * C4MIOS_TabBarController is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with C4MIOS_TabBarController. If not, see <http://www.gnu.org/licenses/lgpl.html>.
 * 
 * Contributors:
 * C4M PROD - initial API and implementation
 ******************************************************************************/

#import "TabBarCell.h"
#import "UIImage-Alpha.h"

@implementation TabBarCell

@synthesize mBadgeView;
@synthesize mBadgeValue;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
	
	[mLabel setHighlighted:selected];
	[mImageView setHighlighted:selected];
}

- (void)updateWithBackgroundImage:(UIImage*)_bgImage image:(UIImage*)_image highlightedImage:(UIImage*)_hlImage text:(NSString*)_text
{
	[super updateWithBackgroundImage:_bgImage image:_image highlightedImage:_hlImage];

	mLabel.text = _text;

	// Research icon
	if (_image.size.height > mImageView.frame.size.height)
	{
		CGPoint center = mImageView.center;
		
		CGRect frame = mImageView.frame;
		frame.size.width = _image.size.width;
		frame.size.height = _image.size.height;
	/*	mImageView.frame = frame;
		
		mImageView.center = center;
		
		if([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) 
		{
			frame = mImageView.frame;
			frame.origin.x = frame.origin.x - 1;
			mImageView.frame = frame;
		}
		
		frame = mImageView.frame;
		frame.origin.y = -2;
		mImageView.frame = frame;*/
	}    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
	if (!CGRectContainsPoint(mBackgroundImage.frame, point))
	{
		return nil;
	}
	else
	{
		UIImage *displayedImage = mBackgroundImage.image;
		
		if (displayedImage == nil)
		{
			return self;
		}
		BOOL isTransparent = [displayedImage isPointTransparent:point/*[self convertPoint:point toView:[self imageView]]*/];
		if (isTransparent)
		{
			return nil;
		}
	}
	return self;
}

- (void)dealloc
{
	[mLabel         release];
    [mBadgeView     release];
    [mBadgeValue    release];
	
    [super dealloc];
}

@end
