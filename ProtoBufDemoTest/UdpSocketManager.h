//
//  UdpSocketManager.h
//  ProtoBufDemoTest
//
//  Created by Leejun on 2017/8/30.
//  Copyright © 2017年 Leejun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UdpSocketManager : NSObject

@property (nonatomic, strong) NSString *accountInfo;//登录的授权信息

+ (instancetype)sharedInstance;
- (void)logout;

-(void)sendBackToHost:(NSString *)ip port:(uint16_t)port withMessage:(NSString *)message;

@end
