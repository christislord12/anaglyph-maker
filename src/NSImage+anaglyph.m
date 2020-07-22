//
//  NSImage+anaglyph.m
//  AnaglyphMaker
//
//  Created by Jeff LaMarche on Wed Jan 28 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import "NSImage+anaglyph.h"

@implementation NSImage(anaglyph)
// --------------------------------------------------------------------------------------------------------
- (NSImage *)createColorAnaglyphWithMatchingLeftImage:(NSImage *)left
// --------------------------------------------------------------------------------------------------------
{
    // There are two techniques for creating color anaglyphs; this one is slightly more complex and
    // demanding of resources, but results in a better picture. To implement the other technique, which
    // is faster and less demanding of resources, but yields a lower-quality final image, look at the comments
    // in createGrayscaleAnaglyphWithmatchingLeftImage: below, as it is essentially the same algorithm used
    // in that method, but with a minor modification.
    NSBitmapImageRep *leftMap, *rightMap;
    NSImage *image;
    NSData *rightData, *leftData;
    unsigned char *leftBuffer;
    unsigned char *rightBuffer;
    
    int rowBytes, bytesPerPixel;
    int currRow, currCol, offset;
    
    rightData = [[NSData alloc] initWithData:[self TIFFRepresentation]];
    leftData = [[NSData alloc] initWithData:[left TIFFRepresentation]];
    
    leftMap = [[NSBitmapImageRep alloc] initWithData:leftData];
    rightMap = [[NSBitmapImageRep alloc] initWithData:rightData];
    
    image = [[NSImage alloc] initWithSize:NSMakeSize([leftMap pixelsWide], [leftMap pixelsHigh])];
    //image = [[NSImage alloc] initWithSize:[self size]];
    leftBuffer = [leftMap bitmapData];
    rightBuffer = [rightMap bitmapData];
    
    rowBytes=[leftMap bytesPerRow];
    bytesPerPixel = rowBytes / [leftMap pixelsWide];
    
    // We only support RGB and RGBA
    if (bytesPerPixel < 3)
    {
	NSLog(@"Attempted to create color anaglyph from image with two few channels.");
	return nil;
    }
    
    // Eliminate the Blue and Green Channels from the left image, and the red from the right
    for (currRow = 0; currRow < [leftMap pixelsHigh]; currRow++)
    {
	for (currCol = 0; currCol < [leftMap pixelsWide]; currCol++)
	{
	    offset = (currRow * rowBytes) + (currCol * bytesPerPixel);
	    leftBuffer[offset+1] = 0;
	    leftBuffer[offset+2] = 0;
	    rightBuffer[offset] = 0;
	}
    }
	
    NSImage *newLeft = [[NSImage alloc] initWithSize:[left size]];
    NSImage *newRight = [[NSImage alloc] initWithSize:[self size]];
    [newLeft addRepresentation:leftMap];
    [newRight addRepresentation:rightMap];
    
    [image lockFocus];
    //[newLeft compositeToPoint:NSMakePoint(0,0) operation:NSCompositeCopy];
    //[newRight compositeToPoint:NSMakePoint(0,0) operation:NSCompositePlusLighter];
    
    [newLeft drawInRect:NSMakeRect(0, 0, [image size].width, [image size].height) 
	       fromRect:NSMakeRect(0, 0, [newLeft size].width, [newLeft size].height)
	      operation:NSCompositeCopy
	       fraction:1.0];
    
    [newRight drawInRect:NSMakeRect(0, 0, [image size].width, [image size].height) 
		fromRect:NSMakeRect(0, 0, [newRight size].width, [newRight size].height)
	       operation:NSCompositePlusLighter
		fraction:1.0];
    
        
    [image unlockFocus];
    
    [newLeft release];
    [newRight release];
    [leftMap release];
    [rightMap release];
    [leftData release];
    [rightData release];
    
    //NSLog(@"My resolution: %d", [self DPI]);
    
    //image = [image setDPI:[self DPI]];
    return [image autorelease];

}
// --------------------------------------------------------------------------------------------------------
- (NSImage *)createColorAnaglyphWithMatchingRightImage:(NSImage *)right
// --------------------------------------------------------------------------------------------------------
{
    return [right createColorAnaglyphWithMatchingLeftImage:self];
}
// --------------------------------------------------------------------------------------------------------
- (NSImage *)createGrayscaleAnaglyphWithMatchingLeftImage:(NSImage *)left
// --------------------------------------------------------------------------------------------------------
{
    NSBitmapImageRep *leftMap, *rightMap, *finalMap;
    NSData *rightData, *leftData;
    unsigned char *leftBuffer;
    unsigned char *rightBuffer;
    unsigned char *finalBuffer;

    
    int rowBytes, bytesPerPixel;
    int frowBytes, fbytesPerPixel;
    int currRow, currCol, offset, foffset;
    
    rightData = [[NSData alloc] initWithData:[self TIFFRepresentation]];
    leftData = [[NSData alloc] initWithData:[left TIFFRepresentation]];
    
    leftMap = [[NSBitmapImageRep alloc] initWithData:leftData];
    rightMap = [[NSBitmapImageRep alloc] initWithData:rightData];
    
    leftBuffer = [leftMap bitmapData];
    rightBuffer = [rightMap bitmapData];
    
    rowBytes=[leftMap bytesPerRow];
    bytesPerPixel = rowBytes / [leftMap pixelsWide];
    
    NSImage *finalImage = [[NSImage alloc] initWithSize:[self size]];
    
    // This is a hack - I'm sure there's a better way to do this. By drawing some color into the new blank
    // image, we force it to create a multi-channel TIFF representation instead of a single-channel one.
    // We need all three (RGB) channels to create the anaglyph, but only have one if our source images are
    // grayscale images.
    [finalImage lockFocus];
    [[NSColor blueColor] set];
    [NSBezierPath fillRect:NSMakeRect(0, 0, [finalImage size].width, [finalImage size].height)];
    [[NSColor blackColor] set];
    [finalImage unlockFocus];
    
    finalMap = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:nil
						       pixelsWide:[leftMap pixelsWide]
						       pixelsHigh:[leftMap pixelsHigh]
						    bitsPerSample:8
						  samplesPerPixel:3
							 hasAlpha:NO
							 isPlanar:NO
						   colorSpaceName:NSCalibratedRGBColorSpace
						      bytesPerRow:[leftMap bytesPerRow]
						     bitsPerPixel:24];
    
    frowBytes = [finalMap bytesPerRow];
    fbytesPerPixel = frowBytes / [finalMap pixelsWide];
    
    finalBuffer = [finalMap bitmapData];

    for (currRow = 0; currRow < [finalMap pixelsHigh]; currRow++)
    {
	for (currCol = 0; currCol < [finalMap pixelsWide]; currCol++)
	{
	    offset = (currRow * rowBytes) + (currCol * bytesPerPixel);
	    foffset = (currRow * frowBytes) + (currCol * fbytesPerPixel);
	    
	    if (bytesPerPixel >= 3)
	    {
		finalBuffer[foffset] = (leftBuffer[offset] + leftBuffer[offset+1] + leftBuffer[offset+2])/3;
		finalBuffer[foffset+1] = (rightBuffer[offset] + rightBuffer[offset+1] + rightBuffer[offset+2])/3;
		finalBuffer[foffset+2] =  (rightBuffer[offset] + rightBuffer[offset+1] + rightBuffer[offset+2])/3;
	    }
	    /*
	     // Substituting the following for the above would create a color anaglyph using the less complex method. The
	     // images created by this technique tend to be flatter and less appealing than the method I chose to use above...
	     if (bytesPerPixel > = 3)
	     {
		 finalBuffer[foffset] = leftBuffer[offset];
		 finalBuffer[foffset+1] = rightBuffer[offset+1];
		 finalBuffer[foffset+2] = rightBuffer[offset+2];
	     }
	     */
	    else
	    {
		finalBuffer[foffset] = leftBuffer[offset];
		finalBuffer[foffset+1] = rightBuffer[offset];
		finalBuffer[foffset+2] = rightBuffer[offset];
	    }
	    
	}
    }
    
    NSImage *image = [[NSImage alloc] initWithSize:[self size]];
    [image addRepresentation:finalMap];
    
    [leftMap release];
    [rightMap release];
    [leftData release];
    [rightData release];
    [finalImage release];
    [finalMap release];
    
    return [image autorelease];
}
// --------------------------------------------------------------------------------------------------------
- (NSImage *)createGrayscaleAnaglyphWithMatchingRightImage:(NSImage *)right
// --------------------------------------------------------------------------------------------------------
{
    return [right createGrayscaleAnaglyphWithMatchingLeftImage:self];
}

@end
