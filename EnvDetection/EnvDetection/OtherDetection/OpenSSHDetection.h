//
//  OpenSSHDetection.h
//  EnvDetection
//
//  Created by 小七 on 2023/5/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenSSHDetection : NSObject

- (BOOL)checkListeningPort22;

@end

NS_ASSUME_NONNULL_END
