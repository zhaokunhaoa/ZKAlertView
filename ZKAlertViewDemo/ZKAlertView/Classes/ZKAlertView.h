//
//  ZKAlertView.h
//  ZKAlertView
//
//  Created by Zhao Kun on 2018/12/2.
//  Copyright © 2018 Zhao Kun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKAlertView : UIView

// 点击弹屏黑色透明背景是否关闭弹窗
@property (nonatomic, assign) BOOL allowCloseTapGesture;

// 居中模式
- (void)setContentView:(UIView *)contentView
           contentSize:(CGSize)contentSize;

// 距离顶部距离 topMargin
- (void)setContentView:(UIView *)contentView
           contentSize:(CGSize)contentSize
             topMargin:(CGFloat)topMargin;

- (void)show;
- (void)dismiss;

@end
