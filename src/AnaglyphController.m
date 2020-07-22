#import "AnaglyphController.h"

// Returns system version as (for e.g.) 0x1023 for 10.2.3. 

SInt32  GetSystemVersion() 
{ 
     static SInt32  gSystemVersion; 
    
     if (gSystemVersion == 0) 
	 { 
	       if (noErr != Gestalt(gestaltSystemVersion, &gSystemVersion)) 
		     gSystemVersion = 0; 
	     } 
    
     return gSystemVersion; 
} 

@implementation AnaglyphController

// --------------------------------------------------------------------------------------------------------
- (void)_issueSizeWarning
// --------------------------------------------------------------------------------------------------------
{
   
    if (GetSystemVersion() <  0x1030)
	NSRunAlertPanel(@"Warning!" ,@"The two images are different sizes!", @"OK", nil, nil);
    else
    {
	NSAlert *alert = [[[NSAlert alloc] init] autorelease];
	[alert addButtonWithTitle:@"OK"];
	[alert setMessageText:@"The two images are different sizes!"];
	[alert setInformativeText:@"To create an anaglyph, the two images must be the same size. Please reload one or both images."];
	[alert setAlertStyle:NSWarningAlertStyle];
	[alert beginSheetModalForWindow:window 
			  modalDelegate:self 
			 didEndSelector:nil
			    contextInfo:nil];   
    }

}
// --------------------------------------------------------------------------------------------------------
- (void)awakeFromNib
// --------------------------------------------------------------------------------------------------------
{
    [leftImage setDelegate:self];
    [rightImage setDelegate:self];
}
// --------------------------------------------------------------------------------------------------------
- (IBAction)updateFinalImage:(id)sender
// --------------------------------------------------------------------------------------------------------
{

    BOOL canDoColor = YES;
    int rowbytes, bytesPerPixel;
    
    [window setDocumentEdited:YES];
    // If either image is blank, set final image to null and exit
    if ( (leftImageRaw == nil) || (rightImageRaw == nil))
    {
	[finalImage setImage:nil];
	return;
    }
    
    if ( ([leftImageRaw size].width != [rightImageRaw size].width) ||
	 ([leftImageRaw size].height != [rightImageRaw size].height) )
    {
	[self performSelector: @selector(_issueSizeWarning) withObject: nil afterDelay: .1];
	[finalImage setImage:nil];
	return;
    }
    
    NSData *data = [[NSData alloc] initWithData:[leftImageRaw TIFFRepresentation]];
    NSBitmapImageRep *rep = [[NSBitmapImageRep alloc] initWithData:data];
    rowbytes=[rep bytesPerRow];
    bytesPerPixel = rowbytes / [leftImageRaw size].width;
    canDoColor = bytesPerPixel >= 3;
    [rep release];
    [data release];
    
    if (([[colorModeRadioButtons selectedCell] tag] == 0) || (!canDoColor)) // Grayscale
	[NSThread detachNewThreadSelector:@selector(generateGrayscaleAnaglyph) toTarget:self withObject:nil];	
    else	// Color
    	[NSThread detachNewThreadSelector:@selector(generateColorAnaglyph) toTarget:self withObject:nil];
}
// --------------------------------------------------------------------------------------------------------
- (void)_toggleEditable:(NSNumber *)isEditable
// --------------------------------------------------------------------------------------------------------
{
    BOOL e = [isEditable boolValue];
    [colorModeRadioButtons setEnabled:e];
    [loadLeftImageButton setEnabled:e];
    [clearLeftImageButton setEnabled:e];
    [loadRightImageButton setEnabled:e];
    [clearRightImageButton setEnabled:e];
    
    
    // setHidden was added with 10.3
    if (GetSystemVersion() >=  0x1030)
    {
	[exportButton setEnabled:e];
	[processingSpinner setHidden:e];
    }
    
    if (!e)
	[processingSpinner startAnimation:self];
    else
	[processingSpinner stopAnimation:self];
}
// --------------------------------------------------------------------------------------------------------
- (void)generateGrayscaleAnaglyph
// --------------------------------------------------------------------------------------------------------
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    [self performSelectorOnMainThread:@selector(_toggleEditable:) withObject:[NSNumber numberWithBool:NO] waitUntilDone:YES];
    
    NSImage *newImage = [rightImageRaw createGrayscaleAnaglyphWithMatchingLeftImage:leftImageRaw];
    [finalImage performSelectorOnMainThread:@selector(setImage:) withObject:newImage waitUntilDone:YES];
    [self setFinalImageRaw:newImage];
    [self performSelectorOnMainThread:@selector(_toggleEditable:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
    [pool release];
}
// --------------------------------------------------------------------------------------------------------
- (void)generateColorAnaglyph
// ------------------------------------------------------------------- -------------------------------------
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [self performSelectorOnMainThread:@selector(_toggleEditable:) withObject:[NSNumber numberWithBool:NO] waitUntilDone:YES];
    NSImage *newImage = [rightImageRaw createColorAnaglyphWithMatchingLeftImage:leftImageRaw];
    [self setFinalImageRaw:newImage];
    [finalImage performSelectorOnMainThread:@selector(setImage:) withObject:newImage waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(_toggleEditable:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
    [pool release];
}
// --------------------------------------------------------------------------------------------------------
- (IBAction)clearImage:(id)sender
// --------------------------------------------------------------------------------------------------------
{
    NSImageView *imageView = (sender == clearLeftImageButton) ? leftImage : rightImage;
    [imageView setImage:nil];
    [finalImage setImage:nil];
}
// --------------------------------------------------------------------------------------------------------
- (void)_exportPanelDidEnd:(NSSavePanel *)sheet returnCode:(int)returnCode contextInfo:(void *)contextInfo
// --------------------------------------------------------------------------------------------------------
{
    if (returnCode == NSOKButton)
    {
	NSBitmapImageRep *finalRep = [NSBitmapImageRep imageRepWithData: [finalImageRaw TIFFRepresentation]];
	
	
	// Hack to workaround problem with TIFF data going to screen resolution
	[finalRep TIFFRepresentation];
	[finalRep setSize:[leftImageRaw size]];
	[[finalRep representationUsingType:NSTIFFFileType properties:nil] writeToFile:[sheet filename] atomically: YES];

    }
}
// --------------------------------------------------------------------------------------------------------
- (IBAction)exportFinalImage:(id)sender
// --------------------------------------------------------------------------------------------------------
{
    
    if ([finalImage image] != nil)
    {
	NSSavePanel *sp = [NSSavePanel savePanel];
	//[sp setAllowedFileTypes:[NSArray arrayWithObjects:@"tiff", nil]];
	[sp setRequiredFileType:@"tiff"];
	[sp beginSheetForDirectory:nil
			      file:nil
		    modalForWindow:window
		     modalDelegate:self
		    didEndSelector:@selector(_exportPanelDidEnd:returnCode:contextInfo:)
		       contextInfo:nil];
    }
}
// --------------------------------------------------------------------------------------------------------
- (void)_loadImagePanelDidEnd:(NSOpenPanel *)sheet 
		   returnCode:(int)returnCode 
		  contextInfo:(void *)contextInfo
// --------------------------------------------------------------------------------------------------------
{
    if (returnCode == NSOKButton)
    {
	NSImageView *imageView = (contextInfo == loadLeftImageButton) ? leftImage : rightImage;
	NSImage *image = [[NSImage alloc] initWithContentsOfFile:[sheet filename]];
	
	if (contextInfo == loadLeftImageButton)
	    [self setLeftImageRaw:image];
	else
	    [self setRightImageRaw:image];
	
	[imageView setImage:image];
	[image release];
	[self updateFinalImage:self];
    }
}
// --------------------------------------------------------------------------------------------------------
- (IBAction)loadImage:(id)sender
// --------------------------------------------------------------------------------------------------------
{
    NSOpenPanel *op = [NSOpenPanel openPanel];
    [op setCanChooseDirectories:NO];
    [op beginSheetForDirectory:nil
			  file:nil 
			 types:[NSImage imageFileTypes] 
		modalForWindow:window
		 modalDelegate:self
		didEndSelector:@selector(_loadImagePanelDidEnd:returnCode:contextInfo:)
		   contextInfo:sender];
    
}
// --------------------------------------------------------------------------------------------------------
- (void)updateModel
// --------------------------------------------------------------------------------------------------------
{
    [document setLeftImage:leftImageRaw];
    [document setRightImage:rightImageRaw];
    [document setFinalImage:finalImageRaw];
    [document setConversionMode:[[colorModeRadioButtons selectedCell] tag]];
}
// --------------------------------------------------------------------------------------------------------
- (void)takeValuesFromModel
// --------------------------------------------------------------------------------------------------------
{
    [leftImage setImage:[document leftImage]];
    [rightImage setImage:[document rightImage]];
    [finalImage setImage:[document finalImage]];
    finalImageRaw = [document finalImage];
    [colorModeRadioButtons selectCellWithTag:[document conversionMode]];
}
// --------------------------------------------------------------------------------------------------------
- (NSImage *)finalImageRaw
// --------------------------------------------------------------------------------------------------------
{
    return finalImageRaw;
}
// --------------------------------------------------------------------------------------------------------
- (void)setFinalImageRaw:(NSImage *)newFinalImageRaw
// --------------------------------------------------------------------------------------------------------
{
    [newFinalImageRaw retain];
    [finalImageRaw release];
    finalImageRaw = newFinalImageRaw;
}
// --------------------------------------------------------------------------------------------------------
- (NSWindow *) window
// --------------------------------------------------------------------------------------------------------
{
    return window;
}
// --------------------------------------------------------------------------------------------------------
- (NSImage *)rightImageRaw
// --------------------------------------------------------------------------------------------------------
{
    return rightImageRaw;
}
// --------------------------------------------------------------------------------------------------------
- (void)setRightImageRaw:(NSImage *)newRightImageRaw
// --------------------------------------------------------------------------------------------------------
{
    [newRightImageRaw retain];
    [rightImageRaw release];
    rightImageRaw = newRightImageRaw;
}
// --------------------------------------------------------------------------------------------------------
- (NSImage *)leftImageRaw
// --------------------------------------------------------------------------------------------------------
{
    return leftImageRaw;
}
// --------------------------------------------------------------------------------------------------------
- (void)setLeftImageRaw:(NSImage *)newLeftImageRaw
// --------------------------------------------------------------------------------------------------------
{
    [newLeftImageRaw retain];
    [leftImageRaw release];
    leftImageRaw = newLeftImageRaw;
}
// --------------------------------------------------------------------------------------------------------
- (void)imageView:(NKDNotifyingImageView *)theView didReceiveDrop:(id <NSDraggingInfo>)dragSender;
// --------------------------------------------------------------------------------------------------------
{
    
    NSPasteboard *paste = [dragSender draggingPasteboard];
    NSArray *types = [NSArray arrayWithObjects: NSPostScriptPboardType, NSPICTPboardType,
	NSPDFPboardType, NSFileContentsPboardType,
	NSTIFFPboardType, NSFilenamesPboardType, nil];
    NSString *desiredType = [paste availableTypeFromArray:types];
    NSImage *newImage = nil;
    
    if ([desiredType isEqualToString:NSFilenamesPboardType])
    {
        NSArray *fileArray = [paste propertyListForType:@"NSFilenamesPboardType"];
        NSString *path = [fileArray objectAtIndex:0];
        newImage = [[NSImage alloc] initWithContentsOfFile:path];
    }
    else
    {
        NSData *carriedData = [paste dataForType:desiredType];
	
        if (nil != carriedData)
	    newImage = [[NSImage alloc] initWithData:carriedData];
    }
    
    if (theView == leftImage)
	[self setLeftImageRaw:newImage];
    else
	[self setRightImageRaw:newImage];
    [newImage release];
}


@end
