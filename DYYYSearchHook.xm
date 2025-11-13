#import <UIKit/UIKit.h>
#import "AwemeHeaders.h" // 确保包含所有类定义

// 显式声明目标容器类，方便编译器识别
@interface SearchDynamicContainerView : UIView 
@end

%hook SearchDynamicContainerView

- (void)layoutSubviews {
    %orig; // 先执行 App 原始的布局，确保所有子视图都在位

    // 检查设置开关是否打开
    if (DYYYGetBool(@"DYYYHideSearchSuggestCard")) {
        // 遍历所有子视图
        for (UIView *subview in self.subviews) { 
            // 保持类名判断
            if ([subview isKindOfClass:NSClassFromString(@"UILynxView")]) {
                CGFloat y = CGRectGetMinY(subview.frame);
                CGFloat height = CGRectGetHeight(subview.frame);

                // 保持宽松的坐标判断（如果不想完全移除坐标判断，可以保留此段）
                if (y >= 130.0 && y <= 200.0 && height >= 150.0 && height <= 250.0) {
                    [subview setHidden:YES];
                    // return; // 找到就退出
                }
            }
        }
    }
}

%end