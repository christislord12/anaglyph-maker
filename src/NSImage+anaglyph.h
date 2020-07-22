//
//  NSImage+anaglyph.h
//  AnaglyphMaker
//
//  Created by Jeff LaMarche on Wed Jan 28 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSImage-Normalize.h"

@interface NSImage(anaglyph)
- (NSImage *)createColorAnaglyphWithMatchingLeftImage:(NSImage *)left;
- (NSImage *)createColorAnaglyphWithMatchingRightImage:(NSImage *)right;
- (NSImage *)createGrayscaleAnaglyphWithMatchingLeftImage:(NSImage *)left;
- (NSImage *)createGrayscaleAnaglyphWithMatchingRightImage:(NSImage *)right;
@end
