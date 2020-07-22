#import <AppKit/AppKit.h>

@interface NKDNotifyingImageView : NSImageView
{
    id _delegate;
}
- (id)delegate;
- (void)setDelegate:(id)new_delegate;
@end


@interface NSObject (NKDNotifyingImageView)
- (void)imageView:(NKDNotifyingImageView *)theView didReceiveDrop:(id <NSDraggingInfo>)dragSender;
@end
