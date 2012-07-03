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

#import "TouchTableView.h"


@implementation TouchTableView

#pragma mark - touches

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
	NSSet* touches = [event touchesForView:self];
	
	UITouch* touch = [[touches allObjects] objectAtIndex:0];
	
	CGPoint position = [touch locationInView:self];
	
	NSIndexPath* index = [self indexPathForRowAtPoint:position];
	
	if ([[self indexPathsForVisibleRows] containsObject:index])
	{
		UITableViewCell* cell = [self cellForRowAtIndexPath:index];
		
		return [cell hitTest:position withEvent:event];
	}
	return nil;
}

@end
