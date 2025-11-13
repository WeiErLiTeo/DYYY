#import <UIKit/UIKit.h>
#import "AwemeHeaders.h"
#import "DYYYSettingsHelper.h"

// 声明新的目标控制器
@interface FHSViewController : UIViewController 
@end

%hook FHSViewController

// Hook viewDidLayoutSubviews 或 viewDidAppear
- (void)viewDidLayoutSubviews { 
    %orig;

    if (DYYYGetBool(@"DYYYHideSearchSuggestCard")) {
        // 遍历 FHSViewController 的视图
        for (UIView *subview in self.view.subviews) { 
            
            // 检查类名是否是目标容器 UILynxView
            if ([subview isKindOfClass:NSClassFromString(@"UILynxView")]) {
                
                CGFloat y = CGRectGetMinY(subview.frame);
                CGFloat height = CGRectGetHeight(subview.frame);

                // 保持宽泛的坐标判断（防止误伤）
                if (y < 250.0 && height > 150.0) {
                    
                    // 找到了！强制将其从父视图中移除（最彻底的操作）
                    [subview removeFromSuperview];
                    
                    // 立即返回
                    return; 
                }
            }
        }
    }
}

%end