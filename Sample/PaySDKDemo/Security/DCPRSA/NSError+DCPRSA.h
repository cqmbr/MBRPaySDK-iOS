//
//  NSError+DCPRSA.h
//  DCPRSA
//
//  Created by vken on 2018/4/2.
//  Copyright © 2018年 bocai2018. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError(DCPRSA)

+(NSError*)rsaErrorWithDescription:(NSString*)description;

+(NSError*)rsaErrorWithOSStatus:(OSStatus)status;

@end
