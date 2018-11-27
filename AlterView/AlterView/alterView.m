//
//  alterView.m
//  AlterView
//
//  Created by zlm on 2018/10/29.
//  Copyright © 2018年 zlm. All rights reserved.
//

#import "alterView.h"

@interface alterView ()
{
    UIAlertView *_alterView;
    
    
}
@end

@implementation alterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 200, 100)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
//        _alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要取消关注呢，取消之后将不会收到消息提示" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        _alterView.frame = CGRectMake(0, 100, 200, 100);
//        _alterView.backgroundColor = [UIColor whiteColor];
//        [self addSubview:_alterView];
        
        
        
    }
    return self;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}




@end
