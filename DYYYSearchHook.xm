#import <UIKit/UIKit.h>
#import "AwemeHeaders.h"
#import "DYYYSettingsHelper.h"

@interface AWESearchMiddleFeedViewController : UIViewController
@end

%hook AWESearchMiddleFeedViewController

- (void)viewWillAppear:(BOOL)animated {
    %orig;

    if (DYYYGetBool(@"DYYYHideSearchSuggestCard")) {
        for (UIView *subview in self.view.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UILynxView")]) {
                CGFloat y = CGRectGetMinY(subview.frame);
                CGFloat height = CGRectGetHeight(subview.frame);

                if (y >= 140.0 && y <= 150.0 && height >= 190.0 && height <= 210.0) {
                    [subview setHidden:YES];
                }
            }
        }
    }
}

%end
