#import <UIKit/UIKit.h>
#import "AwemeHeaders.h"
#import "DYYYSettingsHelper.h"

// 必须声明继承关系，以访问 .view 属性
@interface AWESearchMiddleFeedViewController : UIViewController 
@end

%hook AWESearchMiddleFeedViewController

// 1. 更改 Hook 时机为 viewDidAppear: (视图完全加载并显示后)
- (void)viewDidAppear:(BOOL)animated { 
    %orig;

    // 检查设置开关是否打开
    if (DYYYGetBool(@"DYYYHideSearchSuggestCard")) {
        // 遍历所有子视图
        for (UIView *subview in self.view.subviews) { 
            // 2. 判断是否为目标 UILynxView 类
            if ([subview isKindOfClass:NSClassFromString(@"UILynxView")]) {
                CGFloat y = CGRectGetMinY(subview.frame);
                CGFloat height = CGRectGetHeight(subview.frame);

                // 3. 拓宽坐标判断范围 (Y: 130-200, H: 150-250)
                // 确保能覆盖卡片位置的所有微小变动
                if (y >= 130.0 && y <= 200.0 && height >= 150.0 && height <= 250.0) {
                    [subview setHidden:YES];
                    
                    // 找到了，可以退出循环
                    return; 
                }
            }
        }
    }
}

%end