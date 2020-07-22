#import "AnaglyphApplicationDelegate.h"

@implementation AnaglyphApplicationDelegate
// -----------------------------------------------------------------------------------
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)app
// -----------------------------------------------------------------------------------
{
    NSArray *windows = [NSApp windows];
    int count = [windows count];
    int needsSaving = 0;
    
    // Determine if there are any unsaved documents...
    
    while (count--)
    {
        NSWindow *window = [windows objectAtIndex:count];
        id document = [AnaglyphDocument documentForWindow:window];
	
        if ([[document class] isEqual:[AnaglyphDocument class]] && [window isDocumentEdited])
	    needsSaving++;
    }
    
    if (needsSaving > 0)
    {
        int choice = NSAlertDefaultReturn;	// Meaning, review changes
	if (needsSaving > 1)
	{	// If we only have 1 unsaved document, we skip the "review changes?" panel
            NSString *title = [NSString stringWithFormat:@"You have %d documents with unsaved changes. Do you want to review these changes before quitting?", needsSaving];
	    choice = NSRunAlertPanel(title,
				     @"If you don't review your documents, all your changes will be lost.",
				     @"Review Changes...",
				     @"Discard Changes",
				     @"Cancel");
	    if (choice == NSAlertOtherReturn)
		return NSTerminateCancel;
	}
	if (choice == NSAlertDefaultReturn)
	{	
            [AnaglyphDocument reviewChangesAndQuitEnumeration:YES];
            return NSTerminateLater;
        }
    }
    
    return NSTerminateNow;
}
@end
