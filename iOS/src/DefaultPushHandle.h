/**
 *  默认修饰
 *
 *  Created by andy on 14-7-18.
 *  Copyright (c) 2014年 andy. All rights reserved.
 */
#import "PushHandle.h"

@interface DefaultPushHandle : PushHandle

/**
 *  默认基础信息的处理方式
 *
 *  @param alert APNS对应参数处理
 */
- (void)handleDefaultAlert:(NSString *)alert;   // 仅弹出警告框
- (void)handleDefaultSound:(NSString *)sound;   // 仅播放铃音
- (void)handleDefaultBadge:(NSString *)badge;   // 仅改变红点数字

@end
