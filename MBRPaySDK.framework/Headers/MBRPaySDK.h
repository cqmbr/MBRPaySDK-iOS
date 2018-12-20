//
//  MBRPaySDK.h
//  MBRPaySDK
//
//  Created by zhanbin on 2018/4/17.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBRPaySDK/MBRPayConfig.h>

typedef NS_ENUM(NSUInteger, ErrorState) {
    ErrorStateCancel = 4, //用户已取消安装
    ErrorStateInstall, //用户正在安装
    ErrorStateNoneChannel //缺少渠道号
};

typedef void(^CompletionBlock)(NSDictionary *resultDic);

typedef void(^ErrorBlock)(NSDictionary *errorDic);

@interface MBRPaySDK : NSObject

/**
 *  创建支付单例服务
 *
 *  @return 返回单例对象
 */
+ (instancetype)defaultService;

/**
 配置
 */
@property (nonatomic, strong) MBRPayConfig* payConfig;

/**
 *  支付接口
 *
 *  @param orderStr       订单信息
 *  @param schemeStr      调用支付的app注册在info.plist中的scheme
 *  @param errorCallBack  错误回调
 */
- (void)payOrder:(NSString *)orderStr
      fromScheme:(NSString *)schemeStr
        callBack:(ErrorBlock)errorCallBack;

/**
 *  处理MBRPay app支付跳回商户app携带的支付结果Url
 *
 *  @param resultUrl        支付结果url
 *  @param completionBlock  支付结果回调
 */
- (void)processOrderWithPaymentResult:(NSURL *)resultUrl
                      standbyCallback:(CompletionBlock)completionBlock;

/**
 获取支付app安装地址

 @param channel 渠道号
 @return 安装地址
 */
- (NSString *)getInstallAppUrl:(NSString *)channel;


@end


