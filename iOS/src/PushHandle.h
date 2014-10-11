/**
 *  APNS__处理方式
 *
 *  Created by andy on 14-7-18.
 *  Copyright (c) 2014年 andy. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface PushHandle : NSObject

@property (nonatomic, strong) PushHandle *pushHandle;

/**
 *  类方法创建对象
 *
 *  @return 返回对象
 */
+ (id)pushHandle ;

/**
 *  修饰自身对象
 *
 *  @param decorations 修饰类数组
 *
 *  @return 返回完成修饰后的对象
 */
- (PushHandle *)decorateBy:(NSArray *)decorations;
    
/**
 *  处理服务器返回数据信息
 *
 *  @param userInfo APNS服务器返回数据信息
 */
- (void)handleUserInfo:(NSDictionary *)userInfo;


@end
