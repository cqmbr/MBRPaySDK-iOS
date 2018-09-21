//
//  ViewController.m
//  PaySDKDemo
//
//  Created by zhanbin on 2018/5/7.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "ViewController.h"
#import <MBRPaySDK/MBRPaySDK.h>
#import "DCPAPISigner.h"
#import <YYCategories.h>
#import <MBProgressHUD+BWMExtension/MBProgressHUD+BWMExtension.h>

#ifdef cospay_target
static const NSString *urlPath = @"http://47.100.47.200:9927/payIndex/prepay";
static const NSString *channel = @"73088886094000";
static const NSString *merchantId = @"10000000000003";
//应用注册scheme,在PaySDKDemo-Info.plist定义URL types
static const NSString *appScheme = @"CosPaySDKDemo";
#elif defined dcpay_target
static const NSString *urlPath = @"http://47.100.47.200:9927/payIndex/prepay";
static const NSString *channel = @"38682966843081";
static const NSString *merchantId = @"89898477937650";
//应用注册scheme,在PaySDKDemo-Info.plist定义URL types
static const NSString *appScheme = @"DCPaySDKDemo";
#else
//static const NSString *urlPath = @"http://47.100.47.200:9927/payIndex/prepay";
//static const NSString *channel = @"38682966843081";
//static const NSString *merchantId = @"89898477937650";
////应用注册scheme,在PaySDKDemo-Info.plist定义URL types
//static const NSString *appScheme = @"PaySDKDemo";

// qianlong配置
//static const NSString *urlPath = @"http://47.100.47.200:9927/payIndex/prepay";
static const NSString *urlPath = @"http://192.168.1.28:9927/payIndex/prepay";
static const NSString *channel = @"8266164582560";
static const NSString *merchantId = @"8266163269740";
//应用注册scheme,在PaySDKDemo-Info.plist定义URL types
static const NSString *appScheme = @"PaySDKDemo";

static const NSString *privateKey = @"MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCM0wuMJ5Od7z+nvds/C2vpyS6x7h6lUsrmGH9ANZoyIYwIzN4QWQuL940DPNF9t0SbDtffqbshwEjp3bWynQpC/EPLz4Od0zzvbf58pvfXaIh8nI8r3ldMTAmmtT64oZK2xrMwTJUWF5En1MFpCSr68yU4/X+2Rp1NpE2vimp34H2msxCoYi91FdBh5XcxjQPM4j2gGdY3kn2hcTSx5beKITb2bBW+nMKObT7JyTKFMFVUYQ0Yt/xghCK8Cz3dIAr20rLBFwJ4/suJlUHF6XadVxBFCxvdHlOEP1+02tEGhPb/TjMOSZO8zKXH6PaMyN8yrqafcMkEfPkZKUEWVjLXAgMBAAECggEALu7/gDyIdDCSlIMwGPjjhE0qpN5plEvdl4Y+ktXKiD6p/xzYPbaPpJxigNu6Lh3wXYU66S4WUg9VvavIrLit/Nk6dyi4AteuDVYpZL35B++s3WsIRGSbz6/f35G0T7B5xzS977D2VyCPnijINQt7KZvzoeTKtaMfNgs2YPTOuxi1TtnroDkqjhHplj4P/SHjalBI2ipXWyGQFgDKaexQafbESd+aNBR3d8PgOlouPBdlVJ5PZg9+LuWlLj+l7MqQZfreWN8YpVPYi+OreT+95j/C7QEDv/6kYQEqME03FZfAUCB2WI35aABuzzwcwzGb47+xnBH/+6M17hXULv+DsQKBgQDSTKw3AVwR+QqR3GTcocQGtWmxqKFFWcp+mri0HV8o2yBowhJVLsuVF+nyAyZSR1bZyJI+e/EOaoLFyEHiwtLAAr0DnNT5ZMzmqArUxqBMdRpMUbSdCFyTfD4adlHfFhVTH6OD2YpcUTFgtYEBYJjT8tpdvxM8gvYKzm2VcI0BrQKBgQCrbVnrd0nfy+z2XjgfCWAbWgwMOyGg5/2jeHJQloJzgxuMfdzzdMIcOyTzHHMAnExHw74R6Es0ZZY8iNaxGlfTy8xPS0s64t5+AFD6qhAwfIMTLCLkjbPMXYv7FT0e0cPvcvwc9/vh6Faf9PQKpxu7NKEYzTH4pNa6tNSJz/u/EwKBgQCtPlac1bToZXYMpTg9/dGECUzx+04n2ImVdJZ2Yr/y41m2kzIRFITH5TRnl6qpG3Xz4WSArw/tZVcn4gpM6Vw+q8LUSA23ChA2b/bERIDnm4y3lJOqzameIjrzB8f4dLPKj4Tf6IUv+f8ogT2uScp8yFKV6gPJ1MUmL9pcwqSW3QKBgBUdOt4Nq0OtUlpl8HOiK/wycxlujw3KhSsFQs86OocPtuzu86/oyZ/AiSSIdIG2vo54RYjfG6Qwfvilwgu+OuMTTu7VT0bJeq36S/8Twzq1m09ZOFL+QQ8C1qLuUsDhBUkQ2IyY3qVMgJ7jBMvrGTdNnCn53BXL98a3TxZKT6+RAoGAFrWw5xS6Huo38hV5ryoV+wOrAh11wA9ff5cuvuzAELWafmMoCynUwiZYcTlxeowe8cwByhoLQYv6bDezoa7Jls4yDDh06Ajbo3EhkI114BOVi6qgbZh3bcwRjCJjoUhI9HTycmzDxGS3KKM7/R5ObX6jKLClZaMlUiEsd0TyGoQ=";

