// -----------------------------------------------------------------------------------
// NSImage-Resolution.m
// -----------------------------------------------------------------------------------
//  Created by Jeff LaMarche on Sun May 12 2002.
//  ©2002 Naked Software. All rights reserved.
// -----------------------------------------------------------------------------------
// THIS	SOURCE CODE IS PROVIDED AS-IS WITH NO WARRANTY OF ANY KIND
// -----------------------------------------------------------------------------------
// You may use and redistribute this source code without limitation
// -----------------------------------------------------------------------------------
#import "NSImage-Normalize.h"


@implementation NSImage (normalize)
// -----------------------------------------------------------------------------------
- (NSImage *) normalizeSize
// -----------------------------------------------------------------------------------
{
    NSBitmapImageRep *theBitmap = nil;
    NSSize newSize;
    NSArray *reps = [self representations];
    int i;

    for (i = 0 ; i < [reps count] ; i++ )
    {
        NSImageRep *theRep = [reps objectAtIndex:i];
        if ([theRep isKindOfClass:[NSBitmapImageRep class]])
        {
            theBitmap = (NSBitmapImageRep *)theRep;
            break;
        }
    }
    if (theBitmap != nil)
    {
        newSize.width = [theBitmap pixelsWide];
        newSize.height = [theBitmap pixelsHigh];
        [theBitmap setSize:newSize];
        [self setSize:newSize];
    }
    return self;
}
// -----------------------------------------------------------------------------------
- (NSImage *) setDPI:(int)dpi
// -----------------------------------------------------------------------------------
{
    NSBitmapImageRep *theBitmap = nil;
    NSSize newSize;
    NSArray *reps = [self representations];
    int i;

    for (i = 0 ; i < [reps count] ; i++ )
    {
        NSImageRep *theRep = [reps objectAtIndex:i];
        if ([theRep isKindOfClass:[NSBitmapImageRep class]])
        {
            theBitmap = (NSBitmapImageRep *)theRep;
            break;
        }
    }
    if (theBitmap != nil)
    {
        newSize.width = (float)([theBitmap pixelsWide])/(dpi*72);
        newSize.height = (float)([theBitmap pixelsHigh])/(dpi*72);
        [theBitmap setSize:newSize];
        [self setSize:newSize];
    }
    /*
    for (i = 0 ; i < [reps count] ; i++ )
    {
        NSImageRep *theRep = [reps objectAtIndex:i];
	[theRep setSize:newSize];
    }*/
    
    return self;
}
// -----------------------------------------------------------------------------------
- (int) DPI
// -----------------------------------------------------------------------------------
{
    NSBitmapImageRep *theBitmap = nil;
    NSArray *reps = [self representations];
    int i;
    for (i = 0 ; i < [reps count] ; i++ )
    {
        NSImageRep *theRep = [reps objectAtIndex:i];
        if ([theRep isKindOfClass:[NSBitmapImageRep class]])
        {
            theBitmap = (NSBitmapImageRep *)theRep;
            break;
        }
    }
    if (theBitmap != nil)
    {
	// We'll assume that horizontal and vertical resolution are the same 
	// - possibly a bad assumption, but it works for this program...
	return ([theBitmap pixelsWide]/[self size].width) * 72;
    }
    return 0;
}
@end
