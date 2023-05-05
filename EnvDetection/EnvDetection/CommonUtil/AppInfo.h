//
//  AppInfo.h
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

#import <Foundation/Foundation.h>
#import "FBApplicationInfo.h"
#import "LSApplicationProxy.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppInfo : NSObject

@property (nonatomic, strong, readwrite) LSApplicationProxy *appProxy;
@property(copy, nonatomic) NSString *bundlePath;
@property(copy, nonatomic) NSString *dataPath;
@property(copy, nonatomic) NSString *bundleIdentifier;
@property(copy, nonatomic) NSString *displayName;
@property(copy, nonatomic) NSString *executableName;
@property(assign, nonatomic, getter=isSystemApp) BOOL systemApp;
@property(assign, nonatomic, getter=isHidden) BOOL hidden;

@property (nonatomic, strong) NSObject *workspace;

+ (instancetype)appWithInfo:(FBApplicationInfo *)info;
- (instancetype)initWithInfo:(FBApplicationInfo *)info;
- (NSArray *)listInstalledApps;

@end

NS_ASSUME_NONNULL_END
