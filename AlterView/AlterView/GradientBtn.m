//
//  GradientBtn.m
//  AlterView
//
//  Created by zlm on 2018/11/12.
//  Copyright © 2018年 zlm. All rights reserved.
//

#import "GradientBtn.h"

#define UIColorFromHex(s)               [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
@implementation GradientBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorFromHex(0xC7C7CC);
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    if (enabled == NO) {
        self.backgroundColor = self.backgroundColor;
    }else
    {
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, 200, 44);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.1),@(1.0)];//渐变点
        [gradientLayer setColors:@[(id)UIColorFromHex(0x00C4FE).CGColor,(id)UIColorFromHex(0x0167FE).CGColor]];//渐变数组
        [self.layer addSublayer:gradientLayer];
        
    }
    
}

@end
