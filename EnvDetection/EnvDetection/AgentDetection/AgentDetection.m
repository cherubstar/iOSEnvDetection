//
//  AgentDetection.m
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

#import "AgentDetection.h"
#import "AppInfo.h"

@implementation AgentDetection

/**
    判断该代理 APP 是否存在
 */
- (NSArray *)checkAgentAppIsInstalled {
    
    // 常用代理 APP 名单
    /**
         "HttpCatcher.app",
         "Kitsunebi.app",
         "Potatso.app",
         "Quantumult.app",
         "Quantumult X.app",
         "Shadowrocket.app",
         "Surge-iOS.app",
         "Thor.app"
     */
    NSArray *agent_apps = [NSArray arrayWithObjects:@"HttpCatcher.app", @"Kitsunebi.app", @"Potatso.app", @"Quantumult.app",
                           @"Quantumult X.app", @"Shadowrocket.app", @"Surge-iOS.app", @"Thor.app", nil];
    // 初始化可变数组对象的长度，如果后面代码继续添加数组超过长度 10 以后，NSMutableArray的长度会自动扩充，10 是自己可以设置的颗粒度。
    NSMutableArray *isInstalled = [NSMutableArray arrayWithCapacity:10];
    // 初始化默认值为 0
    for (int i = 0; i < [agent_apps count]; i++) {
        [isInstalled addObject:@0];
    }
    
    // 列出当前手机上所有非 iOS 系统的 APP，并且在 /private/var/containers/Bundle/Application 这个目录下的
    AppInfo *appInfo = [[AppInfo alloc] init];
    NSArray *apps = [appInfo listInstalledApps];
    
    // 判断返回的 apps 数组是否为空(非越狱状态为空)
    if ([apps count] == 0) {
        return isInstalled;
    }
    
    // 遍历判断
    for (NSString *app in apps) {
        if ([agent_apps containsObject:app]) {
            // 获取元素索引下标
            NSUInteger appIndex = [agent_apps indexOfObject:app];
            [isInstalled replaceObjectAtIndex:appIndex withObject:@1];
        }
    }
    
    return isInstalled;
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

- (NSDictionary *)getCFNetworkCopySystemProxySettingsDetails {
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"https://www.baidu.com/"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    
    return proxies[0];
}

/**
    【注意：仅配置系统代理有效，可以防止 Charles，Burpsuite 抓包】
    connectionProxyDictionary
    设置当前代理变量值
    默认为 null，设置值为空
 */
- (void)setConnectionProxyDictionary {
    
    // 1. 获取 Wi-Fi 配置中的代理信息
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSDictionary *httpProxy = proxySettings[(__bridge NSString *)kCFNetworkProxiesHTTPProxy];
    NSNumber *httpPort = proxySettings[(__bridge NSString *)kCFNetworkProxiesHTTPPort];

    if (httpProxy && httpPort) {
        NSLog(@"[+] 有代理");
        // 2. 输出代理的 IP 和端口信息
        NSDictionary *proxyAddress = httpProxy;
        NSInteger proxyPort = [httpPort integerValue];
        NSLog(@"Wi-Fi设置中的代理信息：%@:%zd", proxyAddress, proxyPort);

        // 3. 发起网络请求（不使用代理）
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSLog(@"connectionProxyDictionary1: %@", sessionConfig.connectionProxyDictionary);
        sessionConfig.connectionProxyDictionary = @{};
        NSLog(@"connectionProxyDictionary2: %@", sessionConfig.connectionProxyDictionary);
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
        NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
        NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // 打印响应包内容
            
        }];
        [task resume];
        
    } else {
        NSLog(@"[+] 没有代理");
        // 没有配置代理，使用默认网络连接发起请求
        NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // 打印响应包内容
            
        }];
        [task resume];
    }
}

@end
