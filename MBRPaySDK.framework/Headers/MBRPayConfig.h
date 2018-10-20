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
typedef NS_ENUM(NSInteger, MBREnvironmentType){
    /**
     *    未知环境
     */
    MBREnvironmentUnknow            =   -1,
    /**
     *    开发环境(test)
     */
    MBREnvironmentDevelop           =   1,
    /**
     *    测试环境(debug)
     */
    MBREnvironmentTest              =   2,
    /**
     *    预生产环境
     */
    MBREnvironmentPreProduction     =   3,
    /**
     *    生产环境
     */
    MBREnvironmentProduction        =   4
};


/**
 支付SDK配置
 */
@interface MBRPayConfig : NSObject

/// 环境,默认MBREnvironmentProduction
@property (nonatomic, assign) MBREnvironmentType environmnent;

/// 引导下载url
@property (nonatomic, copy) NSString* downLoadUrl;


@end
