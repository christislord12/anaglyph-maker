/* AnaglyphController */

#import <Cocoa/Cocoa.h>
#import "AnaglyphDocument.h"
#import "NSImage+anaglyph.h"
#import "NKDNotifyingImageView.h"

@interface AnaglyphController : NSObject 
{
    IBOutlet NSMatrix *colorModeRadioButtons;
    IBOutlet NSImageView *finalImage;
    IBOutlet NKDNotifyingImageView *leftImage;
    IBOutlet NSProgressIndicator *processingSpinner;
    IBOutlet NKDNotifyingImageView *rightImage;
    IBOutlet NSWindow *window;
    IBOutlet NSButton *loadLeftImageButton;
    IBOutlet NSButton *loadRightImageButton;
    IBOutlet NSButton *clearLeftImageButton;
    IBOutlet NSButton *clearRightImageButton;
    IBOutlet NSButton *exportButton;
    
    IBOutlet AnaglyphDocument *document;
    
    NSImage *finalImageRaw;
    NSImage *rightImageRaw;
    NSImage *leftImageRaw;

}
- (IBAction)clearImage:(id)sender;
- (IBAction)exportFinalImage:(id)sender;
- (IBAction)loadImage:(id)sender;
- (IBAction)updateFinalImage:(id)sender;
- (void)updateModel;
- (void)takeValuesFromModel;
- (NSWindow *) window;
- (void)generateColorAnaglyph;
- (void)generateGrayscaleAnaglyph;
- (NSImage *)finalImageRaw;
- (void)setFinalImageRaw:(NSImage *)newFinalImageRaw;
- (NSImage *)rightImageRaw;
- (void)setRightImageRaw:(NSImage *)newRightImageRaw;
- (NSImage *)leftImageRaw;
- (void)setLeftImageRaw:(NSImage *)newLeftImageRaw;
- (void)imageView:(NKDNotifyingImageView *)theView didReceiveDrop:(id <NSDraggingInfo>)dragSender;

@end
