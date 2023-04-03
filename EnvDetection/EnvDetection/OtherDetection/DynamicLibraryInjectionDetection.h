//
//  DynamicLibraryInjectionDetection.h
//  EnvDetection
//
//  Created by 小七 on 2023/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DynamicLibraryInjectionDetection : NSObject

+ (NSArray *)checkAllDylibIsInject;

@end

NS_ASSUME_NONNULL_END
