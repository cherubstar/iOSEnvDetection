//
//  FridaDetection.h
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FridaDetection : NSObject

- (BOOL)checkFridaFileIsExistsByNSFileManager:(NSString *)path;
int checkListeningPort();

@end

NS_ASSUME_NONNULL_END
