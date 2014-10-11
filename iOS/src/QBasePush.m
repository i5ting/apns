#import "QBasePush.h"

@interface QBasePush ()
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, copy) UploadApnsBlock uploadApnsBlock;
@end

@implementation QBasePush

/**
 *  单例模式 (私有方法)
 *
 *  @return 返回单例
 */
+ (instancetype)shareInstance
{
    static QBasePush *instance = nil;
    static dispatch_once_t onceToken;
 
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[[self class] alloc] init];
            instance.data = [NSMutableData data];
    
            // 默认处理apns基本信息
            instance.pushHandle = [[PushHandle alloc] init];
            
            // 默认处理APNS数据信息
            instance.parseUserInfo = YES;
        }
    });
    return instance;
}

#pragma mark -
#pragma mark - public method

/**
 *  注册UserInfo处理方式
 *
 *  @param pushHandle 处理方式
 */
+ (void)registPushHandle:(PushHandle *)pushHandle
{
    [QBasePush shareInstance].pushHandle = pushHandle;

    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
                    UIRemoteNotificationTypeAlert
                 |  UIRemoteNotificationTypeBadge
                 |  UIRemoteNotificationTypeSound];
}

/**
 *  处理启动APNS用户信息
 *
 *  @param launchingOptions 启动时获取信息
 */
+ (void)handleLaunchingOptions:(NSDictionary *)launchingOptions
{
    NSDictionary *userInfo = [launchingOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (userInfo) {
        [QBasePush handleUserInfo:userInfo];
    }
}

/**
 *  处理服务器返回数据信息
 *
 *  @param userInfo APNS服务器返回数据信息
 */
+ (void)handleUserInfo:(NSDictionary *)userInfo
{
    [[QBasePush shareInstance] startHandleUserInfo:userInfo];
}

/**
 *  是否处理Apns数据
 *
 *  @param parseUserInfo APNS服务器返回数据信息
 */
+ (void)setParseUserInfo:(BOOL)parseUserInfo
{
    [[QBasePush shareInstance] setParseUserInfo:parseUserInfo];
}

/**
 *  上传APNS_Token
 *
 *  @param apnsToken APNS_Token
 */
+ (void)uploadAPNsToken:(NSData *)apnsToken complete:(UploadApnsBlock)uploadBlock
{
    NSString *token = stringFromDeviceTokenData(apnsToken);
    
    // 上传服务器
    [[QBasePush shareInstance] uploadAPNsToken:token complete:uploadBlock];
}

#pragma mark -
#pragma mark - private method 

/**
 *  开始处理UserInfo
 *
 *  @param userInfo APNS服务器返回数据信息
 */
- (void)startHandleUserInfo:(NSDictionary *)userInfo
{
    [self.pushHandle handleUserInfo:userInfo];
}

/**
 *  转化NSData --> NSString
 *
 *  @param deviceToken ApnsToken
 *
 *  @return ApnsToken
 */
NSString* stringFromDeviceTokenData(NSData *deviceToken)
{
    const char *data = [deviceToken bytes];
    NSMutableString* token = [NSMutableString string];
    for (int i = 0; i < [deviceToken length]; i++) {
        [token appendFormat:@"%02.2hhX", data[i]];
    }
    
    return token;
}

/**
 *  上传ApnsToken
 *
 *  @param token ApnsToken
 */
- (void)uploadAPNsToken:(NSString *)apnsToken complete:(UploadApnsBlock)uploadBlock
{
    self.uploadApnsBlock = uploadBlock;
    
    // 设置请求
    NSURL *url = [NSURL URLWithString:APNS_UPLOAD_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];

    // 设置请求体
    NSString *param = [NSString stringWithFormat:@"appVersionId=%@&token=%@", VERSION_ID, apnsToken];
    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];

    // 开始请求服务器
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data.length = 0;
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   [self.data appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(self.uploadApnsBlock) {
        self.uploadApnsBlock(self.data, nil);
    }
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(self.uploadApnsBlock) {
        self.uploadApnsBlock(self.data, nil);
    }
}

@end


