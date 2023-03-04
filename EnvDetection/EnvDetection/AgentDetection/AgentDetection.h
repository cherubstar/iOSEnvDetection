//
//  AgentDetection.h
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgentDetection : NSObject

- (BOOL)checkProxyStatusByCFNetworkCopySystemProxySettings;

@end

NS_ASSUME_NONNULL_END
