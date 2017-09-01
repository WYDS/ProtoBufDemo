//
//  UdpSocketManager.m
//  ProtoBufDemoTest
//
//  Created by Leejun on 2017/8/30.
//  Copyright © 2017年 Leejun. All rights reserved.
//

#import "UdpSocketManager.h"
#import "GCDAsyncUdpSocket.h"
#import "SmobaDataManager.h"

@interface UdpSocketManager ()
<
GCDAsyncUdpSocketDelegate
>
{
//    GCDAsyncUdpSocket *_udpServerSoket;
}

@property (nonatomic, strong) GCDAsyncUdpSocket *udpServerSoket;//udp对象

@end

@implementation UdpSocketManager

+ (instancetype)sharedInstance{
    static UdpSocketManager *sharedInstance = nil;
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
        [self createUdpSocket];
    }
    return self;
}

- (void)logout{
    
//    [_udpServerSoket close];
//    _udpServerSoket = nil;
}

#pragma mark -
#pragma mark - Getters and Setters

- (void)setAccountInfo:(NSString *)accountInfo{
    _accountInfo = accountInfo;
}

#pragma mark -
#pragma mark - Methods

- (void)createUdpSocket{
    
    if (_udpServerSoket) {
        return;
    }
    
    dispatch_queue_t dQueue = dispatch_queue_create("My socket queue", DISPATCH_QUEUE_CONCURRENT);
    //dispatch_get_main_queue()
    _udpServerSoket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dQueue];
    
    NSError *error = nil;
    
    bool b = [_udpServerSoket bindToPort:1024 error:&error];
    
    NSLog(@"UDPServerSoket bindToPort --%o",b);
    
    [_udpServerSoket beginReceiving:&error];
    
    [_udpServerSoket enableBroadcast:YES error:&error];
    
}

-(void)sendBackToHost:(NSString *)ip port:(uint16_t)port withMessage:(NSString *)message{
    
    if (message.length > 0) {
        //自定义发送
        NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
        [_udpServerSoket sendData:data toHost:ip port:port withTimeout:60 tag:200];
        return;
    }
    
    if ([SmobaDataManager sharedInstance].smobaData.magic != SmobaDataMagic) {
        
        NSLog(@"magic: 0x%x",[SmobaDataManager sharedInstance].smobaData.magic);
        return;
    }
    
    uint32_t flags = [SmobaDataManager sharedInstance].smobaData.flags;
    BOOL needRes = flags%2==0 ? YES : NO;
    if (needRes) {
        flags -= 1;
    }else{
        
        NSString *selfIp = @"127.0.0.1";
        uint16_t selfport = 1025;
        if (flags == SmobaFlagsRoomDataInfo){
            NSData *data = [[SmobaDataManager sharedInstance].smobaData data];
            NSLog(@"发送王者的信息: %p info: %@", data, [SmobaDataManager sharedInstance].smobaData);
            [_udpServerSoket sendData:data toHost:selfIp port:selfport withTimeout:60 tag:200];
        }
        return;
    }
    
    if (flags == SmobaFlagsInitInfo) {
        
        [SmobaDataManager sharedInstance].smobaData.flags = SmobaFlagsInitInfo;
        [SmobaDataManager sharedInstance].smobaData.accountInfo = _accountInfo;
//        [SmobaDataManager sharedInstance].smobaData.logicWorldId = 2021;
        
        NSMutableArray *playerArray = [SmobaDataManager sharedInstance].smobaData.playerArray;
        if (!playerArray) {
            playerArray = [NSMutableArray array];
        }else{
            [playerArray removeAllObjects];
        }
        // player
        PlayerPB *player1 = [PlayerPB new];
        player1.playerId = 1;
        player1.camp = 1;
        player1.isMaster = 1;
        [playerArray addObject:player1];
        
        PlayerPB *player2 = [PlayerPB new];
        player2.playerId = 2;
        player2.camp = 2;
        player2.isMaster = 0;
        [playerArray addObject:player2];
        
        [SmobaDataManager sharedInstance].smobaData.playerArray = playerArray;
        
        
    }else if (flags == SmobaFlagsChooseGameServer){
        
        [SmobaDataManager sharedInstance].smobaData.flags = SmobaFlagsChooseGameServer;
        [SmobaDataManager sharedInstance].smobaData.logicWorldId = 2021;
        
    }else if (flags == SmobaFlagsRoomDataInfo){
        
        [SmobaDataManager sharedInstance].smobaData.flags = SmobaFlagsRoomDataInfo;
        
//        [SmobaDataManager sharedInstance].smobaData.roomInfo.roomType = RoomInfoPB_PVPRoomType_PvproomType1V1;
//        [SmobaDataManager sharedInstance].smobaData.roomInfo.roomData = @"";
        
    }else if (flags == SmobaFlagsRoomPlayerInfo){
        
        [SmobaDataManager sharedInstance].smobaData.flags = SmobaFlagsRoomPlayerInfo;
        
    }else if (flags == SmobaFlagsBattleInfo){
        
        [SmobaDataManager sharedInstance].smobaData.flags = SmobaFlagsBattleInfo;
        
    }else{
        
    }
    
    NSData *data = [[SmobaDataManager sharedInstance].smobaData data];
    
    NSLog(@"发送回执信息: %p info: %@", data, [SmobaDataManager sharedInstance].smobaData);
    
    [_udpServerSoket sendData:data toHost:ip port:port withTimeout:60 tag:200];
}

- (void)receiveData:(NSData *)receiveMsg{
    
    [[SmobaDataManager sharedInstance] updateSmobaData:receiveMsg];
}

#pragma mark -
#pragma mark - GCDAsyncUdpSocketDelegate

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
withFilterContext:(nullable id)filterContext{
    
    NSString *ip = [GCDAsyncUdpSocket hostFromAddress:address];
    uint16_t port = [GCDAsyncUdpSocket portFromAddress:address];
    
    if ([ip isEqualToString:@"127.0.0.1"] && port == 1024) {
        
        return;
    }
    
//    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"来自于 [%@:%u] 消息内容-----%p",ip, port,data);
    
    //解析收到的信息
    [self receiveData:data];
    
    
    [self sendBackToHost:ip port:port withMessage:nil];
    
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag{
    NSLog(@"yeah! udpSocket send data succeed with tag:%lu",tag);
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error{
    NSLog(@"error! udpSocket sendData failed tag:%lu error:%@",tag,[error localizedDescription]);
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotConnect:(NSError * _Nullable)error{
    
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address{
    
}

@end
