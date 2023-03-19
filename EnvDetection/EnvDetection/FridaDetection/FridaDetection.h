//
//  FridaDetection.h
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FridaDetection : NSObject

- (BOOL)checkFileIsExistsByNSFileManager:(NSString *)path;
- (BOOL)checkFileIsExistsByAccess:(NSString *)path;
// stat 系列
- (BOOL)checkFileIsExistsByStat:(NSString *)path;
- (BOOL)checkFileIsExistsByLstat:(NSString *)path;
- (BOOL)checkFileIsExistsByStatfs:(NSString *)path;
// open 系列
- (BOOL)checkFileIsExistsByOpen:(NSString *)path;
- (BOOL)checkFileIsExistsByFopen:(NSString *)path;
//- (BOOL)checkFileIsExistsByPopen:(NSString *)path;

int checkListeningPort();

@end

NS_ASSUME_NONNULL_END
