//
//  ViewController.m
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/15.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import "ViewController.h"
#import "LNImagePositionButton.h"
#import "LNNetworkManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buton1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    LNImagePositionButton *button5 = [[LNImagePositionButton alloc]init];
    button5.ln_imagePosition = LNButtonImagePostionLeft;
    button5.ln_titleImageMargin = 20;
    button5.backgroundColor = [UIColor lightGrayColor];
    button5.frame = CGRectMake(200, 500, 100, 100);
    [button5 setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
    [button5 setTitle:@"标题" forState:UIControlStateNormal];
    [button5 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
   
    [self.view addSubview:button5];
}
- (IBAction)button1Action:(id)sender {
    //接口调用测试
    [self POST:@"http://baike.baidu.com/api/openapi/BaikeLemmaCardApi" params:^(NSMutableDictionary *params, LNNetworkManagerConfig *config) {
        params[@"scope"] = @103;
        params[@"format"] = @"json";
        params[@"appid"] = @"379020";
        params[@"bk_key"] = @"北京";
        params[@"bk_length"] = @600;
        config.autoHud = YES;
    } success:^(id json) {
        NSLog(@"success--->%@",json);
    } failure:^(NSInteger code, NSString *info) {
        NSLog(@"code--->%zd\ninfo---->%@",code,info);
    } error:^(NSError *error) {
        NSLog(@"error---->%@",error);
    }];
}
- (IBAction)button2Action:(id)sender {
}
- (IBAction)button3Action:(id)sender {
}
- (IBAction)button4Action:(id)sender {
}


@end