#endif



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePayResult:) name:@"MBRPayResult" object:nil];
    [self configPaySdk];
}

- (void)configPaySdk {
    [MBRPaySDK defaultService];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)clickPayETHButton:(id)sender {
    
    [self prePay:@"34190899187000" amount:@"0.01"];
}
- (IBAction)clickPayPHButton:(id)sender {
    [self prePay:@"7739138616000" amount:@"1"];
}

- (IBAction)clickSimulationPayButton:(id)sender {
    [self doSimulationPay];
}

#pragma mark -
#pragma mark   ==============向服务端获取订单数据==============
-(void)prePay:(NSString *)coinId amount:(NSString *)amount{
    
    MBProgressHUD *hud = [MBProgressHUD bwm_showHUDAddedTo:self.view title:@"" animated:YES];
//    NSString *urlString = [NSString stringWithFormat:@"%@?channel=%@&merchantId=%@&coinId=%@&amount=%@",urlPath,channel,merchantId,coinId,amount];
    NSString *pKey = [self urlEncodedString:privateKey];
    NSString *urlString = [NSString stringWithFormat:@"%@?channel=%@&merchantId=%@&private_key=%@&coinId=%@&amount=%@",urlPath,channel,merchantId,pKey,coinId,amount];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
            if(!error){
                NSString *orderInfo = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSError *error;
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:NSJSONReadingMutableContainers
                                                                               error:&error];
                if (error==nil) {
                    NSInteger code = [responseDict[@"code"] integerValue];
                    if (code == 200) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSString *orderInfo = responseDict[@"data"];
                            NSLog(@"\rorderInfo:\r%@",orderInfo);
                            
                            //支付
                            [self pay:orderInfo appScheme:appScheme];
                            
                        });
                    }else {
                        NSLog(@"error:%@",@"server error");
                        [MBProgressHUD bwm_showTitle:@"server error" toView:self.view hideAfter:2];
                    }
                }
            } else {
                NSLog(@"error:%@",[error description]);
                [MBProgressHUD bwm_showTitle:[error description] toView:self.view hideAfter:2];
            }
        });
    }];
    
    //5.执行任务
    [dataTask resume];
}

