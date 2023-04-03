//
//  AgentDetection.m
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

#import "AgentDetection.h"
#import "AppInfo.h"

@implementation AgentDetection

/**
    判断该代理 APP 是否存在
 */
- (BOOL)checkAgentAppIsInstalled:(NSString *)agent_app {
    
    // 常用代理 APP 名单
    /**
         "Shadowrocket.app",
         "Quantumult.app",
         "Quantumult X.app",
         "Kitsunebi.app",
         "Surge-iOS.app",
         "Potatso.app"
     */
    
    // 列出当前手机上所有非 iOS 系统的 APP，并且在 /private/var/containers/Bundle/Application 这个目录下的
    AppInfo *appInfo = [[AppInfo alloc] init];
    NSArray *apps = [appInfo listInstalledApps];
    
    // 遍历判断
    for (NSString *app in apps) {
        if ([app isEqual:agent_app]) {
            return YES;
        }
    }
    
    return NO;
}

/**
     CFNetworkCopySystemProxySettings
     检测当前代理状态
 */
- (BOOL)checkProxyStatusByCFNetworkCopySystemProxySettings {
    
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"https://www.baidu.com/"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    
    NSDictionary *settings = proxies[0];
    
    if (![[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
        // 检测到连接代理
        
        return YES;
    }
    
    return NO;
}

@end
