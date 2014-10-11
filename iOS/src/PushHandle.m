#import "PushHandle.h"

@implementation PushHandle

/**
 *  类方法创建对象
 *
 *  @return 返回对象
 */
+ (id)pushHandle
{
    return [[[self class] alloc] init];
}

/**
 *  修饰自身对象
 *
 *  @param decorations 修饰类数组
 *
 *  @return 返回完成修饰后的对象
 */
- (PushHandle *)decorateBy:(NSArray *)decorations
{
    PushHandle *pushHandle = [PushHandle pushHandle];
    
    for (NSString *className in decorations) {
        Class handleClass = NSClassFromString(className);
        PushHandle *handle = [[handleClass alloc] init];
        handle.pushHandle = pushHandle;
        pushHandle = handle;
    }
   
    return pushHandle;
}

/**
 *  处理服务器返回数据信息
 *
 *  @param userInfo APNS服务器返回数据信息
 */
- (void)handleUserInfo:(NSDictionary *)userInfo
{
    // 修饰模式
    if (self.pushHandle && [self.pushHandle respondsToSelector:@selector(handleUserInfo:)]) {
        [self.pushHandle handleUserInfo:userInfo];
    }
}

@end
