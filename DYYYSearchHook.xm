#import <UIKit/UIKit.h>
#import "AwemeHeaders.h"

// Hook NSObject，这是所有类的基类
%hook NSObject

// 拦截所有类的 initWithDictionary: 方法
- (id)initWithDictionary:(id)arg1 {
    
    id instance = %orig;

    // 检查是否是搜索建议的数据模型（通过关键文本判断）
    if ([NSStringFromClass([instance class]) containsString:@"Model"]) {
        
        // 尝试从字典中提取关键数据
        if ([arg1 objectForKey:@"title"] && [[arg1 objectForKey:@"title"] containsString:@"猜你想搜"]) {
            
            // 找到了嫌疑目标！打印类名和数据
            NSLog(@"[DYYY_DATA_FOUND] 目标数据模型类名: %@", NSStringFromClass([instance class]));
            
            // 返回 nil 或空对象，阻止卡片数据创建
            // return nil; // <-- 这是最终的隐藏操作，但先用来侦察
        }
    }
    return instance;
}

%end