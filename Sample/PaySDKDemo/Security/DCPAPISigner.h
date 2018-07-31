//
//  DCPAPISigner.h
//  DCPaySDKDemo
//
//  Created by vken on 2018/4/5.
//  Copyright © 2018年 vken. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCPAPISigner : NSObject

-(id)initWithPrivateKey:(NSString*)privateKeyPem;

-(NSData*)sign:(NSData*)content;

@end
