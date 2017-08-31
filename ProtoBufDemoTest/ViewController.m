//
//  ViewController.m
//  ProtoBufDemoTest
//
//  Created by Leejun on 2017/8/24.
//  Copyright © 2017年 Leejun. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncUdpSocket.h"
#import "SendViewController.h"
#import "SmobaData.pbobjc.h"
#import "QQGameViewController.h"
#import "SmobaDataManager.h"

#import "UdpSocketManager.h"

@interface ViewController ()
<
GCDAsyncUdpSocketDelegate
>
{
    //udp对象
    GCDAsyncUdpSocket *_udpServerSoket;
}

@end

@implementation ViewController

- (IBAction)qqLoginGameAction:(id)sender{
    
    QQGameViewController *qqVc = [[QQGameViewController alloc] init];
    [self.navigationController pushViewController:qqVc animated:YES];
}

- (IBAction)weChatAction:(id)sender{
    
    NSURL *url = [NSURL URLWithString:@"weixin://app/wx95a3a4d7c627e07d/auth/?scope=snsapi_base%2Csnsapi_userinfo%2Csnsapi_friend%2Csnsapi_message&state=weixin"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

-(void)showNavItem{
    UIBarButtonItem *sendMyself = [[UIBarButtonItem alloc] initWithTitle:@"发送自己" style:UIBarButtonItemStylePlain target:self action:@selector(sendMyself)];
    self.navigationItem.rightBarButtonItem = sendMyself;
}

- (void)sendMyself{
    
    SendViewController *sendVc = [[SendViewController alloc] init];
    [self.navigationController pushViewController:sendVc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self showNavItem];
    
    [UdpSocketManager sharedInstance];
    
//    [self createUdpSocket];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)createUdpSocket{
    
    dispatch_queue_t dQueue = dispatch_queue_create("My socket queue", DISPATCH_QUEUE_CONCURRENT);
    _udpServerSoket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dQueue socketQueue:nil];;
    
    NSError *error = nil;
    
    bool b = [_udpServerSoket bindToPort:1024 error:&error];
    
    NSLog(@"UDPServerSoket bindToPort --%o",b);
    
    [_udpServerSoket beginReceiving:&error];
    
    [_udpServerSoket enableBroadcast:YES error:&error];
    
}

- (void)receiveData:(NSData *)receiveMsg{
    
    [[SmobaDataManager sharedInstance] updateSmobaData:receiveMsg];
}

-(void)sendBackToHost:(NSString *)ip port:(uint16_t)port withMessage:(NSString *)s{
    
    if ([SmobaDataManager sharedInstance].smobaData.magic != SmobaDataMagic) {
        
        NSLog(@"magic: 0x%x",[SmobaDataManager sharedInstance].smobaData.magic);
        return;
    }
    
    uint32_t flags = [SmobaDataManager sharedInstance].smobaData.flags;
    BOOL needRes = flags%2==0 ? YES : NO;
    if (needRes) {
        flags -= 1;
    }
    
    if (flags == SmobaFlagsInitInfo) {
        
        [SmobaDataManager sharedInstance].smobaData.flags = SmobaFlagsInitInfo;
        [SmobaDataManager sharedInstance].smobaData.logicWorldId = 2021;
        
    }else if (flags == SmobaFlagsRoomDataInfo){
        [SmobaDataManager sharedInstance].smobaData.flags = SmobaFlagsRoomDataInfo;
        
    }else if (flags == SmobaFlagsRoomPlayerInfo){
        
    }else if (flags == SmobaFlagsBattleInfo){
        
    }else{
        
    }
    
    
//    NSString *msg = @"lee发给王者消息";
//    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [[SmobaDataManager sharedInstance].smobaData data];
    
    NSLog(@"发送的信息: %p info: %@", data, [SmobaDataManager sharedInstance].smobaData);
    
    [_udpServerSoket sendData:data toHost:ip port:port withTimeout:60 tag:200];
}

#pragma mark - GCDAsyncUdpSocketDelegate
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
withFilterContext:(nullable id)filterContext{
    
    NSString *ip = [GCDAsyncUdpSocket hostFromAddress:address];
    uint16_t port = [GCDAsyncUdpSocket portFromAddress:address];
    
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
*/

@end
