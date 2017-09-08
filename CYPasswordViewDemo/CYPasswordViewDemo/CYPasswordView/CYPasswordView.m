//
//  CYPasswordView.m
//  CYPasswordViewDemo
//
//  Created by cheny on 15/10/8.
//  Copyright © 2015年 zhssit. All rights reserved.
//

#import "CYPasswordView.h"
#import "UIView+Extension.h"

#define kPWDLength 6

@interface CYPasswordView () <UITextFieldDelegate>

/** 输入框 */
@property (nonatomic, strong) CYPasswordInputView *passwordInputView;
@property (nonatomic, strong) UITextField *txfResponsder;

/** 蒙板 */
@property (nonatomic, strong) UIControl *coverView;
/** 返回密码 */
@property (nonatomic, copy) NSString *password;

@property (nonatomic, strong) UIImageView *imgRotation;
@property (nonatomic, strong) UILabel *lblMessage;

@end

@implementation CYPasswordView

#pragma mark  - 常量区
static NSString *tempStr;

#pragma mark  - 生命周期方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CYScreen.bounds];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)dealloc
{
    CYLog(@"cy =========== %@：我走了", [self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    // 蒙版
    [self addSubview:self.coverView];
    // 输入框
    [self addSubview:self.passwordInputView];
    // 响应者
    [self addSubview:self.txfResponsder];
    
    [self.passwordInputView addSubview:self.imgRotation];
    [self.passwordInputView addSubview:self.lblMessage];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imgRotation.centerX = self.passwordInputView.centerX;
    self.imgRotation.centerY = self.passwordInputView.height * 0.5;
    
    self.lblMessage.centerX = self.passwordInputView.centerX;
    self.lblMessage.centerY = CGRectGetMaxY(self.imgRotation.frame) + CYPasswordViewTextFieldMarginTop;
    self.lblMessage.x = 0;
    self.lblMessage.width = CYScreenWith;
}

#pragma mark  - <UITextFieldDelegate>
#pragma mark  处理字符串 和 删除键
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (!tempStr) {
        tempStr = string;
    } else {
        tempStr = [NSString stringWithFormat:@"%@%@",tempStr,string];
    }
    
    if ([string isEqualToString:@""]) {
        [CYNotificationCenter postNotificationName:CYPasswordViewDeleteButtonClickNotification object:self];
        if (tempStr.length > 0) {   //  删除最后一个字符串
            NSString *lastStr = [tempStr substringToIndex:[tempStr length] - 1];
            tempStr = lastStr;
        }
    } else {
        if (tempStr.length == kPWDLength) {
            if (self.finish) {
                self.finish(tempStr);
                self.finish = nil;
            }
            tempStr = nil;
        }
        NSMutableDictionary *userInfoDict = [NSMutableDictionary dictionary];
        userInfoDict[CYPasswordViewKeyboardNumberKey] = string;
        [CYNotificationCenter postNotificationName:CYPasswordViewNumberButtonClickNotification object:self userInfo:userInfoDict];
    }
    return YES;
}

/** 输入框的取消按钮点击 */
- (void)cancle
{
    [self hideKeyboard:^(BOOL finished) {
        self.inputView.hidden = YES;
        tempStr = nil;
        [self removeFromSuperview];
        [self hideKeyboard:nil];
        [self.inputView setNeedsDisplay];
    }];
}

#pragma mark  - 公开方法
// 关闭键盘
- (void)hideKeyboard
{
    [self hideKeyboard:nil];
}

- (void)hide {
    [self removeFromSuperview];
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    /** 输入框起始frame */
    self.passwordInputView.height = CYPasswordInputViewHeight;
    self.passwordInputView.y = self.height;
    self.passwordInputView.width = CYScreenWith;
    self.passwordInputView.x = 0;
    /** 弹出键盘 */
    [self showKeyboard];
}

- (void)startLoading {
    [self startRotation:self.imgRotation];
    [CYNotificationCenter postNotificationName:CYPasswordViewDisEnabledUserInteractionNotification object:@{@"enable":@(NO)}];
}

- (void)stopLoading {
    [self stopRotation:self.imgRotation];
    [CYNotificationCenter postNotificationName:CYPasswordViewEnabledUserInteractionNotification object:@{@"enable":@(YES)}];
}

- (void)requestComplete:(BOOL)state {
    if (state) {
        [self requestComplete:state message:@"支付成功"];
    } else {
        [self requestComplete:state message:@"支付失败"];
    }
}
- (void)requestComplete:(BOOL)state message:(NSString *)message {
    if (state) {
        // 请求成功
        self.lblMessage.text = message;
        self.imgRotation.image = [NSBundle cy_successImage];
    } else {
        // 请求失败
        self.lblMessage.text = message;
        self.imgRotation.image = [NSBundle cy_errorImage];
    }
}

#pragma mark  - 私有方法
/** 键盘弹出 */
- (void)showKeyboard {
    [self.txfResponsder becomeFirstResponder];
    [UIView animateWithDuration:CYPasswordViewAnimationDuration delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.passwordInputView.y = (self.height - self.passwordInputView.height);
    } completion:^(BOOL finished) {
        CYLog(@"%@", NSStringFromCGRect(self.passwordInputView.frame));
    }];
}

