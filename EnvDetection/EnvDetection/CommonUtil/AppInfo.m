//
//  AppInfo.m
//  EnvDetection
//
//  Created by 小七 on 2023/3/27.
//

#import "AppInfo.h"

@implementation AppInfo

//
+ (instancetype)appWithInfo:(FBApplicationInfo *)info {
    return [[self alloc] initWithInfo:info];
}

// 初始化相关数据
- (instancetype)initWithInfo:(FBApplicationInfo *)info {
    
    if (self = [super init]) {
        // App Proxy
        LSApplicationProxy *appProxy = (LSApplicationProxy *)info;
        
        self.displayName = appProxy.localizedName ? appProxy.localizedName : appProxy.itemName;
        self.bundleIdentifier = info.bundleIdentifier;
        self.bundlePath = info.bundleURL.path;
        self.dataPath = info.dataContainerURL.path;
        self.hidden = [appProxy.appTags containsObject:@"hidden"];
        self.systemApp = [info.applicationType isEqualToString:@"System"];
    }
    return self;
}

/**
    获取当前系统中所有的 APP
 */
- (NSArray *)fetchApps {
    
    NSMutableArray *apps;
    Class LSApplicationWorkspace_class = NSClassFromString(@"LSApplicationWorkspace");
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    self.workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    apps = [self.workspace performSelector:@selector(allApplications)];
    
#pragma clang diagnostic pop
    
    return apps;
}

/**
    列出当前手机上所有非 iOS 系统的 APP，并且在 /private/var/containers/Bundle/Application 这个目录下的
 */
- (NSArray *)listInstalledApps {
    
    // 获取当前系统中所有的 APP
    NSArray *appInfos = [self fetchApps];
    
    // 初始化可变数组对象的长度，如果后面代码继续添加数组超过长度 10 以后，NSMutableArray的长度会自动扩充，10 是自己可以设置的颗粒度。
    NSMutableArray *apps = [NSMutableArray arrayWithCapacity:10];
    // NSMutableArray *bundleIds = [NSMutableArray arrayWithCapacity:10];
    
    // 遍历
    for (FBApplicationInfo *appInfo in appInfos) {

        // 初始化每一个 APP
        AppInfo *app = [AppInfo appWithInfo:appInfo];
        
        // 过滤掉 iOS 系统的 APP
        if ([app.bundleIdentifier containsString:@"com.apple"])
            continue;
        
        // 过滤掉 /Applications/ 目录下的 APP
        if ([app.bundlePath containsString:@"/private/var/containers/Bundle/Application"]) {
            // 从路径中获取完整的文件名
            NSString *app_name = [app.bundlePath lastPathComponent];
            
            // 获取文件名（不带后缀）
            NSString *app_name_no_suffix = [app_name stringByDeletingPathExtension];

            [apps addObject:app_name_no_suffix];
            // [bundleIds addObject:app.bundleIdentifier];
        }
    }
    
    // NSLog(@"apps: %@", apps);
    // NSLog(@"bundleIds: %@", bundleIds);
    
    return apps;
}

@end
