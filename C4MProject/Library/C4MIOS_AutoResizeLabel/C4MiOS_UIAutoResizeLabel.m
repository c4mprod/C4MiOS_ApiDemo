/*******************************************************************************
 * This file is part of the C4MiOS_UIAutoResizeLabel project.
 * 
 * Copyright (c) 2012 C4M PROD.
 * 
 * C4MiOS_UIAutoResizeLabel is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * C4MiOS_UIAutoResizeLabel is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with C4MiOS_UIAutoResizeLabel. If not, see <http://www.gnu.org/licenses/lgpl.html>.
 * 
 * Contributors:
 * C4M PROD - initial API and implementation
 ******************************************************************************/

#import "C4MiOS_UIAutoResizeLabel.h"

@implementation C4MiOS_UIAutoResizeLabel

- (void)drawTextInRect:(CGRect)rect
{
    int fontSize = self.font.pointSize;
    CGRect frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    frame.size.height = HUGE_VAL;
    CGSize result = [self.text sizeWithFont:self.font constrainedToSize:frame.size lineBreakMode:self.lineBreakMode];
    while (fontSize > self.minimumFontSize && result.height > (self.font.lineHeight*self.numberOfLines)) 
    {
        fontSize--;
        self.font = [self.font fontWithSize:fontSize];
        result = [self.text sizeWithFont:self.font constrainedToSize:frame.size lineBreakMode:self.lineBreakMode];
    } 
    
    [super drawTextInRect:rect];
}

@end

