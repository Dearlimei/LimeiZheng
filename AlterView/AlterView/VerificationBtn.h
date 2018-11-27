//
//  VerificationBtn.h
//  AlterView
//
//  Created by zlm on 2018/11/1.
//  Copyright © 2018年 zlm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerificationBtn : UIButton

typedef NSString* (^CountDownChanging)(VerificationBtn *countDownButton,NSUInteger second);
typedef NSString* (^CountDownFinished)(VerificationBtn *countDownButton,NSUInteger second);
typedef void (^TouchedCountDownButtonHandler)(VerificationBtn *countDownButton,NSInteger tag);


@property (nonatomic, strong) id userInfo;

// 倒计时按钮点击回调
- (void)countDownFinished:(CountDownFinished)countDownFinished;
- (void)startCountDownWithSecond:(NSUInteger)second;
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler;



@end
