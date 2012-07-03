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

#import "C4MTabBarCell.h"
#import "UIImage-Alpha.h"

@implementation C4MTabBarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setClipsToBounds:NO];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
		/*if ([self isHighlighted])
		{
			displayedImage = [[self imageView] highlightedImage];
		}
		else
		{
			displayedImage = [[self imageView] image];
		}*/
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

- (void)updateWithBackgroundImage:(UIImage*)backGroundImage image:(UIImage*)newImage highlightedImage:(UIImage*)hlImage
{
	mBackgroundImage.image = backGroundImage;
	mImageView.image = newImage;
	mImageView.highlightedImage = hlImage;
	self.selectedBackgroundView = nil;
}

- (void)dealloc
{
	[mBackgroundImage release];
	[mImageView release];
    [super dealloc];
}

@end