/** 键盘退下 */
- (void)hideKeyboard:(void (^)(BOOL finished))completion {
    [self.txfResponsder endEditing:NO];
    [UIView animateWithDuration:CYPasswordViewAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.inputView.transform = CGAffineTransformIdentity;
    } completion:completion];
}

/**
 *  开始旋转
 */
- (void)startRotation:(UIView *)view {
    _imgRotation.hidden = NO;
    _lblMessage.hidden = NO;
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 2.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

/**
 *  结束旋转
 */
- (void)stopRotation:(UIView *)view {
    //    _imgRotation.hidden = YES;
    //    _lblMessage.hidden = YES;
    [view.layer removeAllAnimations];
}

#pragma mark - Set 方法
- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.passwordInputView.title = title;
}

- (void)setLoadingText:(NSString *)loadingText {
    _loadingText = [loadingText copy];
    self.lblMessage.text = loadingText;
}

#pragma mark  - 懒加载
- (UIControl *)coverView
{
    if (_coverView == nil)
    {
        _coverView = [[UIControl alloc] init];
        [_coverView setBackgroundColor:[UIColor blackColor]];
        _coverView.alpha = 0.4;
        _coverView.frame = self.bounds;
    }
    return _coverView;
}

- (CYPasswordInputView *)passwordInputView
{
    if (_passwordInputView == nil)
    {
        _passwordInputView = [[CYPasswordInputView alloc] init];
        /** 注册取消按钮点击的通知 */
        [CYNotificationCenter addObserver:self selector:@selector(cancle) name:CYPasswordViewCancleButtonClickNotification object:nil];
    }
    return _passwordInputView;
}

- (UITextField *)txfResponsder
{
    if (_txfResponsder == nil)
    {
        _txfResponsder = [[UITextField alloc] init];
        _txfResponsder.delegate = self;
        _txfResponsder.keyboardType = UIKeyboardTypeNumberPad;
        _txfResponsder.secureTextEntry = YES;
    }
    return _txfResponsder;
}

- (UIImageView *)imgRotation {
    if (_imgRotation == nil) {
        _imgRotation = [[UIImageView alloc] init];
        _imgRotation.image = [NSBundle cy_loadingImage];
        [_imgRotation sizeToFit];
        _imgRotation.hidden = YES;
    }
    return _imgRotation;
}

- (UILabel *)lblMessage {
    if (_lblMessage == nil) {
        _lblMessage = [[UILabel alloc] init];
        _lblMessage.text = @"支付中...";
        _lblMessage.hidden = YES;
        _lblMessage.textColor = [UIColor darkGrayColor];
        _lblMessage.font = CYLabelFont;
        _lblMessage.textAlignment = NSTextAlignmentCenter;
        [_lblMessage sizeToFit];
    }
    return _lblMessage;
}

@end
