//
//  AgentDetection.m
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

#import "AgentDetection.h"

@implementation AgentDetection

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
