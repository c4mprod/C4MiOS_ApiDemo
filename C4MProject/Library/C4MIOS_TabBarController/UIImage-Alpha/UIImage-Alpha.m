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

#import "UIImage-Alpha.h"
#import <CoreGraphics/CoreGraphics.h>

CGContextRef CreateARGBBitmapContext (CGImageRef inImage)
{
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    

    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL)
        return nil;
    
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL) 
    {
        CGColorSpaceRelease( colorSpace );
        return nil;
    }
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    CGColorSpaceRelease( colorSpace );
    
    return context;
}

@implementation UIImage(Alpha)
- (NSData *)ARGBData
{
    CGContextRef cgctx = CreateARGBBitmapContext(self.CGImage);
    if (cgctx == NULL) 
        return nil;

    size_t w = CGImageGetWidth(self.CGImage);
    size_t h = CGImageGetHeight(self.CGImage);
    CGRect rect = {{0,0},{w,h}}; 
    CGContextDrawImage(cgctx, rect, self.CGImage); 
    
    void *data = CGBitmapContextGetData (cgctx);
    CGContextRelease(cgctx); 
    if (!data)
        return nil;
    
    size_t dataSize = 4 * w * h; // ARGB = 4 8-bit components
    NSData* dataObj = [NSData dataWithBytes:data length:dataSize];
	
	free(data);
	
	return dataObj;
}


- (BOOL)isPointTransparent:(CGPoint)point
{
    NSData *rawData = [self ARGBData];  // See about caching this
    if (rawData == nil)
        return NO;
    
    size_t bpp = 4;
    size_t bpr = self.size.width * 4;
    
    NSUInteger index = point.x * bpp + (point.y * bpr);
    char *rawDataBytes = (char *)[rawData bytes];
	
    return ((int)rawDataBytes[index]) == 0;
    
}
@end
