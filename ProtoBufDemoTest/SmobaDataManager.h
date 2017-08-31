//
//  SmobaDataManager.h
//  ProtoBufDemoTest
//
//  Created by Leejun on 2017/8/24.
//  Copyright © 2017年 Leejun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmobaData.pbobjc.h"

#define SmobaDataMagic 0xfeed121

#define TEST_ACCOUNT_ID  1

typedef enum : NSUInteger {
    SmobaFlagsNone=0,
    SmobaFlagsInitInfo=1, //授权信息
    SmobaFlagsChooseGameServer=3, //区号
    SmobaFlagsRoomDataInfo=5,
    SmobaFlagsRoomPlayerInfo=7,
    SmobaFlagsBattleInfo=9,
} SmobaFlags;

@interface SmobaDataManager : NSObject

@property (nonatomic, strong) SmobaData *smobaData;

+ (instancetype)sharedInstance;

- (void)updateSmobaData:(NSData *)data;

@end
