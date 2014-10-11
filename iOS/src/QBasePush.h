/**
 *  推送SDK
 *
 *  Created by andy on 14-7-18.
 *  Copyright (c) 2014年 andy. All rights reserved.
 */
#import <Foundation/Foundation.h>
#import "PushHandle.h"

#define APNS_UPLOAD_URL @"http://20.1.25.215:8888/emm_backend/v1/deviceToken.json"
#define VERSION_ID @"1"

typedef void (^UploadApnsBlock)(id result ,NSError *err);
@interface QBasePush : NSObject<NSURLConnectionDataDelegate>
/**
 *  装饰模式_成分
 */
@property (nonatomic, strong) PushHandle *pushHandle;

/**
 *  是否解析处理UserInfo
 */
@property (nonatomic, assign) BOOL parseUserInfo;

#pragma mark -
#pragma mark - public method

/**
 *  上传APNS_Token
 *
 *  @param apnsToken Apns_Token
 */
+ (void)uploadAPNsToken:(NSData *)apnsToken complete:(UploadApnsBlock)uploadBlock;

/**
 *  注册UserInfo处理方式
 *
 *  @param pushHandle 处理方式
 */
+ (void)registPushHandle:(PushHandle *)pushHandle;

/**
 *  处理启动APNS用户信息
 *
 *  @param launchingOptions 启动时获取信息
 */
+ (void)handleLaunchingOptions:(NSDictionary *)launchingOptions;

/**
 *  处理服务器返回数据信息
 *
 *  @param userInfo Apns服务器返回数据信息
 */
+ (void)handleUserInfo:(NSDictionary *)userInfo;

/**
 *  是否处理Apns数据
 *
 *  @param parseUserInfo Apns服务器返回数据信息
 */
+ (void)setParseUserInfo:(BOOL)parseUserInfo;


@end


