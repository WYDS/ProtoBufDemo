//
//  SmobaDataManager.m
//  ProtoBufDemoTest
//
//  Created by Leejun on 2017/8/24.
//  Copyright © 2017年 Leejun. All rights reserved.
//

#import "SmobaDataManager.h"
#import "UdpSocketManager.h"

@implementation SmobaDataManager

+ (instancetype)sharedInstance{
    static SmobaDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id )init
{
    self = [super init];
    if (self) {
        _smobaData = [[SmobaData alloc] init];
    }
    return self;
}

- (void)updateSmobaData:(NSData *)data{
    
    NSError *error = nil;
    _smobaData = [SmobaData parseFromData:data error:&error];
    if (error) {
        NSLog(@"update smobadata failed :%@",[error localizedDescription]);
        return;
    }
    
    [self parseData];
    
}

- (void)parseData{
    
    if (_smobaData == nil) {
        return;
    }
    _smobaData.accountId = TEST_ACCOUNT_ID;
    _smobaData.accountInfo = [UdpSocketManager sharedInstance].accountInfo;
    
    NSLog(@"收到了插件的信息:-------%@",_smobaData);
    
//    NSLog(@"我接收到的房间信息是：magic: 0x%x flags:%u roomData: %@ playerArray: %lu", _smobaData.magic, _smobaData.flags,_smobaData.roomInfo.roomData, (unsigned long)_smobaData.playerArray_Count);
//    
//    if (_smobaData.playerArray_Count != 0) {
//        
//        for (PlayerPB *player in _smobaData.playerArray) {
//            
//            NSLog(@"playerID: %llu camp: %d isMaster: %d dead: %d", player.playerId, player.camp, player.isMaster, player.isReady);
//        }
//    }
}

@end
