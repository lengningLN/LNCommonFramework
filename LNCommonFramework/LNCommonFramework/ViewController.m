//
//  ViewController.m
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/15.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import "ViewController.h"
#import "LNImagePositionButton.h"
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


@end
