<!-- /TOC -->
## SDK集成

### 导入sdk

#### 选择一：Cocoapods导入

在工程的Podfile文件里面添加以下代码：
```
  pod 'MBRPaySDK','~>1.0.11'
```
  保存并执行pod install,然后用后缀为.xcworkspace的文件打开工程。

#### 选择二：手动导入

1、把文件MBRPaySDK.framework拷贝到项目文件夹下，并导入到项目工程中。
在Build Phases选项卡的Link Binary With Libraries中，增加以下依赖：
![avatar](https://raw.githubusercontent.com/cqmbr/MBRPaySDK-iOS/master/docs/images/link_librarys.png)
2、将 MBRPaySDK.framework 中的 MBRPaySDKResource.bundle 添加到工程


### 配置白名单
sdk会查询pay app是否安装，因此需要在info.plist文件中配置白名单。如下图所示，格式为mbrpay+渠道号
![avatar](https://raw.githubusercontent.com/cqmbr/MBRPaySDK-iOS/master/docs/images/add_scheme.png)

### 配置scheme
点击项目名称，点击“Info”选项卡，在“URL Types”选项中，点击“+”，在“URL Schemes”中输入“paysdkdemo”。
![avatar](https://raw.githubusercontent.com/cqmbr/MBRPaySDK-iOS/master/docs/images/set_scheme.jpg)

注意：这里的URL Schemes中输入的“paysdkdemo”，为测试demo，参考demo文件“ViewController.m”的NSString *appScheme = @"paysdkdemo"。
实际商户的app中要填写独立的scheme，建议跟商户的app有一定的标示度，要做到和其他的商户app不重复，否则可能会导致支付app返回的结果无法正确跳回商户app。

## sdk使用
### 组装支付请求
<table><tr><td bgcolor=yellow>TIPS：这一步应在商户服务端完成，商户服务端直接将组装和签名后的请求串orderInfo传给客户端，客户端直接传给SDK发起请求。文档和Demo是为了示例效果在客户端实现。</td></tr></table>

```objc
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
    
    //应用注册scheme,在PaySDKDemo-Info.plist定义URL types
    NSString *appScheme = @"paysdkdemo";
    
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
```

详细可参见Demo中示例文件
- PaySDKDemo\ViewController.h
- PaySDKDemo\ViewController.m

### 支付回调处理
配置Pay客户端返回url处理方法（Pay App将处理结果通过url返回。）</br> 
如示例PaySDKDemo\AppDelegate.m文件中，增加引用代码：
```objc
#import <MBRPaySDK/MBRPaySDK.h>
```
在@implementation AppDelegate中以下代码中的NSLog改为实际业务处理代码：
```objc
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"mbrpay"]) {
        // 处理支付结果
        [[MBRPaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}
```
```objc
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    
    if ([url.host isEqualToString:@"mbrpay"]) {
        // 处理支付结果
        [[MBRPaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}
```

## Demo
### Demo地址：
https://github.com/cqmbr/MBRPaySDK-iOS.git </br>

### Demo使用说明：
demo代码位于Sample目录，在Sample目录执行pod update，然后用后缀为.xcworkspace的文件打开工程运行即可。

### 关于Demo中签名代码问题
PaySDKDemo\Security及下面所有文件
这些文件是为示例签名所在客户端本地使用。实际场景下请商户把私钥保存在服务端，在服务端进行支付请求参数签名。


## SDK接口

### 获取服务实例

```objc
/**
 *  创建支付单例服务
 *
 *  @return 返回单例对象
 */
+ (instancetype *)defaultService;
```

### 设置配置项(1.0.7新增)
```objc
/**
 配置
 */
@property (nonatomic, strong) MBRPayConfig* payConfig;
```
配置环境示例（根据环境的不同会下载不同的安装包，如果不设置，默认为生产环境）
```objc
MBRPayConfig *config = [[MBRPayConfig alloc] init];
config.environmnent = MBRPaySDKEnvironmentProduction;
[MBRPaySDK defaultService].payConfig = config;
```

### 订单支付
主要为商户提供订单支付功能
```objc
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
```


orderStr示例如下：

"amount=0.01&channel=73088886094000&coinId=34190899187000&merchantId=10000000000003&merchantName=测试商户&orginAmount=10000000000000000&payBillNo=28028237201562&refBizNo=1533041803966&toAddr=0x91f8654587917f3a0c7cfc5fa05bd86dc0162ddb&sign=WvSE9iQjuD46G65OAUUtVmGQrO3cniZWKr7sEXwCD+ZJjqEdCQjV1q96uCeG8CSqUAt7N2TVlvpfWFQm1q19xAeYsr+Dpp49BQQNYgogZ2iGYzr180M6facM8nRovRxPUfZ3wHeEuyrC5/kXKh7PJzHpELh0SlJngJdfSi9yPK4W+2cOyCf0dvNaLQzbmcaJc3KNu3xPOI+JRZSyjHEiBEBl5atjMx24n8R0CstK50s7vEgFppZ2KtvLzdsjRlD0M8E043uT4wp6ltwN1OuPffW6PLTeGO2QT9rEfZBUFJvO2nGpVa5AAJhpSs+VEcUU0eoH1CEgInCLkPF3h9xtrA=="

错误回调参数名称                |描述               
-----------------------------|----------------------------------
resultStatus                 |  结果码：4-用户取消安装；5-用户正在安装；6-缺少渠道号；            
message                      |  支付结果描述               
orderInfo                    |  商户app调用支付接口时传入的订单字符串，透传回来  

### 处理客户端返回url
```objc
/**
 *  处理Pay app支付跳回商户app携带的支付结果Url
 *
 *  @param resultUrl        Pay客户端回传的url
 *  @param completionBlock  处理完支付回调请求，会通过该completionBlock返回支付结果
 */
- (void)processOrderWithPaymentResult:(NSURL *)resultUrl
                      standbyCallback:(CompletionBlock)completionBlock;
```

参数名称                      |描述               
-----------------------------|----------------------------------
resultStatus                 |  结果码：1-支付成功；2-取消支付；3-参数错误；
message                      |  支付结果描述               
orderInfo                    |  商户app调用支付接口时传入的订单字符串，透传回来  

<table><tr><td bgcolor=yellow>TIPS：支付成功只代表已经成功发送交易，实际支付结果以后台同步的结果为准。</td></tr></table>
