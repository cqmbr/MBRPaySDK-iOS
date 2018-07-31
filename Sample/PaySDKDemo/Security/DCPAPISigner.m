//
//  DCPAPISigner.m
//  DCPaySDKDemo
//
//  Created by vken on 2018/4/5.
//  Copyright © 2018年 vken. All rights reserved.
//

#import "DCPAPISigner.h"
#import "DCPRSAKey.h"
#import "DCPRSA.h"

@interface DCPAPISigner()

@property(nonatomic,assign) SecKeyRef privateKey;

@end

@implementation DCPAPISigner

-(id)initWithPrivateKey:(NSString*)privateKeyPem
{
    self = [super init];
    if(self)
    {
        NSError* error = nil;
        _privateKey = [DCPRSAKey privateKeyFromPem:privateKeyPem ifError:&error];
    }
    return self;
}

-(NSData*)sign:(NSData*)content
{
    NSError* error = nil;
    NSData* signature = [DCPRSA signWithSHA256:content withKey:_privateKey ifError:&error];
    return signature;
}

@end
