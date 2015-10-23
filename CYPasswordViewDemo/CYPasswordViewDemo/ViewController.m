//
//  ViewController.m
//  CYPasswordViewDemo
//
//  Created by cheny on 15/10/8.
//  Copyright © 2015年 zhssit. All rights reserved.
//

#import "ViewController.h"
#import "CYPasswordView.h"
#import "MBProgressHUD+MJ.h"

#define kRequestTime 3.0f
#define kDelay 1.0f

@interface ViewController ()

@property (nonatomic, strong) CYPasswordView *passwordView;

@end

@implementation ViewController

static BOOL flag = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 注册取消按钮点击的通知 */
    [CYNotificationCenter addObserver:self selector:@selector(cancel) name:CYPasswordViewCancleButtonClickNotification object:nil];
    [CYNotificationCenter addObserver:self selector:@selector(forgetPWD) name:CYPasswordViewForgetPWDButtonClickNotification object:nil];
}

- (void)dealloc {
    CYLog(@"cy =========== %@：我走了", [self class]);
}

- (void)cancel {
    CYLog(@"关闭密码框");
    [MBProgressHUD showSuccess:@"关闭密码框"];
}

- (void)forgetPWD {
    CYLog(@"忘记密码");
    [MBProgressHUD showSuccess:@"忘记密码"];
}

- (IBAction)showPasswordView:(id)sender {
    __weak ViewController *weakSelf = self;
    self.passwordView = [[CYPasswordView alloc] init];
    self.passwordView.title = @"输入交易密码";
    self.passwordView.loadingText = @"提交中...";
    [self.passwordView showInView:self.view.window];

    self.passwordView.finish = ^(NSString *password) {
        [weakSelf.passwordView hideKeyboard];
        [weakSelf.passwordView startLoading];
        CYLog(@"cy ========= 发送网络请求  pwd=%@", password);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kRequestTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            flag = !flag;
            if (flag) {
                CYLog(@"申购成功，跳转到成功页");
                [MBProgressHUD showSuccess:@"申购成功，做一些处理"];
                [weakSelf.passwordView requestComplete:YES message:@"申购成功，做一些处理"];
                [weakSelf.passwordView stopLoading];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.passwordView hide];
                });
            } else {
                CYLog(@"申购失败，跳转到失败页");
                [MBProgressHUD showError:@"申购失败，做一些处理"];
                [weakSelf.passwordView requestComplete:NO message:@"申购失败，做一些处理"];
                [weakSelf.passwordView stopLoading];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.passwordView hide];
                });

            }
            
        });
    };
}

@end
