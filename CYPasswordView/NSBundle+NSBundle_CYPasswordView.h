//
//  NSBundle+NSBundle_CYPasswordView.h
//  CYPasswordViewDemo
//
//  Created by apple on 2017/9/8.
//  Copyright © 2017年 zhssit. All rights reserved.
//  借鉴自：MJRefresh

#import <UIKit/UIKit.h>

@interface NSBundle (NSBundle_CYPasswordView)
+ (instancetype)cy_passwordViewBundle;
+ (UIImage *)cy_closeImage;
+ (UIImage *)cy_backgroundImage;
+ (UIImage *)cy_textfieldImage;
+ (UIImage *)cy_pointImage;
+ (UIImage *)cy_successImage;
+ (UIImage *)cy_errorImage;
+ (UIImage *)cy_loadingImage;

@end
