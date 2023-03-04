//
//  JailbreakDetection.m
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

#import "JailbreakDetection.h"

@implementation JailbreakDetection

- (BOOL)checkFileIsExistsByNSFileManager:(NSString *)path {
    
    // NSFileManager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:path];
    
    return result;
}

@end
