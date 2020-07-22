//
//  AnaglyphDocument.m
//  AnaglyphMaker
//
//  Created by Jeff LaMarche on Wed Jan 28 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import "AnaglyphDocument.h"

@implementation AnaglyphDocument
// --------------------------------------------------------------------------------------------------------
- (id)init
// --------------------------------------------------------------------------------------------------------
{
    self = [super init];
    if (self) {
    
        // Add your subclass-specific initialization here.
        // If an error occurs here, send a [self release] message and return nil.
    
    }
    return self;
}
// --------------------------------------------------------------------------------------------------------
- (NSString *)windowNibName
// --------------------------------------------------------------------------------------------------------
{
    return @"AnaglyphDocument";
}

// --------------------------------------------------------------------------------------------------------
- (void)windowControllerDidLoadNib:(NSWindowController *) aController
// --------------------------------------------------------------------------------------------------------
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}
// --------------------------------------------------------------------------------------------------------
- (NSData *)dataRepresentationOfType:(NSString *)aType
// --------------------------------------------------------------------------------------------------------
{
    [controller updateModel];
    NSMutableArray *array = [NSMutableArray array];
    if (leftImage != nil)
	[array addObject:leftImage];
    else
	[array addObject:[NSNull null]];
    
    if (rightImage != nil)
	[array addObject:rightImage];
    else
	[array addObject:[NSNull null]];
    
    if (finalImage != nil)
	[array addObject:finalImage];
    else
	[array addObject:[NSNull null]];
    
    [array addObject:[NSNumber numberWithInt:[self conversionMode]]];
    
    // Insert code here to write your document from the given data.  You can also choose to override -fileWrapperRepresentationOfType: or -writeToFile:ofType: instead.
    return [NSArchiver archivedDataWithRootObject:array];

}
// --------------------------------------------------------------------------------------------------------
- (BOOL)loadDataRepresentation:(NSData *)data ofType:(NSString *)aType
// --------------------------------------------------------------------------------------------------------
{
    // Check for an untitled window with no changes and get rid of it...
    NSWindow *mainWindow = [NSApp mainWindow];
    NSString *title = [mainWindow title];
    
    
    if ([title hasPrefix:@"Untitled"] && ![mainWindow isDocumentEdited])
    {
	[mainWindow close];
    }
    
    NSMutableArray *array = [NSUnarchiver unarchiveObjectWithData:data];
    [self setLeftImage:[array objectAtIndex:0]];
    [self setRightImage:[array objectAtIndex:1]];
    [self setFinalImage:[array objectAtIndex:2]];
    [self setConversionMode:[[array objectAtIndex:3] intValue]];
    [self performSelector: @selector(updateController) withObject: nil afterDelay: .1];
    
    //[doc release];
    
    return YES;
}
// --------------------------------------------------------------------------------------------------------
- (void)updateController
// --------------------------------------------------------------------------------------------------------
{
    [controller takeValuesFromModel];
}
// --------------------------------------------------------------------------------------------------------
- (NSImage *)leftImage
// --------------------------------------------------------------------------------------------------------
{
    return leftImage;
}
// --------------------------------------------------------------------------------------------------------
- (void)setLeftImage:(NSImage *)newLeftImage
// --------------------------------------------------------------------------------------------------------
{
    [newLeftImage retain];
    [leftImage release];
    leftImage = newLeftImage;
}
// --------------------------------------------------------------------------------------------------------
- (NSImage *)rightImage
// --------------------------------------------------------------------------------------------------------
{
    return rightImage;
}
// --------------------------------------------------------------------------------------------------------
- (void)setRightImage:(NSImage *)newRightImage
// --------------------------------------------------------------------------------------------------------
{
    [newRightImage retain];
    [rightImage release];
    rightImage = newRightImage;
}
// --------------------------------------------------------------------------------------------------------
- (NSImage *)finalImage
// --------------------------------------------------------------------------------------------------------
{
    return finalImage;
}
// --------------------------------------------------------------------------------------------------------
- (void)setFinalImage:(NSImage *)newFinalImage
// --------------------------------------------------------------------------------------------------------
{
    [newFinalImage retain];
    [finalImage release];
    finalImage = newFinalImage;
}// --------------------------------------------------------------------------------------------------------
- (int)conversionMode
// --------------------------------------------------------------------------------------------------------
{
    return conversionMode;
}
// --------------------------------------------------------------------------------------------------------
- (void)setConversionMode:(int)newConversionMode
// --------------------------------------------------------------------------------------------------------
{
    conversionMode = newConversionMode;
}
// --------------------------------------------------------------------------------------------------------
- (BOOL)windowShouldClose:(NSNotification *)aNotification
// --------------------------------------------------------------------------------------------------------
{
    if (! ( (leftImage == nil) && (rightImage == nil) && (finalImage == nil)) && ([[self window] isDocumentEdited]))
    {
	[self askToSave];
	return NO;
    }
    
    return YES;
}
// --------------------------------------------------------------------------------------------------------
- (void)askToSave
// --------------------------------------------------------------------------------------------------------
{
    [[self window] makeKeyAndOrderFront:nil];
    NSBeginAlertSheet(@"Do you want to save changes to this document before closing?",
		      @"Save",
		      @"Don't Save",
		      nil, 
		      [self window],
		      self,
		      nil, //@selector(willEndCloseSheet:returnCode:contextInfo:),
		      @selector(didEndCloseSheet:returnCode:contextInfo:),
		      nil,
		      @"If you don't save, your changes will be lost.");
}
// --------------------------------------------------------------------------------------------------------
- (void)willEndCloseSheet:(NSWindow *)sheet
	       returnCode:(int)returnCode
	      contextInfo:(void *)contextInfo
