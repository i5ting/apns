#import "DefaultPushHandle.h"
#import <AVFoundation/AVFoundation.h>

@implementation DefaultPushHandle
{
    AVAudioPlayer *_audioPlayer;;
}

/**
 *  修饰PushHandle, 添加新的功能
 *
 *  @param userInfo APNS服务器返回数据信息
 */
- (void)handleUserInfo:(NSDictionary *)userInfo
{
    NSLog(@"默认_SDK操作 UserInfo: %@", userInfo);
    
    [super handleUserInfo:userInfo];
    
    NSString *param;
    if ( [[userInfo objectForKey:@"aps"] objectForKey:@"alert"] ) {
        param = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        [self handleDefaultAlert:param];
    }
    
    if ( [[userInfo objectForKey:@"aps"] objectForKey:@"sound"] ) {
        param = [[userInfo objectForKey:@"aps"] objectForKey:@"sound"];
        [self handleDefaultSound:param];
    }
    
    if ( [[userInfo objectForKey:@"aps"] objectForKey:@"badge"] ) {
        param = [[userInfo objectForKey:@"aps"] objectForKey:@"badge"];
        [self handleDefaultBadge:param];
    }
}

#pragma mark -
#pragma mark - 默认处理APNS基础参数

/**
 *  默认弹出警告框, alert为Message内容
 */
- (void)handleDefaultAlert:(NSString *)alert
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:alert
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

/**
 *  默认播放铃声, sound文件名称, 例如: sound.caf
 */
- (void)handleDefaultSound:(NSString *)sound
{
    if (_audioPlayer != nil) {
        [_audioPlayer stop];
        _audioPlayer = nil;
    }
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:[sound stringByDeletingPathExtension] ofType:[sound pathExtension]];
    
    // 如果找不到音频文件, 则跳过播放音频
    if (!musicPath) {
        return;
    }
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[sound stringByDeletingPathExtension] ofType:[sound pathExtension]]];
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_audioPlayer prepareToPlay];
    [_audioPlayer play];
}

/**
 *  默认修改小红点数值
 */
- (void)handleDefaultBadge:(NSString *)badge
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge.integerValue;
}

@end
