//
//  MyDocument.h
//  AnaglyphMaker
//
//  Created by Jeff LaMarche on Wed Jan 28 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//


#import <Cocoa/Cocoa.h>
@class AnaglyphController;

@interface AnaglyphDocument : NSDocument
{
    IBOutlet AnaglyphController *controller;
    
    NSImage *leftImage;
    NSImage *rightImage;
    NSImage *finalImage;
    
    int conversionMode;
} 
- (NSImage *)leftImage;
- (void)setLeftImage:(NSImage *)newLeftImage;
- (NSImage *)rightImage;
- (void)setRightImage:(NSImage *)newRightImage;
- (NSImage *)finalImage;
- (void)setFinalImage:(NSImage *)newFinalImage;
- (int)conversionMode;
- (void)setConversionMode:(int)newConversionMode;
- (void)updateController;
- (NSWindow *)window;
- (void)askToSave;
- (void)willEndCloseSheet:(NSWindow *)sheet
	       returnCode:(int)returnCode
	      contextInfo:(void *)contextInfo;
+ (void)reviewChangesAndQuitEnumeration:(BOOL)cont;
+ (AnaglyphDocument *)documentForWindow:(NSWindow *)theWindow;
- (void)didEndCloseSheet:(NSWindow *)sheet
	      returnCode:(int)returnCode
	     contextInfo:(void *)contextInfo;

@end
