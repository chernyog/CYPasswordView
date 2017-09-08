//
//  CYPasswordView.h
//  CYPasswordViewDemo
//
//  Created by cheny on 15/10/8.
//  Copyright © 2015年 zhssit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYPasswordInputView.h"
#import "CYConst.h"
#import "NSBundle+CYPasswordView.h"

@interface CYPasswordView : UIView

/** 正在请求时显示的文本 */
@property (nonatomic, copy) NSString *loadingText;

/** 完成的回调block */
@property (nonatomic, copy) void (^finish) (NSString *password);

/** 密码框的标题 */
@property (nonatomic, copy) NSString *title;

/** 弹出密码框 */
- (void)showInView:(UIView *)view;

/** 隐藏键盘 */
- (void)hideKeyboard;

/** 隐藏密码框 */
- (void)hide;

/** 开始加载 */
- (void)startLoading;

/** 加载完成 */
- (void)stopLoading;

/** 请求完成 */
- (void)requestComplete:(BOOL)state;
- (void)requestComplete:(BOOL)state message:(NSString *)message;

@end
