//
//  MBRPayConfig.h
//  MBRPaySDK
//
//  Created by lfl on 2018/9/20.
//

#import <Foundation/Foundation.h>


/**
 环境枚举
 */
typedef NS_ENUM(NSInteger, MBRPaySDKEnvironmentType){
    /**
     *    未知环境
     */
    MBRPaySDKEnvironmentUnknow            =   -1,
    /**
     *    开发环境(test)
     */
    MBRPaySDKEnvironmentDevelop           =   1,
    /**
     *    测试环境(debug)
     */
    MBRPaySDKEnvironmentTest              =   2,
    /**
     *    预生产环境
     */
    MBRPaySDKEnvironmentPreProduction     =   3,
    /**
     *    生产环境
     */
    MBRPaySDKEnvironmentProduction        =   4
};


/**
 支付SDK配置
 */
@interface MBRPayConfig : NSObject

/// 环境,默认MBRPaySDKEnvironmentProduction
@property (nonatomic, assign) MBRPaySDKEnvironmentType environmnent;

/// 引导下载url
@property (nonatomic, copy) NSString* downLoadUrl;


@end
