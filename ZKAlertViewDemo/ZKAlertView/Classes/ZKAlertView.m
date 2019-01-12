//
//  ZKAlertView.m
//  ZKAlertView
//
//  Created by Zhao Kun on 2018/12/2.
//  Copyright © 2018 Zhao Kun. All rights reserved.
//

#import "ZKAlertView.h"
#import <Masonry/Masonry.h>

@interface ZKAlertView ()

@property (nonatomic, strong) UIControl *bgControl;
@property (nonatomic, weak) UIWindow *originKeyWindow;
@property (nonatomic, strong) UIWindow *alertWindow;

@end

@implementation ZKAlertView

#define kZKAlertViewScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kZKAlertViewScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kZKAlertViewScreenBounds ([UIScreen mainScreen].bounds)

#pragma mark - action

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.allowCloseTapGesture = true;
}

- (void)setContentView:(UIView *)contentView contentSize:(CGSize)contentSize {
    CGFloat topMargin = (kZKAlertViewScreenHeight - contentSize.height) / 2;
    [self setContentView:contentView contentSize:contentSize topMargin:topMargin];
}

- (void)setContentView:(UIView *)contentView contentSize:(CGSize)contentSize topMargin:(CGFloat)topMargin {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self addSubview:self.bgControl];
    [self addSubview:contentView];
    CGFloat contentWidth = kZKAlertViewScreenWidth<contentSize.width?kZKAlertViewScreenWidth:contentSize.width;
    CGFloat contentHeight = kZKAlertViewScreenHeight<contentSize.height?kZKAlertViewScreenHeight:contentSize.height;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(topMargin);
        make.width.equalTo(@(contentWidth));
        make.height.equalTo(@(contentHeight));
    }];
}

- (void)show {
    self.originKeyWindow = [UIApplication sharedApplication].keyWindow;
    self.frame = kZKAlertViewScreenBounds;
    [self.alertWindow makeKeyAndVisible];
    [self.alertWindow addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
    [self.originKeyWindow makeKeyAndVisible];
    self.alertWindow.hidden = true;
}

- (void)clickBG {
    if (_allowCloseTapGesture) {
        [self dismiss];
    }
}

#pragma mark - getter
- (UIWindow *)alertWindow {
    if (!_alertWindow) {
        _alertWindow = [[UIWindow alloc] initWithFrame:kZKAlertViewScreenBounds];
        _alertWindow.windowLevel = UIWindowLevelAlert;
        _alertWindow.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    }
    return _alertWindow;
}

- (UIControl *)bgControl {
    if (!_bgControl) {
        _bgControl = [[UIControl alloc] initWithFrame:kZKAlertViewScreenBounds];
        [_bgControl addTarget:self action:@selector(clickBG) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgControl;
}

@end
