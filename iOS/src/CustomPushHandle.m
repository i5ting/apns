#import "CustomPushHandle.h"

@implementation CustomPushHandle

/**
 *  修饰PushHandle, 添加新的功能
 *
 *  @param userInfo APNS服务器返回数据信息
 */
- (void)handleUserInfo:(NSDictionary *)userInfo
{
    [super handleUserInfo:userInfo];

    NSLog(@"其他操作");
}

@end
