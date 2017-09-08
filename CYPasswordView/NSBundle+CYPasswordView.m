//
//  NSBundle+NSBundle_CYPasswordView.m
//  CYPasswordViewDemo
//
//  Created by apple on 2017/9/8.
//  Copyright © 2017年 zhssit. All rights reserved.
//

#import "NSBundle+CYPasswordView.h"
#import "CYPasswordView.h"

@implementation NSBundle (NSBundle_CYPasswordView)
+ (instancetype)cy_passwordViewBundle
{
    static NSBundle *refreshBundle = nil;
    if (refreshBundle == nil) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        refreshBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[CYPasswordView class]] pathForResource:@"CYPasswordView" ofType:@"bundle"]];
    }
    return refreshBundle;
}

+ (UIImage *)cy_closeImage {
    static UIImage *_image = nil;
    if (_image == nil) {
        _image = [[UIImage imageWithContentsOfFile:[[self cy_passwordViewBundle] pathForResource:@"password_close@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _image;
}
+ (UIImage *)cy_backgroundImage {
    static UIImage *_image = nil;
    if (_image == nil) {
        _image = [[UIImage imageWithContentsOfFile:[[self cy_passwordViewBundle] pathForResource:@"password_background@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _image;
}
+ (UIImage *)cy_textfieldImage {
    static UIImage *_image = nil;
    if (_image == nil) {
        _image = [[UIImage imageWithContentsOfFile:[[self cy_passwordViewBundle] pathForResource:@"password_textfield@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _image;
}
+ (UIImage *)cy_pointImage {
    static UIImage *_image = nil;
    if (_image == nil) {
        _image = [[UIImage imageWithContentsOfFile:[[self cy_passwordViewBundle] pathForResource:@"password_point@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _image;
}
+ (UIImage *)cy_successImage {
    static UIImage *_image = nil;
    if (_image == nil) {
        _image = [[UIImage imageWithContentsOfFile:[[self cy_passwordViewBundle] pathForResource:@"password_success@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _image;
}
+ (UIImage *)cy_errorImage {
    static UIImage *_image = nil;
    if (_image == nil) {
        _image = [[UIImage imageWithContentsOfFile:[[self cy_passwordViewBundle] pathForResource:@"password_error@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _image;
}
+ (UIImage *)cy_loadingImage {
    static UIImage *_image = nil;
    if (_image == nil) {
        _image = [[UIImage imageWithContentsOfFile:[[self cy_passwordViewBundle] pathForResource:@"password_loading_a@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _image;
}

@end