#pragma mark -
#pragma mark   ==============点击模拟支付行为==============
-(void)doSimulationPay {
    
    //构造测试订单
    NSMutableDictionary *orderDic = [NSMutableDictionary dictionary];
    orderDic[@"amount"] = @"1.0000";
    orderDic[@"attach"] = @"api_prepay";
    orderDic[@"coinId"] = @"34190899187000";
    orderDic[@"channel"] = @"73088886094000";//渠道id
    orderDic[@"merchantId"] = @"10000000000003";//商户id
    orderDic[@"orginAmount"] = @"0";
    orderDic[@"payBillNo"] = @"40476859839485";
    orderDic[@"refBizNo"] = @"2000010008";
    orderDic[@"toAddr"] = @"0x91f8654587917f3a0c7cfc5fa05bd86dc0162ddb";
    
    //生成订单信息及签名
    NSString* orderInfo = [self prepareOrderInfo:orderDic];
    NSLog(@"\rorderInfo:\r%@",orderInfo);
    
    //支付
    [self pay:orderInfo appScheme:appScheme];
    
}

- (void)pay:(NSString *)orderInfo appScheme:(NSString *)appScheme {
    //调用sdk开始支付
    [[MBRPaySDK defaultService] payOrder:orderInfo fromScheme:appScheme callBack:^(NSDictionary *errorDic) {
        NSInteger resultStatus = [errorDic[@"resultStatus"] integerValue];
        if (resultStatus == 4) {
            [MBProgressHUD bwm_showTitle:@"用户取消安装pay app" toView:self.view hideAfter:2];
        } else if (resultStatus == 5) {
            [MBProgressHUD bwm_showTitle:@"正在安装pay app" toView:self.view hideAfter:2];
        } else if (resultStatus == 6) {
            [MBProgressHUD bwm_showTitle:@"参数缺少渠道号" toView:self.view hideAfter:2];
        }
    }];
}

-(NSString*)prepareOrderInfo:(NSDictionary*)order
{
    
    NSArray* sortedKeys = [order.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *obj11 = obj1;
        NSString *obj22 = obj2;
        NSComparisonResult result = [obj11 compare:obj22];
        return result;
    }];
    
    NSMutableString* signInfo = [NSMutableString new];
    
    for(int i=0;i<sortedKeys.count;i++)
    {
        [signInfo appendFormat:@"%@=%@",sortedKeys[i],order[sortedKeys[i]]];
        
        if(i<sortedKeys.count-1)
            [signInfo appendString:@"&"];
    }
    
    NSLog(@"\rsignInfo:\r%@",signInfo);
    
    
    // 重要说明
    // 这里只是为了方便直接向商户展示整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    
    NSError* error = nil;
    NSString* merchantPrivateKeyFile = [[NSBundle mainBundle]pathForResource:@"partner_rsa_private_key" ofType:@"pem"];
    NSString* merchantPrivateKeyPEM = [NSString stringWithContentsOfFile:merchantPrivateKeyFile encoding:NSUTF8StringEncoding error:&error];
    
    DCPAPISigner* signer = [[DCPAPISigner alloc]initWithPrivateKey:merchantPrivateKeyPEM];
    
    NSData* dataForSign = [signInfo dataUsingEncoding:NSUTF8StringEncoding];
    NSData* signatureData = [signer sign:dataForSign];
    NSString* signatureBase64 = [signatureData base64EncodedString];
    
    NSLog(@"\signatureBase64:\r%@",signatureBase64);
    
    NSString* orderInfo = [NSString stringWithFormat:@"%@&sign=%@",signInfo,signatureBase64];
    
    return orderInfo;
}

#pragma mark -
#pragma mark   ==============处理支付结果==============
- (void)handlePayResult:(NSNotification *)notification {
    NSDictionary *resultDic = [notification object];
    int resultStatus = [resultDic[@"resultStatus"] intValue];
    NSString *message = resultDic[@"message"];
    [MBProgressHUD bwm_showTitle:message toView:self.view hideAfter:2];
}

#pragma mark -
- (NSString *)urlEncodedString:(NSString*)str {
    CFStringRef stringRef = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                    (CFStringRef)str,
                                                                    NULL,
                                                                    CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),
                                                                    kCFStringEncodingUTF8);
    NSString *encodedString = (__bridge NSString *)stringRef;
    CFRelease(stringRef);
    
    if (encodedString) {
        return encodedString;
    }
    
    return nil;
}

@end