// --------------------------------------------------------------------------------------------------------
{
    if (returnCode == NSAlertAlternateReturn)
        [[self window] close];
    //if ([NKDProjectDocument openProjectWindowsCount] == 0)
    [AnaglyphDocument reviewChangesAndQuitEnumeration:YES];
    
}
// --------------------------------------------------------------------------------------------------------
- (void)didEndCloseSheet:(NSWindow *)sheet
	      returnCode:(int)returnCode
	     contextInfo:(void *)contextInfo
// --------------------------------------------------------------------------------------------------------
{
    if (returnCode == NSAlertDefaultReturn)
    {
        [self saveDocument:self];
	[[self window] close];
    }
    else if (returnCode == NSAlertAlternateReturn)
        [[self window] close];
    //if ([NKDProjectDocument openProjectWindowsCount] == 0)
    [AnaglyphDocument reviewChangesAndQuitEnumeration:YES];
}
// --------------------------------------------------------------------------------------------------------
+ (void)reviewChangesAndQuitEnumeration:(BOOL)cont
// --------------------------------------------------------------------------------------------------------
{
    if (cont)
    {
	NSArray *windows = [NSApp windows];
	unsigned count = [windows count];
	while (count--)
	{
	    NSWindow *theWindow = [windows objectAtIndex:count];
	    AnaglyphDocument *theDoc = [AnaglyphDocument documentForWindow:theWindow];
	    if (theDoc)
	    {
		if ([theWindow isDocumentEdited])
		{
		    [theDoc askToSave];
		    return;
		}
	    }
	}
    }
    [NSApp replyToApplicationShouldTerminate:YES];
}
// --------------------------------------------------------------------------------------------------------
+ (AnaglyphDocument *)documentForWindow:(NSWindow *)theWindow
// --------------------------------------------------------------------------------------------------------
{
    id delegate = [theWindow delegate];
    return (delegate && [delegate isKindOfClass:[AnaglyphDocument class]]) ? delegate : nil;
}
// --------------------------------------------------------------------------------------------------------
- (NSWindow *)window
// --------------------------------------------------------------------------------------------------------
{
    return [controller window];
}
// --------------------------------------------------------------------------------------------------------
- (IBAction)saveDocument:(id)sender
// --------------------------------------------------------------------------------------------------------
{
    [super saveDocument:sender];
    [[self window] setDocumentEdited:NO];
}

@end
