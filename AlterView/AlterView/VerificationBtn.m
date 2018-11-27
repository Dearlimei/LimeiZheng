//
//  VerificationBtn.m
//  AlterView
//
//  Created by zlm on 2018/11/1.
//  Copyright © 2018年 zlm. All rights reserved.
//

#import "VerificationBtn.h"

#define UIColorFromHex(s)               [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
#define Scale ([[UIScreen mainScreen] bounds].size.width/375.0)

@interface NSTimer (JKCountDownBlocksSupport)
+ (NSTimer *)jkcd_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                           block:(void(^)(void))block
                                         repeats:(BOOL)repeats;
@end



@interface VerificationBtn (){
    NSInteger _second;
    NSUInteger _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
    
    CountDownChanging _countDownChanging;
    CountDownFinished _countDownFinished;
    TouchedCountDownButtonHandler _touchedCountDownButtonHandler;
    
}

@end

@implementation VerificationBtn


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self setTitleColor:UIColorFromHex(0x0B9DFF) forState:UIControlStateNormal];
        self.layer.borderColor = UIColorFromHex(0x0B9DFF).CGColor;
        self.layer.borderWidth = 1.0;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.layer.cornerRadius = 22.0*Scale;
    
    }
    return self;
}
- (void)setEnabled:(BOOL)enabled
{
    if (enabled == NO) {
        [self setTitleColor:UIColorFromHex(0xb6b6b8) forState:UIControlStateNormal];
        self.layer.borderColor = UIColorFromHex(0xb6b6b8).CGColor;
        
    }else
    {
        [self setTitleColor:UIColorFromHex(0x0B9DFF) forState:UIControlStateNormal];
        self.layer.borderColor = UIColorFromHex(0x0B9DFF).CGColor;
    }
    
}

//- (void)setSelected:(BOOL)selected
//{
//    if (selected == YES) {
//        [self setTitleColor:UIColorFromHex(0xb6b6b8) forState:UIControlStateNormal];
//        self.layer.borderColor = UIColorFromHex(0xb6b6b8).CGColor;
//
//    }else
//    {
//        [self setTitleColor:UIColorFromHex(0x0B9DFF) forState:UIControlStateNormal];
//        self.layer.borderColor = UIColorFromHex(0x0B9DFF).CGColor;
//    }
//
//}

- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler
{
    _touchedCountDownButtonHandler = [touchedCountDownButtonHandler copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)touched:(VerificationBtn *)btn
{
    //self.selected = YES;
    if (_touchedCountDownButtonHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _touchedCountDownButtonHandler(btn,btn.tag);
        });
    }
    
}

- (void)startCountDownWithSecond:(NSUInteger)second
{
    [self setTitleColor:UIColorFromHex(0xb6b6b8) forState:UIControlStateNormal];
    self.layer.borderColor = UIColorFromHex(0xb6b6b8).CGColor;
    
    _totalSecond = second;
    __weak typeof (self) weakSelf = self;
    _timer = [NSTimer jkcd_scheduledTimerWithTimeInterval:1.0 block:^{
        [weakSelf timerStart];
    } repeats:YES];
    
    _startDate = [NSDate date];
    _timer.fireDate = [NSDate distantPast];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    
    
}

- (void)timerStart {
    double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    
    _second = _totalSecond - (NSInteger)(deltaTime+0.5) ;
    
    
    if (_second<= 0.0)
    {
        [self stopCountDown];
    }
    else
    {
//        if (_countDownChanging)
//        {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSString *title = _countDownChanging(self,_second);
//                [self setTitle:title forState:UIControlStateNormal];
//                [self setTitle:title forState:UIControlStateDisabled];
//            });
//        }
//        else
//        {
            NSString *title = [NSString stringWithFormat:@"%zds",_second];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];
            
        //}
    }
}


- (void)stopCountDown{
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)])
        {
            if ([_timer isValid])
            {
                [_timer invalidate];
                _second = _totalSecond;
                if (_countDownFinished)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        NSString *title = _countDownFinished(self,_totalSecond);
                        [self setTitle:title forState:UIControlStateNormal];
                        [self setTitle:title forState:UIControlStateDisabled];
                        //self.selected = NO;
                    });
                }
                else
                {
                    //self.selected = NO;
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setTitle:@"重新获取" forState:UIControlStateDisabled];
                    
                    
                }
            }
        }
    }
}

#pragma mark - block
- (void)countDownChanging:(CountDownChanging)countDownChanging{
    _countDownChanging = [countDownChanging copy];
}

- (void)countDownFinished:(CountDownFinished)countDownFinished
{
    _countDownFinished = [countDownFinished copy];
    
}

@end


@implementation NSTimer (JKCountDownBlocksSupport)
+ (NSTimer *)jkcd_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                           block:(void(^)(void))block
                                         repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(jkcd_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}
+ (void)jkcd_blockInvoke:(NSTimer *)timer {
    void (^block)(void) = timer.userInfo;
    if(block) {
        block();
    }
}
@end


