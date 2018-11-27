//
//  ViewController.m
//  AlterView
//
//  Created by zlm on 2018/10/29.
//  Copyright © 2018年 zlm. All rights reserved.
//

#import "ViewController.h"
#import "alterView.h"
#import "VerificationBtn.h"

#define UIColorFromHex(s)               [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"标题";
    [self creatUI];
    
}

- (void)creatUI
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 64, [UIScreen mainScreen].bounds.size.width-20, 100)];
    lab.backgroundColor = [UIColor orangeColor];
    lab.text = @"这是一个测试页面";
    [self.view addSubview:lab];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lab.frame) + 10, 100, 44)];
    [btn setTitle:@"show" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(showAlterView) forControlEvents:UIControlEventTouchUpInside];
    
    VerificationBtn *verBtn = [[VerificationBtn alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 100)/2, CGRectGetMaxY(btn.frame), 100, 44)];
    verBtn.enabled = NO;
    [self.view addSubview:verBtn];
    [verBtn countDownButtonHandler:^(VerificationBtn *countDownButton, NSInteger tag) {
        countDownButton.enabled = NO;
        [countDownButton startCountDownWithSecond:60];
        
        [countDownButton countDownFinished:^NSString *(VerificationBtn *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"重新获取";
        }];
        
    }];
    
    
    
    UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn.frame = CGRectMake(10, CGRectGetMaxY(verBtn.frame)+30, 200, 44);
   // thirdBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:thirdBtn];
    
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 200, 44);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.1),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)UIColorFromHex(0x00C4FE).CGColor,(id)UIColorFromHex(0x0167FE).CGColor]];//渐变数组
    [thirdBtn.layer addSublayer:gradientLayer];
    
    [thirdBtn setTitle:@"代码创建的按钮，使用layer" forState:UIControlStateNormal];
    
    
    
    
}

- (void)showAlterView
{
    UIView *view = [[alterView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:view];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
