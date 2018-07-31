//
//  DCPRSAKey.h
//  DCPRSA
//
//  Created by vken on 2018/4/2.
//  Copyright © 2018年 bocai2018. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCPRSAKey : NSObject

#pragma mark - PEM格式
+ (SecKeyRef)privateKeyFromPem:(NSString *)privateKey ifError:(NSError **)error;
+ (SecKeyRef)publicKeyFromPem:(NSString *)publicKey ifError:(NSError **)error;

+ (SecKeyRef)privateKeyFromPemWithNoHeaderAndFooter:(NSString *)privateKey ifError:(NSError **)error;
+ (SecKeyRef)publicKeyFromPemWithNoHeaderAndFooter:(NSString *)publicKey ifError:(NSError **)error;

#pragma makr - DER格式
+ (SecKeyRef)publickeyFromDer:(NSData*)data ifError:(NSError **)error;


@end
