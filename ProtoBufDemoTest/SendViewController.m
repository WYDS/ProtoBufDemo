//
//  SendViewController.m
//  ProtoBufDemoTest
//
//  Created by Leejun on 2017/8/24.
//  Copyright © 2017年 Leejun. All rights reserved.
//

#import "SendViewController.h"
#import "GCDAsyncUdpSocket.h"
#import "SmobaData.pbobjc.h"

#import <ifaddrs.h>
#import <arpa/inet.h>

@interface SendViewController ()
<
GCDAsyncUdpSocketDelegate
>
{
    //udp对象
    GCDAsyncUdpSocket *_sendUdpSocket;
}

@end

@implementation SendViewController


-(void)dealloc{
    NSLog(@"%s",__func__ );
    [_sendUdpSocket close];
    _sendUdpSocket = nil;
}

- (void) showNavItem {
    UIBarButtonItem *sendMsg = [[UIBarButtonItem alloc] initWithTitle:@"发送消息" style:UIBarButtonItemStylePlain target:self action:@selector(sendMsg)];
    self.navigationItem.rightBarButtonItem = sendMsg;
}

- (void)sendMsg {
    NSString *s = @"hello IOS";
    NSData *data = [s dataUsingEncoding:NSUTF8StringEncoding];
    
//    SmobaData *smobaData = [[SmobaData alloc] init];
//    smobaData.magic = 1;
//    smobaData.cmd = 2;
//    smobaData.req = 3;
//    smobaData.logicWorldId = 4;
//    smobaData.winCamp = 5;
//    smobaData.playerArray_Count = 0;
    
    NSString *host = @"127.0.0.1";// 本机的ip
//    host = [self getIPAddress];//获取手机的IP
    uint16_t port = 1024;
    
    //开始发送
    //改函数只是启动一次发送 它本身不进行数据的发送, 而是让后台的线程慢慢的发送 也就是说这个函数调用完成后,数据并没有立刻发送,异步发送
    [_sendUdpSocket sendData:data toHost:host port:port withTimeout:60 tag:100];
}

- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"发送";
    [self showNavItem];
    [self createClientUdpSocket];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)createClientUdpSocket{
    
    dispatch_queue_t dQueue = dispatch_queue_create("client udp socket", NULL);
    
    //1.创建一个 udp socket用来和服务器端进行通讯
    _sendUdpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dQueue socketQueue:nil];
    
    //2.banding一个端口(可选),如果不绑定端口, 那么就会随机产生一个随机的电脑唯一的端口
    //端口数字范围(1024,2^16-1)
    [_sendUdpSocket bindToPort:8085 error:nil];
    
    //3.等待接收对方的消息
    [_sendUdpSocket receiveOnce:nil];
}

#pragma mark -GCDAsyncUdpSocketDelegate  
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag{
    if (tag == 100) {
        NSLog(@"表示标记为100的数据发送完成了");
    }
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error{
    NSLog(@"标记为tag %ld的发送失败 失败原因 %@",tag, error);
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext{
    
    NSString *ip = [GCDAsyncUdpSocket hostFromAddress:address];
    uint16_t port = [GCDAsyncUdpSocket portFromAddress:address];
    NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // 继续来等待接收下一次消息
    NSLog(@"收到服务端的响应 [%@:%d] %@", ip, port, s);
    [sock receiveOnce:nil];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self sendBackToHost:ip port:port withMessage:s];
    });
    
}

-(void)sendBackToHost:(NSString *)ip port:(uint16_t)port withMessage:(NSString *)s{
    
    NSString *msg = @"我再发送消息";
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [_sendUdpSocket sendData:data toHost:ip port:port withTimeout:60 tag:200];
}

@end

