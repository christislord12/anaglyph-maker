#include "NKDNotifyingImageView.h"

@implementation NKDNotifyingImageView
// --------------------------------------------------------------------------------------------------------
- (id)initWithFrame:(NSRect)frame
// --------------------------------------------------------------------------------------------------------
{
    self = [super initWithFrame:frame];
    if (nil != self)
    {
        [self registerForDraggedTypes:[NSArray arrayWithObjects:NSPostScriptPboardType,
	    NSPICTPboardType, NSPDFPboardType,
	    NSFileContentsPboardType, NSTIFFPboardType,
	    NSFilenamesPboardType, nil]];
    }
    return self;
}
// --------------------------------------------------------------------------------------------------------
- (id)delegate
// --------------------------------------------------------------------------------------------------------
{
    return _delegate;
}
// --------------------------------------------------------------------------------------------------------
- (void)setDelegate:(id)new_delegate
// --------------------------------------------------------------------------------------------------------
{    
    _delegate = new_delegate;
}
// --------------------------------------------------------------------------------------------------------
- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
// --------------------------------------------------------------------------------------------------------
{
    [super performDragOperation:sender]; 
    if ([_delegate respondsToSelector:@selector(imageView:didReceiveDrop:)])
        [_delegate imageView:self didReceiveDrop:sender];
    else
        [NSException raise:NSInternalInconsistencyException format:@"Delegate doesn't respond to imageViewDidReceiveDrop:"];
    
    return YES;
}
// --------------------------------------------------------------------------------------------------------
- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender 
// --------------------------------------------------------------------------------------------------------
{
    return YES;
}
@end
