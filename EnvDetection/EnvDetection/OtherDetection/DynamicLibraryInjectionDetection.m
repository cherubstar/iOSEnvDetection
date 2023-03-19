//
//  DynamicLibraryInjectionDetection.m
//  EnvDetection
//
//  Created by 小七 on 2023/3/15.
//

#import "DynamicLibraryInjectionDetection.h"
#include <mach-o/dyld.h>

@implementation DynamicLibraryInjectionDetection

// 检测所有非法注入的动态库
+ (NSMutableArray *)checkAllDylibIsInject {
    
    if(TARGET_IPHONE_SIMULATOR)
        return nil;
    
    // 初始化可变数组对象的长度，如果后面代码继续添加数组超过长度 10 以后，NSMutableArray的长度会自动扩充，10 是自己可以设置的颗粒度。
    NSMutableArray *dyld_array = [NSMutableArray arrayWithCapacity:10];
    
    // 通过遍历 dyld_image 检测非法注入的动态库
    uint32_t dyld_count = _dyld_image_count();
    
    for (int i = 0; i < dyld_count; i++) {
        // 获取加载的 image 名称
        const char *image_name = _dyld_get_image_name(i);
        NSString *result = [NSString stringWithUTF8String:image_name];
                
        // 过滤非 dylib 后缀的路径
        if(![result hasSuffix:@".dylib"]){
            continue;
        }
        
        // 越狱设备动态库
        if ([result containsString:@"/Library/MobileSubstrate/DynamicLibraries"]) {
            // 从路径中获得完整的文件名
            NSString *file_name = [result lastPathComponent];
            [dyld_array addObject:file_name];
        }
    }
    
    return dyld_array;
}

@end
