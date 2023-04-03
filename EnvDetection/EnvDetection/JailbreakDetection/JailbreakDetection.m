//
//  JailbreakDetection.m
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

#import "JailbreakDetection.h"
#import "FileAndFolderPathDetection.h"
#import "AppInfo.h"

@implementation JailbreakDetection

- (BOOL)checkPluginAppIsInstalled:(NSString *)plugin_app {
    
    // 常用越狱插件 APP 名单
    /**
         "/private/var/containers/Bundle/Application/8F5EEA8B-F7A5-4D0E-94EA-481BE7154ABA/unc0ver.app",
         "/private/var/binpack/Applications/loader.app",
         "/Applications/Cydia.app",
         "/Applications/Sileo.app",
         "/Applications/SubstituteSettings.app",
         "/Applications/crackerxi.app",
         "/Applications/DumpDecrypter.app",
         "/Applications/Flex.app"
     */
    
    NSString *path = @"/Applications/";
    FileAndFolderPathDetection *detection = [[FileAndFolderPathDetection alloc] init];
    
    // 遍历判断 unc0ver
    if([plugin_app isEqual:@"unc0ver"]){
        
        AppInfo *appInfo = [[AppInfo alloc] init];
        NSArray *apps = [appInfo listInstalledApps];
        
        for (NSString *app in apps) {
            if ([app isEqual:plugin_app]) {
                return YES;
            } else {
                return NO;
            }
        }
    }
    
    if ([plugin_app isEqual:@"checkra1n"]) {
        // checkra1n 的安装路径
        path = @"/private/var/binpack/Applications/loader.app";
    } else if ([plugin_app isEqual:@"Substitute"]) {
        // Substitute 的安装路径
        path = [path stringByAppendingString:@"SubstituteSettings.app"];
    } else if ([plugin_app isEqual:@"CrackerXI+"]) {
        // CrackerXI+ 的安装路径
        path = [path stringByAppendingString:@"crackerxi.app"];
    } else {
        // 补充 .app 后缀
        plugin_app = [plugin_app stringByAppendingString:@".app"];
        // 其他 APP 路径
        path = [path stringByAppendingString:plugin_app];
    }
    
    if ([detection checkPathByNSFileManager:path] ||
        [detection checkPathByAccess:path] ||
        [detection checkPathByStat:path] ||
        [detection checkPathByLstat:path] ||
        [detection checkPathByStatfs:path] ||
        [detection checkPathByOpen:path] ||
        [detection checkPathByFopen:path]
        ) {
        return YES;
    }
    
    return NO;
}

@end
