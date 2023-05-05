//
//  FileAndFolderPathDetection.h
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileAndFolderPathDetection : NSObject

- (BOOL)checkPathByNSFileManager:(NSString *)path;
- (BOOL)checkPathByAccess:(NSString *)path;
// stat 系列
- (BOOL)checkPathByStat:(NSString *)path;
- (BOOL)checkPathByLstat:(NSString *)path;
- (BOOL)checkPathByStatfs:(NSString *)path;
// open 系列
- (BOOL)checkPathByOpen:(NSString *)path;
- (BOOL)checkPathByFopen:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
