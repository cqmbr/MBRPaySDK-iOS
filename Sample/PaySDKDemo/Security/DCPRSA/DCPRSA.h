//
//  DCPRSA.h
//  DCPRSA
//
//  Created by vken on 2018/4/2.
//  Copyright © 2018年 bocai2018. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCPRSA : NSObject


#pragma mark - 加密
//如果新手，不建议直接调用该方法
#pragma mark 加密实现 不建议外部直接调用该方法
+ (NSData *)encryptData:(NSData *)data withKey:(SecKeyRef)keyRef ifError:(NSError**)error;

#pragma mark PEM加密
+ (NSData *)encryptData:(NSData *)data withPublicPem:(NSString*)pem ifError:(NSError**)error;
+ (NSData *)encryptString:(NSString*)string withPublicPem:(NSString*)pem ifError:(NSError**)error;

#pragma mark DER加密
+ (NSData *)encryptData:(NSData *)data withPublicDer:(NSData*)der ifError:(NSError**)error;
+ (NSData *)encryptString:(NSString*)string withPublicDer:(NSData*)der ifError:(NSError**)error;

#pragma mark - 解密
#pragma mark 解密实现 不建议外部直接调用该方法
+ (NSData *)decryptData:(NSData *)data withKey:(SecKeyRef)keyRef ifError:(NSError**)error;

#pragma mark PEM解密
+ (NSData *)decryptData:(NSData *)data withPrivatePem:(NSString*)pem ifError:(NSError**)error;
+ (NSString* )decryptString:(NSData *)data withPrivatePem:(NSString*)pem ifError:(NSError**)error;

#pragma mark - 签名

+(NSData *)signWithSHA256:(NSData *)data withKey:(SecKeyRef)keyRef ifError:(NSError**)error;
+(NSData *)signWithSHA256:(NSData *)data withPrivatePem:(NSString*)pem ifError:(NSError**)error;

#pragma mark - 验签

+(BOOL)verifyWithSHA256:(NSData*)planData withSignature:(NSData*)signature withKey:(SecKeyRef)keyRef ifError:(NSError**)error;
+(BOOL)verifyWithSHA256:(NSData*)planData withSignature:(NSData*)signature withPrivatePem:(NSString*)pem ifError:(NSError**)error;

@end
