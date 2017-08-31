//
//  QQGameViewController.m
//  ProtoBufDemoTest
//
//  Created by Leejun on 2017/8/24.
//  Copyright © 2017年 Leejun. All rights reserved.
//

#import "QQGameViewController.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "UdpSocketManager.h"

@interface QQGameViewController ()
<
UIWebViewDelegate
>
@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end

@implementation QQGameViewController


- (NSString *)getDeviceMachine{
    
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    NSString *deviceMachine = [[self getDeviceMachine] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://xui.ptlogin2.qq.com/cgi-bin/xlogin?appid=716027609&pt_3rd_aid=1104466820&daid=381&pt_skey_valid=0&style=35&s_url=http%%3A%%2F%%2Fconnect.qq.com&refer_cgi=m_authorize&ucheck=1&fall_to_wv=1&status_os=%@&redirect_uri=auth%%3A%%2F%%2Fwww.qq.com&client_id=1104466820&response_type=token&scope=all&sdkp=i&sdkv=3.2.1&state=test&status_machine=%@&switch=1",systemVersion,deviceMachine]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"自动填充" style:UIBarButtonItemStyleDone target:self action:@selector(autoFill:)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)autoFill:(UIButton *)btn {
    
    // accID = 2
    //1056816697
    //luzhilin408131
    
    // accID = 3
    //284733423
    //19940131lc0.0
    
    NSString *javaScript = @"document.getElementsByClassName(\"input_id\")[0].value=\"1056816697\";document.getElementsByClassName(\"input_pwd\")[0].value=\"luzhilin408131\";";
    
    [_webView stringByEvaluatingJavaScriptFromString:javaScript];
    
    [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('go').click()"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *)parseURL:(NSURL *)url {
    
//    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
//    
//    NSMutableDictionary<NSString *, NSString *> *queryParams = [NSMutableDictionary<NSString *, NSString*> new];
//    for (NSURLQueryItem *queryItem in [urlComponents queryItems]) {
//        if (queryItem.value == nil) {
//            continue;
//        }
//        [queryParams setObject:queryItem.value forKey:queryItem.name];
//    }
    
    
    NSString *str = [[url absoluteString] stringByReplacingOccurrencesOfString:@"auth://www.qq.com?#" withString:@""];
    
    NSArray *items = [str componentsSeparatedByString:@"&"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSArray *needKey = @[@"access_token", @"expires_in", @"openid", @"pay_token", @"pf", @"pfkey", @"ret"];
    for (NSString *item in items) {
        NSArray *arr = [item componentsSeparatedByString:@"="];
        if (arr.count!=2) break;
        NSString *key = arr[0];
        NSString *value = arr[1];
        
        if ([needKey containsObject: key]) {
            dict[key] = value;
        }
    }
    dict[@"msg"] = @"";
    dict[@"user_cancelled"] = @"NO";
    dict[@"passDataResp"] = @[];
    dict[@"encrytoken"] = @"abfd50cc4c4d83f22751122909b920cf";
    if (![dict valueForKey:@"openid"]) {
        dict[@"openid"] = @"9CBCE619810A9250192E7C16CA52A7D0";
    }
    return dict;
}

- (NSString *)generatedOpenURL:(NSDictionary *)dict withRoomData:(NSString *)roomData {
    
    NSString *forwardURL = [NSString stringWithFormat:@"tencent1104466820://?platform=qq_m&user_openid=%@&openid=%@&atoken=%@&ptoken=%@&launchfrom=sq_gamecenter", dict[@"openid"], dict[@"openid"], dict[@"access_token"], dict[@"pay_token"]];
//    forwardURL = @"tencent1104466820://";
    if (roomData && [roomData length] != 0) {
        return [forwardURL stringByAppendingFormat:@"&gamedata=%@&platformdata=", roomData];
    }
    return forwardURL;
}

- (void)keepAccountInfoWithDic:(NSDictionary *)dict{
    
    NSString *accountInfo = [NSString stringWithFormat:@"tencent1104466820://?platform=qq_m&user_openid=%@&openid=%@&atoken=%@&ptoken=%@&launchfrom=sq_gamecenter", dict[@"openid"], dict[@"openid"], dict[@"access_token"], dict[@"pay_token"]];
    [[UdpSocketManager sharedInstance] setAccountInfo:accountInfo];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *url = [request URL];
    if ([[url scheme] isEqualToString:@"auth"]) {
        NSDictionary *dict = [self parseURL:url];
//        NSLog(@"===========: %@", dict);
        
        [self keepAccountInfoWithDic:dict];
        
        NSString *forwardURL = [self generatedOpenURL:dict withRoomData:nil];
        NSLog(@"formURL: %@", forwardURL);
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: forwardURL]];
    }
    
    return YES;
}

@end
